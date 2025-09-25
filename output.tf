output "public_ip" {
  value       = { for key, intance in aws_instance.web : key => intance.public_ip }
  description = "The public IP address of the web instance"
}