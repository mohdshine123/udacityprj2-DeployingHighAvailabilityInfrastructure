resource "aws_instance" "instance" {
  count                = length(aws_subnet.public_subnet.*.id)
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = element(aws_subnet.public_subnet.*.id, count.index)
  #security_groups      = [aws_security_group.sg.id, ]
  #key_name             = "Keypair-01"
  #iam_instance_profile = data.aws_iam_role.iam_role.name

  tags = {
    "Name"        = "UdacityInstance-${count.index}"
    "Environment" = "Test"
    "CreatedBy"   = "Terraform"
  }

  timeouts {
    create = "10m"
  }

}