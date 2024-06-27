variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
  #default     = "wordpress_ssh_key"
}

variable "public_key" {
description = "The public key to be used for the SSH key pair"
  type        = string 
  #default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDo5MNpV23HjiBs7TuDjN1Rj0E00jYWDF6PN/o+YJLZSx+FU0VK3nQfoD+QnF7+uG9dp65iytWm88zqQyhMa7vHdUGNf+735yfl4WlyDpDgLaWrQYvkc9hBtVDp03SJB95jaS8eVWWAtijzzxFoI9Qau+BMgj/tbErdcsVefCrowFE8atjt/DMiHQD7TZoh/txQHlPUNlsEStS9L/DddS97+ifbjiYPgCp2R8F8+28amgRhdeNFUNxNfNwk7RPq7P0wsm4F/CmHChf7kxUHe4Z5JeZzjKQqvalA5bDfisJ6fxlnSmXwjCrAsRs0Z31xKkcEOUzEIRhk7V9vpWYBrtJr33INBUegvl/25PPl7RR9jzNzU2826ax0u7d+zLnXDtXfoluF9PjqQyYUuakSIhIO+48UZ9Qe0VgUUTR/N3skxKFuzXqie9tdY11g2YmBMxHMyZMmMSSM+OvSu0Cf39o1kT1x+UEkOh1eY5oEcbBxHw7yiPfLm2HjqxowIvwSxz0="
}
