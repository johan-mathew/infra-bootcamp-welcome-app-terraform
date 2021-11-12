resource "aws_vpc" "welcome-demo-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "welcome-demo-prod-vpc-abin-johan"
  }
}

resource "aws_subnet" "welcome-demo-subnet-public-1" {
  vpc_id                  = aws_vpc.welcome-demo-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "welcome-demo-subnet-abin-johan-public-1"
  }
}

resource "aws_network_interface" "welcome-demo-ni" {
  subnet_id   = aws_subnet.welcome-demo-subnet-public-1.id
  private_ips = ["10.0.1.100"]
  security_groups = [aws_security_group.welcome-demo-sg.id]
  tags = {
    Name = "primary_network_interface"
  }
}