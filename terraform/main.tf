provider "aws" {
  version = "~> 2.0"
  assume_role {
    role_arn = "arn:aws:iam::043791476419:role/My-Contributor-Role"
    session_name = "terraform-deploy"
  }
}

data "aws_region" "current" {}

variable "site-name" {
  default = "brandonpurvis.com"
}



// S3 Buckets

data "aws_iam_policy_document" "s3-public-read" {
  statement {
    effect = "Allow"
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site-bucket.arn}/*"]
    principals {
      identifiers = ["*"]
      type = "AWS"
    }
  }
}

resource "aws_s3_bucket_policy" "site-s3-bucket-policy" {
  bucket = aws_s3_bucket.site-bucket.id
  policy = data.aws_iam_policy_document.s3-public-read.json
}

resource "aws_s3_bucket" "site-bucket" {
  bucket = var.site-name
  acl = "public-read"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket" "site-linking-bucket" {
  bucket = "www.${var.site-name}"
  website {
    redirect_all_requests_to = aws_s3_bucket.site-bucket.bucket
  }
}


// Output
output "region" {
  value = data.aws_region.current
}

output "buckets" {
  value = {
    "site-bucket" = "${aws_s3_bucket.site-bucket}"
    "link-bucket" = "${aws_s3_bucket.site-linking-bucket}"
  }
}
