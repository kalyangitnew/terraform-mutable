data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-practice"
    key    = "terraform-mutable/vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"

  }
}
