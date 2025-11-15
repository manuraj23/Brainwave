resource "aws_instance" "app_server" {
  ami           = "ami-0cae6d6fe6048ca2c" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = var.react

  tags = {
    Name = "ReactAppServer"
  }

  provisioner "remote-exec" {
    inline = ["sudo yum install -y docker", "sudo service docker start"]
  }
}