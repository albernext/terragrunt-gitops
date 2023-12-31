terraform {
  source = "${local.module_source_url}?version=3.8.2"
}

locals {
  module_source_url = "tfr:///terraform-aws-modules/s3-bucket/aws"
}

inputs = {
  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm     = "AES256"
      }
    }
  }
}
