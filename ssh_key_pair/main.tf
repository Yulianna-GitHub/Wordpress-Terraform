# Create SSH key
resource "aws_key_pair" "wordpress_ssh_key" {
  key_name   = var.key_name
  public_key = var.public_key    

  tags = {
    Name = var.key_name
  }
}