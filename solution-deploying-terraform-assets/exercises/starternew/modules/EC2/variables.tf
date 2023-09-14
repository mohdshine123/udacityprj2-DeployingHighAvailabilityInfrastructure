variable "instance_count" {
    type = number
}

variable "ami_id" {
  type    = string
  default = "ami-0b9064170e32bde34"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}