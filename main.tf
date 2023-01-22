terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  cloud {
    organization = "petebeegle"

    workspaces {
      name = "gitlab-titler_production"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

module "this" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "func-${terraform.workspace}"

  handler     = "index.handler"
  runtime     = "nodejs18.x"
  source_path = "${path.root}/src"

  create_lambda_function_url = true
  authorization_type         = "NONE"

  tags = {
    Name        = "gitlab_titler"
    Environment = terraform.workspace
  }
}

output "webhook_url" {
  value = module.this.lambda_function_url
}

output "function_name" {
  value = module.this.lambda_function_name
}
