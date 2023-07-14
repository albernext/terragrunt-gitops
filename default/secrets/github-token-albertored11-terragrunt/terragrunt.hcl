include "root" {
  path = find_in_parent_folders()
}

include "secrets" {
  path = find_in_parent_folders("secrets.hcl")
}

inputs = {
  description = "GitHub personal access token used for Terragrunt automation that belongs to albertored11"
}
