resource "aws_instance" "example" {
    ami = "${lookup(var.AWS_AMIS, var.AWS_REGION)}" // lookup은 map 변수에서 값을 조회할 것
    instance_type = "t2.micro"
}