module "networking" {
  source             = "./modules/networking"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  private_cidrs      = var.private_cidrs
  public_cidrs       = var.public_cidrs
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.networking.vpc_id
}

module "compute_instances" {
  source                 = "./modules/compute_instances"
  vpc_id                 = module.networking.vpc_id
  public_subnet          = module.networking.public_subnet
  private_subnet         = module.networking.private_subnet
  public_security_group  = module.security_groups.public_security_group
  private_security_group = module.security_groups.private_security_group
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
}

module "iam" {
  source = "./modules/iam"
}

module "eks" {
  source               = "./modules/eks"
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  private_subnet       = module.networking.private_subnet
}

module "node_group" {
  source                 = "./modules/node_group"
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  subnet_ids             = module.networking.private_subnet
  node_group_role_arn    = module.iam.node_group_role_arn
  eks_cluster_name       = module.eks.eks_cluster
  node_policy_arn        = module.iam.node_policy_arn
  cni_policy_arn         = module.iam.cni_policy_arn
  ecr_read_policy_arn    = module.iam.ecr_read_policy_arn
  keypair_name           = module.compute_instances.keypair_name
  private_security_group = module.security_groups.private_security_group
}
