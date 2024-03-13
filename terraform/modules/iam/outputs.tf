output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_master.arn
}

output "node_group_role_arn" {
  value = aws_iam_role.node_group.arn
}

output "node_policy_arn" {
  value = aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy.policy_arn
}

output "cni_policy_arn" {
  value = aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy.policy_arn
}

output "ecr_read_policy_arn" {
  value = aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly.policy_arn
}
