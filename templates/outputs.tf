output "domain-name" {
  value = aws_instance.web.public_dns
}

output "application-url" {
  value = "${aws_instance.web.public_dns}/index.php"
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}
