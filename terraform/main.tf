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