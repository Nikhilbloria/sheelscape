provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "shellscape_server" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t3.micro"
  subnet_id                   = "subnet-017b51801b738107a"
  associate_public_ip_address = true
  key_name                    = "shellscape-key"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install docker -y
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo docker pull nikhilbloria/shellscape
              sudo docker run -d -p 80:80 nikhilbloria/shellscape
              EOF

  tags = {
    Name = "ShellScape-Server"
  }
}