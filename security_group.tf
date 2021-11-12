resource "aws_security_group" "welcome-demo-sg" {
  vpc_id      = aws_vpc.welcome-demo-vpc.id
  name        = "welcome-demo-sg"
  description = "security group for my instance"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["49.37.190.78/32"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["49.37.190.78/32"]
  }

  tags = {
    Name = "welcome-demo-sg-johan-abin"
  }
}