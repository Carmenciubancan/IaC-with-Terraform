# Project 5: Complete CI/CD with Terraform


#### Integrate a provisioning stage into a CI/CD Pipeline to automate the provisioning of a server.

1. Create SSH Key Pair
2. Install Terraform inside Jenkins container
3. Add Terraform configuration to application’s git repository
4. Adjust Jenkinsfile to add “provision” step to the CI/CD pipeline that provisions EC2 instance

The complete CI/CD project has the following configuration:
a. CI step: Build artifact for Java Maven application
b. CI step: Build and push Docker image to Docker Hub
c. CD step: Automatically provision EC2 instance using TF
d. CD step: Deploy new application version on the provisioned EC2 instance with Docker Compose




├── .gitignore (protects secrets)
├── Jenkinsfile (jenkins pipeline definition)
├── Dockerfile (containerizes the app)
├── docker-compose.yaml (runs app + database)
├── pom.xml (Maven build config)
├── server-cmds.sh (deployment script)
├── src/main/java/com/example/
│   └── Application.java (Spring Boot app)
└── terraform/
    ├── main.tf (infrastructure code)
    ├── variables.tf (values conf)
    └── entry-script.sh (EC2 setup)


