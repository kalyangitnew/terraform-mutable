
resource "aws_rds_cluster" "docdb" {
  cluster_identifier      = "mongodv-${var.ENV}"
  engine                  = "docdb"
  engine_version          = "4.0.0"
  master_username         = "foo"
  master_password         = "bar"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}