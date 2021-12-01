module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "oktest"
  cidr = var.vpc_cidr
  azs             = var.vpc_azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  enable_nat_gateway = true
}
