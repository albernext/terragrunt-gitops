include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr:///terraform-aws-modules/iam/aws//modules/iam-assumable-role?version=4.24.1"
}

dependency "iac_gitops_platform" {
  config_path = "../../default/iac-gitops-platform"
}

inputs = {
  create_role = true

  trusted_role_arns = [dependency.iac_gitops_platform.outputs.iam_user_arn]

  role_name        = "iac-gitops"
  role_description = "Role assumed by iac-gitops user to manage resources in this AWS account"

  role_requires_mfa   = false
  attach_admin_policy = true
}

prevent_destroy = false
