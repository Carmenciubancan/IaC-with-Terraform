terraform {
  required_version = ">= 0.12"
  
  # Remote state storage in S3 (Project 4 integration)
  backend "s3" {
    bucket = "carmen-terraform-demo-state"  #created manually
    key    = "terraform-demo/state.tfstate"  # Path within bucket
    region = "eu-central-1"
  }
}


provider "aws" {
  region = var.region 
}

# VPC - The network foundation
resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block  # IP range for entire VPC
  tags = {
    Name: "${var.env_prefix}-vpc" 
  }
}

# Subnet - A segment within the VPC
resource "aws_subnet" "myapp-subnet-1" {
  vpc_id            = aws_vpc.myapp-vpc.id
  cidr_block        = var.subnet_cidr_block  # Smaller IP range (10.0.10.0/24)
  availability_zone = var.avail_zone
  tags = {
    Name: "${var.env_prefix}-subnet-1"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = aws_vpc.myapp-vpc.id
  tags = {
    Name: "${var.env_prefix}-igw"
  }
}

# Route Table (routes all traffic to internet gateway)
resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"  # All traffic
    gateway_id = aws_internet_gateway.myapp-igw.id  # Goes through internet gateway
  }
  tags = {
    Name: "${var.env_prefix}-main-rtb"
  }
}

# Security Group
resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.myapp-vpc.id

  # Inbound rule: Allow SSH from my IP and Jenkins IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [var.my_ip, var.jenkins_ip]
  }

  # Inbound rule: Allow app traffic on port 8080 from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule: Allow all outgoing traffic
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"  # -1 means all protocols
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name: "${var.env_prefix}-default-sg"
  }
}

# Data source: Find latest Amazon Linux 2 AMI (instead of hardcoding AMI ID)
data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name" 
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# EC2 Instance
resource "aws_instance" "myapp-server" {
  ami                    = data.aws_ami.latest-amazon-linux-image.id  # Use latest Amazon Linux 2
  instance_type          = var.instance_type  # t2.micro

  subnet_id              = aws_subnet.myapp-subnet-1.id
  vpc_security_group_ids = [aws_default_security_group.default-sg.id]
  availability_zone      = var.avail_zone

  associate_public_ip_address = true  # Give it a public IP so we can access it
  key_name                    = "carmen-aws-key"

  user_data = file("entry-script.sh")  # Runs this script on first boot (installs Docker)

  user_data_replace_on_change = true  # If entry-script changes, recreate instance

  tags = {
    Name: "${var.env_prefix}-server"
  }
}

# Display the EC2 public IP after provisioning
output "ec2-public_ip" {
  value = aws_instance.myapp-server.public_ip
}