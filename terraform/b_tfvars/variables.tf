variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {}

variable "AWS_AMIS" {
    type = map(string)
    default = {
        ap-northeast-2 = "ami-035e3e44dc41db6a2"
    }
}