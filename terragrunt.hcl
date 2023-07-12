locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  account_name = local.account_vars.locals.account_name
  account_id   = local.account_vars.locals.aws_account_id
  aws_region   = local.account_vars.locals.aws_region

  workflow_path = "/home/runner/work/terragrunt-actions/terragrunt-gitops"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"

  assume_role {
    role_arn = "arn:aws:iam::${local.account_id}:role/iac-gitops"
  }

  default_tags {
    tags = {
      TerraformPath = replace("${get_terragrunt_dir()}", "${local.workflow_path}", "terragrunt-gitops")
    }
  }
}

provider "github" {
  owner = "albernext"
}
EOF
}

remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "tf-state-963371085934"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "tf-locks"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  local.account_vars.locals
)

prevent_destroy = true
