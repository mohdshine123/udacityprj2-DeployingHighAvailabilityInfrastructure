module "ec2_instance" {
  source         = "./ec2_instance"
  instance_type  = "t2.micro"
  instance_count = 4
  vpc_id         = "vpc-077baef119aed7908"
}