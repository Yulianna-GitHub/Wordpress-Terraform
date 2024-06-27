output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "wordpress_sg_id" {
  value = module.security_groups.wordpress_sg_id
}

output "rds_sg_id" {
  value = module.security_groups.rds_sg_id
}

output "db_address" {
  value = module.rds_db.db_address
}

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

