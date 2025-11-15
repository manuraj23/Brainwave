resource "aws_instance" "app_server" {
  ami           = "ami-0cae6d6fe6048ca2c" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = "react"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name = "ReactAppServer"
  }

  provisioner "remote-exec" {
    inline = ["sudo yum install -y docker", "sudo service docker start"]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/react.pem")
      host        = self.public_ip
    }
  }
}
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound from anywhere (use a narrower CIDR in production)"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}