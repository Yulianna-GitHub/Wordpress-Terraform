

output "db_address" {
  value = var.db_address
}

output "instance_id" {
  value = aws_instance.wordpress_ec2.id
}

output "public_ip" {
  value = aws_instance.wordpress_ec2.public_ip
}