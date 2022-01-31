locals {
  rds_user = jsondecode(data.aws_secretsmanager_secret_version.secrets-version.secret_string)["RDS_MYSQL_USER"]
  rds_pass = jsondecode(data.aws_secretsmanager_secret_version.secrets-version.secret_string)["RDS_MYSQL_PASS"]
}
resource "aws_rds_cluster" "docdb" {
  cluster_identifier      = "mongodv-${var.ENV}"
  engine                  = "docdb"
  engine_version          = "4.0.0"
  master_username         = "foo"
  master_password         = "bar"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}