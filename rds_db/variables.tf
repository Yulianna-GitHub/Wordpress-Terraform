variable "db_subnet_ids" {
  description = "List of subnet IDs for the RDS DB"
  type        = list(string)
}

variable "security_group_id" {
  description = "The security group ID for the RDS DB"
  type        = string
}

variable "db_allocated_storage" {
  type        = number
  #default     = 20
}

variable "db_storage_type" {
  type        = string
  #default     = "gp2"
}

variable "db_engine" {
  type        = string
  #default     = "mysql"
}

variable "db_engine_version" {
  type        = string
  #default     = "5.7"
}

variable "db_instance_class" {
  type        = string
  #default     = "db.t2.micro"
}

variable "db_user" {
  type        = string
  #default     = "admin"
}

variable "db_password" {
  type        = string
  #default     = "adminadmin"
}

variable "db_name" {
  type        = string
  #default     = "mysql"
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}

variable "rds_sg_id" {
  description = "The security group ID for the RDS instance"
  type        = string
}