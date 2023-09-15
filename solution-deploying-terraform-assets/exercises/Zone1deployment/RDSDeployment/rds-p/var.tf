#variable "private_subnet_ids" {
 # description = "Subnets for RDS Instances"
  #type        = "list"
  #default = [["subnet-09cb7ebf0a6d90c21", "subnet-0bf719c0c9206918c"]]
#}

#variable "vpc_id" {
 # description = "VPC for RDS instance"
  #type        = string
  #default     = "10.0.0.0/16"
#}
variable "db_password" {
  description = "RDS root user password"
  sensitive   = true
}
