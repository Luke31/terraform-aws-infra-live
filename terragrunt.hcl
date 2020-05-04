locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  account_name = local.environment_vars.locals.account_name
  account_id   = local.environment_vars.locals.aws_account_id
  environment = local.environment_vars.locals.environment
  bucket_prefix = "sc"
  region = "ap-northeast-1"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.region}"
  allowed_account_ids = ["${local.account_id}"]
  profile = "lukas"
  assume_role {
    role_arn     = "arn:aws:iam::${local.account_id}:role/OrganizationAccountAccessRole"
    session_name = "SESSION_NAME"
    external_id  = "EXTERNAL_ID"
  }
}
EOF
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "${local.bucket_prefix}-${local.environment}-tfstate"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
    encrypt        = true
    dynamodb_table = "app-state"
    role_arn       = "arn:aws:iam::${local.account_id}:role/OrganizationAccountAccessRole"
  }
}

inputs = merge(
  local.environment_vars.locals,
  {env = local.environment},
  {bucket_prefix = local.bucket_prefix},
  {region = local.region}
)
