resource "aws_instance" "wordpress_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "wordpress-ec2"
  }

 user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install -y php7.2
              yum install -y httpd mysql php php-mysqlnd wget
              systemctl start httpd
              systemctl enable httpd
              cd /var/www/html
              wget https://wordpress.org/latest.tar.gz
              tar -xzf latest.tar.gz
              cp -r wordpress/* .
              rm -rf wordpress latest.tar.gz
              chown -R apache:apache /var/www/html
              chmod -R 755 /var/www/html
              cp wp-config-sample.php wp-config.php
              sed -i "s/database_name_here/${var.db_name}/" wp-config.php
              sed -i "s/username_here/${var.db_user}/" wp-config.php
              sed -i "s/password_here/${var.db_password}/" wp-config.php
              sed -i "s/localhost/${var.db_address}/" wp-config.php
              systemctl restart httpd
              EOF

  
}
