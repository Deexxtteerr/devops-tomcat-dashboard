#!/bin/bash

# Update system packages
apt-get update -y

# Install Docker
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

# Install Git (for deployment scripts)
apt-get install -y git

# Install Java 17 (for running applications)
apt-get install -y openjdk-17-jdk

# Create deployment directory
mkdir -p /opt/deployment
chown ubuntu:ubuntu /opt/deployment

# Install unzip utility
apt-get install -y unzip

echo "Tomcat server setup completed!"
