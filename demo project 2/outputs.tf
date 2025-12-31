# Displays the public IP of the EC2 instance after deployment
# Access it from the webserver module's output
output "ec2_public_ip" {
  value = module.myapp-server.instance.public_ip
}