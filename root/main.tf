data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

module "vpc" {
  source = "../vpc"
  key_name = "wordpress_ssh_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDo5MNpV23HjiBs7TuDjN1Rj0E00jYWDF6PN/o+YJLZSx+FU0VK3nQfoD+QnF7+uG9dp65iytWm88zqQyhMa7vHdUGNf+735yfl4WlyDpDgLaWrQYvkc9hBtVDp03SJB95jaS8eVWWAtijzzxFoI9Qau+BMgj/tbErdcsVefCrowFE8atjt/DMiHQD7TZoh/txQHlPUNlsEStS9L/DddS97+ifbjiYPgCp2R8F8+28amgRhdeNFUNxNfNwk7RPq7P0wsm4F/CmHChf7kxUHe4Z5JeZzjKQqvalA5bDfisJ6fxlnSmXwjCrAsRs0Z31xKkcEOUzEIRhk7V9vpWYBrtJr33INBUegvl/25PPl7RR9jzNzU2826ax0u7d+zLnXDtXfoluF9PjqQyYUuakSIhIO+48UZ9Qe0VgUUTR/N3skxKFuzXqie9tdY11g2YmBMxHMyZMmMSSM+OvSu0Cf39o1kT1x+UEkOh1eY5oEcbBxHw7yiPfLm2HjqxowIvwSxz0="
}

module "security_groups" {
  source = "../security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ssh_key_pair" {
  source = "../ssh_key_pair"
  key_name   = "wordpress_ssh_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDo5MNpV23HjiBs7TuDjN1Rj0E00jYWDF6PN/o+YJLZSx+FU0VK3nQfoD+QnF7+uG9dp65iytWm88zqQyhMa7vHdUGNf+735yfl4WlyDpDgLaWrQYvkc9hBtVDp03SJB95jaS8eVWWAtijzzxFoI9Qau+BMgj/tbErdcsVefCrowFE8atjt/DMiHQD7TZoh/txQHlPUNlsEStS9L/DddS97+ifbjiYPgCp2R8F8+28amgRhdeNFUNxNfNwk7RPq7P0wsm4F/CmHChf7kxUHe4Z5JeZzjKQqvalA5bDfisJ6fxlnSmXwjCrAsRs0Z31xKkcEOUzEIRhk7V9vpWYBrtJr33INBUegvl/25PPl7RR9jzNzU2826ax0u7d+zLnXDtXfoluF9PjqQyYUuakSIhIO+48UZ9Qe0VgUUTR/N3skxKFuzXqie9tdY11g2YmBMxHMyZMmMSSM+OvSu0Cf39o1kT1x+UEkOh1eY5oEcbBxHw7yiPfLm2HjqxowIvwSxz0="
}

module "rds_db" {
  source = "../rds_db"
  db_allocated_storage  = "20"
  db_storage_type       = "gp2"
  db_engine             = "mysql"
  db_engine_version     = "5.7"
  db_instance_class     = "db.t3.micro"
  db_name               = "mydatabase"
  db_user               = "admin"
  db_password           = "adminadmin"
  db_subnet_ids         = module.vpc.private_subnet_ids
  security_group_id     = module.security_groups.wordpress_sg_id
  db_subnet_group_name  = "rds-subnet-group"
  rds_sg_id             = module.security_groups.rds_sg_id
}

module "ec2" {
  source                 = "../ec2"
  instance_type          = "t3.micro"
  key_name               = module.ssh_key_pair.key_name
  security_group_id      = module.security_groups.wordpress_sg_id
  subnet_id              = module.vpc.public_subnet_ids[0]
  db_name                = "mydatabase"
  db_user                = "admin"
  db_password            = "adminadmin"
  ami                    = data.aws_ami.amazon_linux.id
  db_address             = module.rds_db.db_address
  db_endpoint            = module.rds_db.db_address
}