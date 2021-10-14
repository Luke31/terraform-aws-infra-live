include {
  path = find_in_parent_folders() # inputs are automatically merged
}

terraform {
  # source = "git::git@github.com:Luke31/terraform-aws-infra-modules.git//eastwards"
  source = "/Users/lukas-schmid/git/terraform-aws-infra-modules/eastwards"
}
inputs = {
  project_name = "eastwards"
}
