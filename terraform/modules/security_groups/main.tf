resource "aws_security_group" "public_security_group" {
  vpc_id      = var.vpc_id
  name        = "public_security_group"
  description = "public access security group"

  ingress {
    from_port   = 22
    description = "allow ssh access over the internet"
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

  ingress {
    from_port   = 80
    description = "allow http access over the internet"
    to_port     = 80
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

resource "aws_security_group" "private_security_group" {
  vpc_id      = var.vpc_id
  name        = "private_security_group"
  description = "Private servers access security group"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    description     = "ssh acesss from the bastion host"
    security_groups = [aws_security_group.public_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
}
