output "key_name" {
  description = "The name of the SSH key pair"
  value       = aws_key_pair.wordpress_ssh_key.key_name
}
