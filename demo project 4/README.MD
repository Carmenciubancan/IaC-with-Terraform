# Project 4: Remote State Configuration

## What This Does

Configures Terraform to store `.tfstate` files in an S3 bucket instead of locally. 
This enables team collaboration and prevents state file conflicts. the S3 will always have the most up to date Terraform state.

## Implementation

Add the `backend "s3"` block to **providers.tf** file:
```hcl
terraform {
  required_version = ">= 0.12"
  
  backend "s3" {
    bucket = "carmen's-unique-bucket-name"  # 
    key    = "terraform-demo/state.tfstate"  # Path inside bucket
    region = "eu-central-1"
  }
}

provider "aws" {
  region = "eu-central-1"
}
```




