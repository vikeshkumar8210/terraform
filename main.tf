Skip to content
Search or jump to…
Pull requests
Issues
Codespaces
Marketplace
Explore
 
@vikeshkumar8210 
TeknoPathshala
/
aws-repo
Public
Fork your own copy of TeknoPathshala/aws-repo
Code
Issues
Pull requests
Actions
Projects
Security
Insights
aws-repo/main.tf
@mydevopscoach
mydevopscoach Update main.tf
Latest commit 6549cc8 on Jul 2, 2021
 History
 1 contributor
55 lines (48 sloc)  1.04 KB

provider "aws" {
  region = var.aws_region
}

#Create security group with firewall rules
resource "aws_security_group" "my_security_group" {
  name        = var.security_group
  description = "security group for Ec2 instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}

# Create AWS ec2 instance
resource "aws_instance" "myFirstInstance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = var.tag_name
  }
}

# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  vpc      = true
  instance = aws_instance.myFirstInstance.id
tags= {
    Name = "my_elastic_ip"
  }
}
Footer
© 2023 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
aws-repo/main.tf at main · TeknoPathshala/aws-repo
