provider "aws" {
  version = "~> 2.0"
  assume_role {
    role_arn = "arn:aws:iam::043791476419:role/My-Contributor-Role"
    session_name = "terraform-deploy"
  }
}


data "aws_region" "current" {}

// S3 Buckets



// Output
output "region" {
  value = "${data.aws_region.current}"
}