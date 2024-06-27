variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "192.168.0.0/16"
}

variable "key_name" {
  description = "The name of the SSH key pair"
}

variable "public_key" {
  description = "The public key for SSH access"
}

variable "instance_type" {
  description = "The EC2 instance type"
  default     = "t3.micro"
}

variable "db_name" {
  description = "The name of the RDS database"
  default     = "my_database"
}

variable "db_user" {
  description = "The username for the RDS database"
  default     = "admin"
}

variable "db_password" {
  description = "The password for the RDS database"
  default     = "adminadmin"
}
