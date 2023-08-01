include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${local.module_source_url}?ref=add-docker-image-repo"
}

locals {
  module_source_url = "git@github.com:albernext/terraform-modules.git//docker-image-repo"
}

dependency "github_token" {
  config_path = "../secrets/github-token-albertored11-terragrunt"
}

inputs = {
  repo                         = "docker-hello-world"
  github_repository_visibility = "public"
  aws_secret_github_pat_arn    = dependency.github_token.outputs.arn

  github_teams = [
    "devops"
  ]
}
