module "ec2_instance" {
  source         = "./modules/EC2"
  instance_type  = "t2.micro"
  instance_count = 1
  vpc_id         = "vpc-077baef119aed7908"
}
