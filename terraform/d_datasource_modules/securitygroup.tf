data "aws_ip_ranges" "northeast_ec2" {
  regions  = ["ap-northeast-2"]
  services = ["ec2"]
}

resource "aws_security_group" "from_northeast" {
  name = "from_northeast"

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = slice(data.aws_ip_ranges.northeast_ec2.cidr_blocks, 0, 1)
  }
  tags = {
    CreateDate = data.aws_ip_ranges.northeast_ec2.create_date
    SyncToken  = data.aws_ip_ranges.northeast_ec2.sync_token
  }
}

