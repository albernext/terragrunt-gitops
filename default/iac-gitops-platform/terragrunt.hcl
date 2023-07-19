include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${local.module_source_url}?ref=initial-modules"
}

locals {
  module_source_url = "git@github.com:albernext/terraform-modules.git//iac-gitops-platform"
}

dependency "github_token" {
  config_path = "../secrets/github-token-albertored11-terragrunt"
}

dependency "infracost_api_key" {
  config_path = "../secrets/infracost-api-key"
}

inputs = {
  initial_deploy                     = false
  tf_modules_github_teams            = ["devops"]
  tg_actions_github_teams            = ["devops"]
  tg_actions_repo_codeowners_file    = "files/_codeowners"
  tg_automation_github_teams         = ["devops"]
  tg_automation_repo_codeowners_file = "files/_codeowners"
  tg_automation_user_name            = "iac-gitops"
  tg_automation_role_name            = "iac-gitops"
  state_bucket_name                  = "tf-state-963371085934"
  github_org                         = "albernext"
  github_token_secret_arn            = dependency.github_token.outputs.arn
  infracost_api_key_secret_arn       = dependency.infracost_api_key.outputs.arn
}
