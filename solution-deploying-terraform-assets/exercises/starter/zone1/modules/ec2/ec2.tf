resource "aws_instance" "ubuntu" {
  ami           = "ami-0b9064170e32bde34"
  count = 1
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "webserver"
  }
}

resource "aws_security_group" "ec2_sg" {
 
}
