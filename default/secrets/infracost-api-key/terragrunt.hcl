include "root" {
  path = find_in_parent_folders()
}

include "secrets" {
  path = find_in_parent_folders("secrets.hcl")
}

inputs = {
  description = "Infracost API key"
}
