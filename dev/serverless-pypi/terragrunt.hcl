include {
  path = find_in_parent_folders() # inputs are automatically merged
}

terraform {
  source = "git::git@github.com:Luke31/terraform-aws-infra-modules.git//serverless-pypi"
  # source = "/Users/lukas-schmid/git/terraform-aws-infra-modules/serverless-pypi"
}
inputs = {
  api_name = "pypi-priv"
}
