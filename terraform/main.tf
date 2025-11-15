resource "aws_instance" "app_server" {
  ami           = "ami-03695d52f0d883f65" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = var.key_name

  tags = {
    Name = "ReactAppServer"
  }

  provisioner "remote-exec" {
    inline = ["sudo yum install -y docker", "sudo service docker start"]
  }
}