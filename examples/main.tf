module "ambiente-setup-ec2" {
  source  = "dantas-4cloud/ambiente-setup-ec2/aws"
  version = "1.0.1"
  nome    = "exemplo_simples"
}