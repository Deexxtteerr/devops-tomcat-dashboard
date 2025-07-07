output "jenkins_public_ip" {
  description = "Public IP address of Jenkins server"
  value       = aws_instance.jenkins_server.public_ip
}

output "tomcat_public_ip" {
  description = "Public IP address of Tomcat server"
  value       = aws_instance.tomcat_server.public_ip
}

output "jenkins_url" {
  description = "Jenkins web interface URL"
  value       = "http://${aws_instance.jenkins_server.public_ip}:8080"
}

output "tomcat_url" {
  description = "Tomcat application URL"
  value       = "http://${aws_instance.tomcat_server.public_ip}:8080"
}

output "devops_dashboard_url" {
  description = "Your DevOps Dashboard URL"
  value       = "http://${aws_instance.tomcat_server.public_ip}:9090/devops-dashboard"
}

output "ssh_jenkins" {
  description = "SSH command to connect to Jenkins server"
  value       = "ssh -i ~/.ssh/devops-key ubuntu@${aws_instance.jenkins_server.public_ip}"
}

output "ssh_tomcat" {
  description = "SSH command to connect to Tomcat server"
  value       = "ssh -i ~/.ssh/devops-key ubuntu@${aws_instance.tomcat_server.public_ip}"
}
