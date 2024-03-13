variable "vpc_id" {
  type = string
}

variable "public_subnet" {
  type = list(any)
}

variable "private_subnet" {
  type = list(any)
}

variable "public_security_group" {
  type = string
}

variable "private_security_group" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}
