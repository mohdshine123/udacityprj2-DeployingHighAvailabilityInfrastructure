data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                 = "Udacity-rds"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_db_subnet_group" "udacity_db_subnet_group" {
  name       = "udacity_db_subnet_group"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "udacity_db_subnet_group"
  }
}

resource "aws_security_group" "rds_sg1" {
  name   = "education_rds1"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "education_rds1"
  }
}

resource "aws_rds_cluster_parameter_group" "cluster_pg" {
  name   = "udacity-pg-p"
  family = "aurora-mysql"

#lifecycle {
    #create_before_destroy = true
#}
  #parameter {
   # name  = "binlog_format"    
   # value = "MIXED"
   # apply_method = "pending-reboot"
  #}

  #parameter {
    #name = "log_bin_trust_function_creators"
    #value = 1
    #apply_method = "pending-reboot"
  #}
}


resource "aws_db_parameter_group" "education" {
  name   = "education"
  family = "aurora-mysql"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_rds_cluster" "udacity_cluster" {
  cluster_identifier       = "udacity-db-cluster"
  #availability_zones       = ["us-east-2a", "us-east-2b", "us-east-2c"]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.cluster_pg.name
  database_name            = "udacityc2"
  master_username          = "udacity"
  master_password          = "MyUdacityPassword"
  #vpc_security_group_ids   = [aws_security_group.db_sg_1.id]
  vpc_security_group_ids   = [aws_security_group.rds_sg1.id]
  db_subnet_group_name     = aws_db_subnet_group.udacity_db_subnet_group.name
  #vpc_security_group_ids = var.vpc_security_group_ids
  #db_subnet_group_name   = var.db_subnet_group_name
  #db_cluster_parameter_group_name   = var.db_cluster_parameter_group_name
  #engine_mode              = "provisioned"
  #engine_version           = "5.6.mysql_aurora.1.19.1" 
  engine                 = "aurora-mysql"
  engine_version         = "15.3"
  #allocated_storage      = 20
  skip_final_snapshot      = true
  storage_encrypted        = false
  backup_retention_period  = 5
  depends_on = [aws_rds_cluster_parameter_group.cluster_pg]
}



output "db_cluster_arn" {
  description = "The ARN of the RDS Cluster"
  value = aws_rds_cluster.udacity_cluster.arn
}


resource "aws_rds_cluster_instance" "udacity_instance" {
  count                = 2
  identifier           = "udacity-db-instance-${count.index}"
  cluster_identifier   = aws_rds_cluster.udacity_cluster.id
  instance_class       = "db.m5.large"
  #allocated_storage      = 20
  availability_zone      =data.aws_availability_zones.available.names[count.index]
  db_subnet_group_name = aws_db_subnet_group.udacity_db_subnet_group.name
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_rds_cluster_instance.udacity_instance.arn[count.index]
}

#resource "aws_db_instance" "udacity_instance" {
 # count                  =2
 # identifier             = "udacity-db-instance-${count.index}"
  #availability_zone      =data.aws_availability_zones.available.names[0]
  #availability_zone      =data.aws_availability_zones.available.names[count.index]
  #azs                    = data.aws_availability_zones.available.names
  #availability_zones      = module.vpc.azs
  #availability_zone     = ["us-east-2a", "us-east-2b"]
  #instance_class         = "db.m5.large"
  #allocated_storage      = 20
  #engine                 = "postgres"
  #engine_version         = "15.3"
  #username               = "edu"
  #password               = var.db_password
  #db_subnet_group_name   = aws_db_subnet_group.udacity_db_subnet_group.name
  #vpc_security_group_ids = [aws_security_group.rds_sg1.id]
  #parameter_group_name   = aws_db_parameter_group.education.name
  #publicly_accessible    = true
  #skip_final_snapshot    = true
  #backup_retention_period = 5
#}

