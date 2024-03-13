variable "node_group_role_arn" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_ids" {
  type = list(any)
}

variable "eks_cluster_name" {
  type = string
}

variable "node_policy_arn" {
  type = string
}

variable "cni_policy_arn" {
  type = string
}

variable "ecr_read_policy_arn" {
  type = string
}

variable "keypair_name" {
  type = string
}

variable "private_security_group" {
  type = string
}
