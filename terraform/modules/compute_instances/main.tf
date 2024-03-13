resource "aws_key_pair" "user_key_pair" {
  key_name   = "user_key_pair"
  public_key = file("/home/tharindu-107455/.ssh/id_rsa.pub")
}

resource "aws_instance" "nginx_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.public_security_group]
  subnet_id              = var.public_subnet[0]
  key_name               = aws_key_pair.user_key_pair.key_name

  tags = {
    Name = "nginx_server"
  }
}

resource "aws_instance" "tool_servers" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.private_security_group]
  subnet_id              = var.private_subnet[0]
  key_name               = aws_key_pair.user_key_pair.key_name

  for_each = toset(["jenkins_server", "sonarqube_server"])
  tags = {
    Name = "${each.key}"
  }
}
