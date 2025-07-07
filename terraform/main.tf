terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Create VPC (Virtual Private Cloud)
resource "aws_vpc" "devops_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "devops-vpc"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "devops_igw" {
  vpc_id = aws_vpc.devops_vpc.id

  tags = {
    Name = "devops-igw"
  }
}

# Create Public Subnet
resource "aws_subnet" "devops_public_subnet" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "devops-public-subnet"
  }
}
# Create Route Table
resource "aws_route_table" "devops_public_rt" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_igw.id
  }

  tags = {
    Name = "devops-public-rt"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "devops_public_rta" {
  subnet_id      = aws_subnet.devops_public_subnet.id
  route_table_id = aws_route_table.devops_public_rt.id
}
# Create Security Group for Jenkins Server
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-security-group"
  description = "Security group for Jenkins server"
  vpc_id      = aws_vpc.devops_vpc.id

  # SSH access (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins web interface (port 8080)
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All outbound traffic allowed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}

# Create Security Group for Tomcat Server
resource "aws_security_group" "tomcat_sg" {
  name        = "tomcat-security-group"
  description = "Security group for Tomcat server"
  vpc_id      = aws_vpc.devops_vpc.id

  # SSH access (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tomcat default port (8080)
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Your DevOps Dashboard port (9090)
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All outbound traffic allowed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tomcat-sg"
  }
}
# Create SSH Key Pair for EC2 Access
resource "aws_key_pair" "devops_key" {
  key_name   = "devops-key"
  public_key = file("~/.ssh/devops-key.pub")

  tags = {
    Name = "devops-ssh-key"
  }
}
# Create Jenkins EC2 Instance
resource "aws_instance" "jenkins_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  subnet_id              = aws_subnet.devops_public_subnet.id
  user_data              = file("user-data-jenkins.sh")

  tags = {
    Name = "Jenkins-Server"
  }
}

# Create Tomcat EC2 Instance
resource "aws_instance" "tomcat_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.tomcat_sg.id]
  subnet_id              = aws_subnet.devops_public_subnet.id
  user_data              = file("user-data-tomcat.sh")

  tags = {
    Name = "Tomcat-Server"
  }
}
