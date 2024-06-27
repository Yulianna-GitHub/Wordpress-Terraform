# Create the VPC
resource "aws_vpc" "wordpress_vpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "wordpress-vpc"
  }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "wordpress_igw" {
  vpc_id = aws_vpc.wordpress_vpc.id

  tags = {
    Name = "wordpress_igw"
  }
}

# Create the Route Table for public subnets
resource "aws_route_table" "wordpress_public_rt" {
  vpc_id = aws_vpc.wordpress_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress_igw.id
  }

  tags = {
    Name = "wordpress_public_rt"
  }
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "wordpress_nat_eip" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "wordpress_nat_gw" {
  allocation_id = aws_eip.wordpress_nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id # Use one of the public subnets

  tags = {
    Name = "nat-gw"
  }
}

# Create the Route Table for private subnets
resource "aws_route_table" "wordpress_private_rt" {
  vpc_id = aws_vpc.wordpress_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.wordpress_nat_gw.id
  }

  tags = {
    Name = "wordpress_private_rt"
  }
}

# Create Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = "192.168.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "public-subnet-3"
  }
}

# Associate Public Subnets with the Route Table
resource "aws_route_table_association" "public_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.wordpress_public_rt.id
}

resource "aws_route_table_association" "public_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.wordpress_public_rt.id
}

resource "aws_route_table_association" "public_association_3" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.wordpress_public_rt.id
}

# Create Private Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = "192.168.128.0/18"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = "192.168.192.0/19"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = "192.168.224.0/19"
  availability_zone = "us-east-1c"

  tags = {
    Name = "private-subnet-3"
  }
}

# Associate Private Subnets with the Private Route Table
resource "aws_route_table_association" "private_association_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.wordpress_private_rt.id
}

resource "aws_route_table_association" "private_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.wordpress_private_rt.id
}

resource "aws_route_table_association" "private_association_3" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.wordpress_private_rt.id
}

# Create DB Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
    aws_subnet.private_subnet_3.id
  ]

  tags = {
    Name = "db_subnet_group"
  }
}
