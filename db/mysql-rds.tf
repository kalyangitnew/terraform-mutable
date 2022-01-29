locals {
  rds_user = jsondecode(data.aws_secretsmanager_secret_version.secrets-version.secret_string)["RDS_MYSQL_USER"]
  rds_pass = jsondecode(data.aws_secretsmanager_secret_version.secrets-version.secret_string)["RDS_MYSQL_PASS"]
}
resource "aws_db_instance" "mysql" {
  allocated_storage    = 10
  identifier             = "mysql-${var.ENV}"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "dummy"
  username             = locals_rds_user
  password             = locals_rds_pass
  parameter_group_name = aws_db_parameter_group.pg.name
  skip_final_snapshot  = true
}
resource "aws_db_parameter_group" "pg" {
  name   = "mysql-${var.ENV}-pg"
  family = "mysql5.7"
}
resource "aws_db_subnet_group" "subnet_group" {
  name       = "mysqldb-subnet-group-${var.ENV}"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS_IDS

  tags = {
    Name = "mysqldb-subnet-group-${var.ENV}"
  }
}

