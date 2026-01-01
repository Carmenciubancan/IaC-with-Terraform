# Project 3: EKS Cluster with Public Modules


This project uses **public Terraform modules** from the Terraform Registry instead of writing everything from scratch.

## The Modules

- **terraform-aws-modules/vpc/aws** 
- **terraform-aws-modules/eks/aws** 


## Run
```bash
terraform init    # Download AWS provider + public modules
terraform plan    # Preview what will be created
terraform apply   # Provision resources on AWS
```