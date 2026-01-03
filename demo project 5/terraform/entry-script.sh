#!/bin/bash

# Update system packages and install Docker
sudo yum update -y && sudo yum install -y docker

# Start Docker service
sudo systemctl start docker

# Add ec2-user to docker group to run Docker without sudo
sudo usermod -aG docker ec2-user

# Install Docker Compose
# Downloads the binary from GitHub
sudo curl -SL "https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose

# Make Docker Compose executable
sudo chmod +x /usr/local/bin/docker-compose