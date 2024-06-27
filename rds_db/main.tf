resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}


resource "aws_db_instance" "mysql" {
 allocated_storage     = var.db_allocated_storage
  storage_type         = var.db_storage_type
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  db_name              = var.db_name
  username             = var.db_user
  password             = var.db_password
  db_subnet_group_name = var.db_subnet_group_name
  vpc_security_group_ids = [var.security_group_id]

  skip_final_snapshot = true


  tags = {
    Name = "wordpress-db"
  }
}
