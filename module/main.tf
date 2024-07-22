module "vpc" {
  source   = "./stage/vpc"
  vpc_cidr = "10.0.0.0/16"
}
module "ec2" {
  source   = "./stage/ec2"
  vpc_id         = module.vpc.vpc_id
  ec2_type       = "t2.micro"
  ec2_ami        = ""
  public_subnet  = module.vpc.public_subnet
  private_subnet = module.vpc.private_subnet
}
