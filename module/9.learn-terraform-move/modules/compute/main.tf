data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "example" {
  ami                         = data.aws_ami.ubuntu.id
#   subnet_id                   = module.vpc.public_subnets[0]  # 삭제
  subnet_id                   = var.public_subnets[0]   # 추가
  instance_type               = "t2.micro"
#   vpc_security_group_ids      = [module.security_group.security_group_id]   #삭제
  vpc_security_group_ids      = [var.security_group]   # 추가
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              sed -i -e 's/80/8080/' /etc/apache2/ports.conf
              echo "Hello World" > /var/www/html/index.html
              systemctl restart apache2
              EOF
  tags = {
    Name = "t104-move-ec2"
  }
}
