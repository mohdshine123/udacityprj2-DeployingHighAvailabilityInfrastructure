resource "random_string" "random" {
    count = var.instance_count
    length = 4
    special = false
    upper   = false
}

resource "aws_instance" "udacity_webserver" {
  ami           = var.ami_id
  instance_type = var.instance_type
  count = var.instance_count

  tags = {
    Name = "appserver-instance-aw${random_string.random[count.index].result}"
  }
}