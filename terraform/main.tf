provider "aws" {
  version = "~> 2.0"
}


data "aws_region" "current" {}

// S3 Buckets



// Output
output "region" {
  value = "${data.aws_region.current}"
}