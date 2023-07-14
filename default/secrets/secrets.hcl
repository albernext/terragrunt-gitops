terraform {
  source = "${local.module_source_url}?ref=initial-modules"
}

locals {
  module_source_url = "git@github.com:albernext/terraform-modules.git//aws-secret"
}

inputs = {
  name = basename(get_terragrunt_dir())
}
