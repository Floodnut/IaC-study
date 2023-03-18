variable "myvar" { //terraform plan, apply 없이 테스트 할  수 있음.
  //type = "string" //deprecated
  type = string
  default = "hello terraform"
}

variable "mymap" { //terraform plan, apply 없이 테스트 할  수 있음.
  type = map(string)
  default = {
    mykey = "value"
  }
}

variable "mylist"{
    type = list
    default = [1,2,3]
}