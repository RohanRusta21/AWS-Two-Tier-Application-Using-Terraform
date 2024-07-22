# I am not using this data because, we have to attach multiple subnets,right!
# data "aws_subnet" "public_subnet" {
#   filter {
#     name = "tag:Name"
#     values = ["Subnet-Public : Public Subnet 1"]
#   }

#   depends_on = [
#     aws_route_table_association.public_subnet_asso
#   ]
# }

resource "aws_instance" "ec2_pub_az1" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_type
  tags = {
    Name                 = "EC2 Public subnet in az1"
  }
  key_name               = "sarva"
  count                  = length(var.public_subnet) 
  subnet_id              = element(var.public_subnet[0],count.index)
  vpc_security_group_ids = [aws_security_group.aws_security_group.sg_vpc_http_ssh.id]

}

# resource "aws_instance" "ec2_pub_az2" {
#   ami                    = var.ec2_ami
#   instance_type          = var.ec2_type
#   tags = {
#     Name                 = "EC2 public subnet in az1"
#   }
#   key_name               = "sarva"
#   subnet_id              = aws_subnet.public_subnet[1]
#   vpc_security_group_ids = [aws_security_group.aws_security_group.sg_vpc_http_ssh.id]

# }

# resource "aws_instance" "ec2_pri_az1" {
#   ami                    = var.ec2_ami
#   instance_type          = var.ec2_type
#   tags = {
#     Name                 = "EC2 Private subnet in az1"
#   }
#   key_name               = "sarva"
#   subnet_id              = aws_subnet.private_subnet[0]
#   vpc_security_group_ids = [aws_security_group.aws_security_group.sg_vpc_http_ssh.id]

# }

# resource "aws_instance" "ec2_pri_az2" {
#   ami                    = var.ec2_ami
#   instance_type          = var.ec2_type
#   tags = {
#     Name                 = "EC2 Private subnet in az2"
#   }
#   key_name               = "sarva"
#   subnet_id              = aws_subnet.private_subnet[1]
#   vpc_security_group_ids = [aws_security_group.aws_security_group.sg_vpc_http_ssh.id]

# }

# try to do it through for loop with multiple ports
resource "aws_security_group" "sg_vpc_http_ssh" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0"]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress                = [
    {
      cidr_blocks      = [ "0.0.0.0/0"]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    } , 
        {
      cidr_blocks      = [ "0.0.0.0/0"]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    }
  ]
  vpc_id               = var.vpc_id
  tags = {
    Name = "SG : allows http and ssh connections"
  }
}
resource "aws_security_group" "sg_vpc_ssh" {
  egress{
      cidr_blocks      = [ "0.0.0.0/0"]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ingress{
      cidr_blocks      = [ "0.0.0.0/0"]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    } 
}