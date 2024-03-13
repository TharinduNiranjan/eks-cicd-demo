resource "aws_eks_cluster" "eks" {


  name     = "dev_cluster"
  role_arn = var.eks_cluster_role_arn
  version  = "1.28"
  vpc_config {
    subnet_ids = var.private_subnet
    # endpoint_private_access = true
    # endpoint_public_access  = false
  }

  tags = {
    Name = "dev_cluster"
  }

}
