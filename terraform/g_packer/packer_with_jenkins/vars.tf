variable "AWS_REGION" {
  default = "ap-northeast-2"
}

variable "AWS_AZ" {
  type = map(string)
  default = {
      "a" = "ap-northeast-2a",
      "c" = "ap-northeast-2c"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "__YOUR_KEY__"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "__YOUR_KEY__"
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

variable "JENKINS_VERSION" {
  default = "2.375"
}

variable "TERRAFORM_VERSION" {
  default = "1.4.0"
}

variable "APP_INSTANCE_COUNT" {
  default = "0"
}

variable "DUMMY_SSH_PUB_KEY" { }
