include {
  path = find_in_parent_folders() # inputs are automatically merged
}

terraform {
  source = "git::git@github.com:Luke31/terraform-aws-infra-modules.git//bucket-policy"
  # source = "/Users/lukas-schmid/git/terraform-aws-infra-modules/bucket-policy"
}
inputs = {
  project_name = "bucket-policy"
}
