resource "aws_eks_node_group" "dev_node_group" {
  cluster_name    = var.eks_cluster_name
  node_group_name = "dev_node_group"
  node_role_arn   = var.node_group_role_arn
  subnet_ids      = var.subnet_ids
  #ami_type        = var.ami_id
  instance_types = [var.instance_type]
  capacity_type  = "SPOT"

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key               = var.keypair_name
    source_security_group_ids = [var.private_security_group]
  }
  tags = {
    Name = "dev_node_group"
  }


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    var.node_policy_arn,
    var.cni_policy_arn,
    var.ecr_read_policy_arn,
  ]

}
