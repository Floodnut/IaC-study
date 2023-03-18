provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION
#   assume_role {
#     duration_seconds = 3600
#     session_name = "session-name"
#     //role_arn = var.aws_deployment_role
#   }
}
