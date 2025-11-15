resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = var.key_name

  tags = {
    Name = "ReactAppServer"
  }

  provisioner "remote-exec" {
    inline = ["sudo yum install -y docker", "sudo service docker start"]
  }
}