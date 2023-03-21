resource "aws_internet_gateway" "igw1" {
    vpc_id = "${aws_vpc.vpc1.id}"
}

resource "aws_internet_gateway" "igw2" {
    vpc_id = "${aws_vpc.vpc2.id}"
}


resource "aws_vpc" "vpc1" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "vpc2" {
    cidr_block = "10.1.0.0/16"
}

resource "aws_vpc_peering_connection" "vpc1_to_vpc2_peering" {
    vpc_id = aws_vpc.vpc1.id
    peer_vpc_id = aws_vpc.vpc2.id
    auto_accept = true

    tags = {
        Name = "VPC peering from vpc1 to vpc2"
    }

    /*
    로컬 VPC가 퍼블릭 DNS 호스트명을 프라이빗 IP 주소에 지정할 수 있도록 함.
    */
    # accepter {
    #     allow_remote_vpc_dns_resolution = true
    # }

    # requester {
    #     allow_remote_vpc_dns_resolution = true
    # }
}

resource "aws_subnet" "subnet_vpc1" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.100.0/24"
    depends_on = [
      aws_internet_gateway.igw1
    ]
    availability_zone = data.aws_availability_zone.northeast_a.id
    
    tags = {
        Name = "VPC1_Subnet1"
    }
}

resource "aws_elb" "elb1" {
    name = "elbvpc1"

    # 서브넷과 AZ 중 하나만 명시해야 함.

    ## Subnet to Instance ELB의 경우
    # availability_zones = [data.aws_availability_zone.northeast_a.id]

    ## VPC to Subnet ELB의 경우
    subnets = [aws_subnet.subnet_vpc1.id]
    
    listener {
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }

    instances                   = [aws_instance.vpc1_subnet1_ec2_1.id, aws_instance.vpc1_subnet1_ec2_2.id]
    cross_zone_load_balancing   = true
    idle_timeout                = 400
    connection_draining         = true
    connection_draining_timeout = 400

    tags = {
        Name = "vpc1_subnet1-terraform-elb"
    }
}

resource "aws_elb_attachment" "elb_att_1" {
    elb      = aws_elb.elb1.id
    instance = aws_instance.vpc1_subnet1_ec2_1.id
}

resource "aws_elb_attachment" "elb_att_2" {
    elb      = aws_elb.elb1.id
    instance = aws_instance.vpc1_subnet1_ec2_2.id
}

resource "aws_instance" "vpc1_subnet1_ec2_1" {
    ami = "${lookup(var.AWS_AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    availability_zone = "${lookup(var.AWS_REGION_AZ, var.AWS_REGION)}"
    subnet_id = aws_subnet.subnet_vpc1.id
    security_groups = [aws_security_group.allow_http.id, aws_security_group.allow_tls.id]
}

resource "aws_instance" "vpc1_subnet1_ec2_2" {
    ami = "${lookup(var.AWS_AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    availability_zone = "${lookup(var.AWS_REGION_AZ, var.AWS_REGION)}"
    subnet_id = aws_subnet.subnet_vpc1.id
    security_groups = [aws_security_group.allow_http.id, aws_security_group.allow_tls.id]
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc1.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc1.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}