terraform { 
  cloud { 
    organization = "<YOUR_TERRAFORM_CLOUD_ORGANIZATION>" #Replace <YOUR_TERRAFORM_CLOUD_ORGANIZATION> with your actual Terraform Cloud organization name

    workspaces { 
      name = "<YOUR_TERRAFORM_WORKSPACE_NAME>" #Replace <YOUR_TERRAFORM_WORKSPACE_NAME> with the name of your Terraform workspace
    } 
  } 
}
