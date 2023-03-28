variable "AWS_REGION" {
  default = "ap-northeast-2"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "../terraform-private.pem"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "../terraform-public.pub"
}

variable "ENV" {
  default = "prod"
}

