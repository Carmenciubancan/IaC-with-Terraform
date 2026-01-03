# Project 5: Complete CI/CD with Terraform

## Overview

Integrate a provisioning stage into a CI/CD Pipeline to automate the provisioning of a server.

## Setup Steps

1. Create SSH Key Pair
2. Install Terraform inside Jenkins container
3. Add Terraform configuration to application's git repository
4. Adjust Jenkinsfile to add "provision" step to the CI/CD pipeline that provisions EC2 instance

## Pipeline Stages

**a. CI step:** Build artifact for Java Maven application  
**b. CI step:** Build and push Docker image tso Docker Hub  
**c. CD step:** Automatically provision EC2 instance using Terraform  
**d. CD step:** Deploy new application version on the provisioned EC2 instance with Docker Compose

## Project Structure
```
project-5/
├── .gitignore                          # Protects secrets
├── Jenkinsfile                         # Jenkins pipeline definition
├── Dockerfile                          # Containerizes the app
├── docker-compose.yaml                 # Runs app + database
├── pom.xml                             # Maven build config
├── server-cmds.sh                      # Deployment script
├── src/main/java/com/example/
│   └── Application.java                # Spring Boot app
└── terraform/
    ├── main.tf                         # Infrastructure code
    ├── variables.tf                    # Configuration values
    └── entry-script.sh                 # EC2 setup script
```

