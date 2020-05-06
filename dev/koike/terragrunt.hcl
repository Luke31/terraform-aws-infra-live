include {
  path = find_in_parent_folders() # inputs are automatically merged
}

terraform {
  # source = "git::git@github.com:Luke31/terraform-aws-infra-modules.git//koike"
  source = "/Users/lukas-schmid/git/terraform-aws-infra-modules/koike"
}
inputs = {
  project_name = "koike"
  # TODO: To avoid storing your pip user incl. password in the code, set it as the environment variable TF_VAR_pip_index_url
  # e.g. https://USER:PASSWORD@w67vooj233.execute-api.ap-northeast-1.amazonaws.com/simple
}
