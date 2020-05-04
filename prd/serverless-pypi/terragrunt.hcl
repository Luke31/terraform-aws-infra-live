include {
  path = find_in_parent_folders() # inputs are automatically merged
}

terraform {
  source = "git::git@github.com:Luke31/terraform-aws-infra-modules.git//serverless-pypi?ref=v1.0.1"
}
inputs = {
  api_name = "pypi-priv"
}
