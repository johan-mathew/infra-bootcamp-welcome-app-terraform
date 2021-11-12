data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_instance" "welcome-demo-prod" {
  ami             = data.aws_ami.amazon_linux_2.id
  instance_type   = "t2.micro"
  subnet_id = aws_subnet.welcome-demo-subnet-public-1.id
  vpc_security_group_ids = [ aws_security_group.welcome-demo-sg.id ]
  key_name        = aws_key_pair.welcome-prod-keypair.key_name
  tags = {
    Name = "welcome-demo-prod-abin-johan"
    Env  = "prod"
  }
#   network_interface {
#     network_interface_id = aws_network_interface.welcome-demo-ni.id
#     device_index         = 0
#   }

  user_data = <<-EOF
    #!/bin/bash
    set -ex
    sudo yum update -y
    sudo amazon-linux-extras install docker -y
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  EOF
}