# terraform-aws-infra-live
Terragrunt deployment repository - heavily based on gruntwork-io's [terragrunt-infrastructure-live-example](https://github.com/gruntwork-io/terragrunt-infrastructure-live-example)

This repository is a terragrunt deployment repository to deploy terraform modules in a multi-account AWS environment:
- master/root account: AWS Organizations master with two linked environment-accounts:
  - dev-account
  - prd-account
  
# Deployment

## Deploy single module in environment
```shell script
cd dev/remote-state
terragrunt plan
terragrunt apply
```
- No need to call `terragrunt init` due to [Terragrunt Auto-Init](https://terragrunt.gruntwork.io/docs/features/auto-init/https://terragrunt.gruntwork.io/docs/features/auto-init/https://terragrunt.gruntwork.io/docs/features/auto-init/https://terragrunt.gruntwork.io/docs/features/auto-init/)

## Deploy environment
```shell script
cd dev
terragrunt plan-all
terragrunt apply-all
```

or

```shell script
cd prd
terragrunt plan-all
terragrunt apply-all
```

# Preconditions
## AWS accounts
This repository is intended to work with three AWS accounts and set up accordingly:
1. The accounts need to be connected on AWS Organizations (This will also create the required role OrganizationAccountAccessRole in the environment account.)
2. IAM user (or its group) must have policy to be allowed to assume role "arn:aws:iam::ENVIRONMENT-ACCOUNT-ID:role/UpdateApp". This must be set in the root-account
as for example:
    ```yaml
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "Stmt1588492271000",
          "Effect": "Allow",
          "Action": [
            "sts:AssumeRole"
          ],
          "Resource": [
            "arn:aws:iam::DEV-ACCOUNT-ID:role/OrganizationAccountAccessRole"
          ]
        },
        {
          "Sid": "Stmt1588492440000",
          "Effect": "Allow",
          "Action": [
            "sts:AssumeRole"
          ],
          "Resource": [
            "arn:aws:iam::PRD-ACCOUNT-ID:role/OrganizationAccountAccessRole"
          ]
        }
      ]
    }
    ```
3. Setup aws profile to root-account
```shell script
vi ~/.aws/credentials
[lukas]
aws_access_key_id = YOUR_ACCESS_KEY_ROOT_ACCOUNT
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY_ROOT_ACCOUNT
```

See also 
- [Tutorial: Delegate Access Across AWS Accounts Using IAM Roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html)
- [Switching to a Role (Console)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-console.html)
