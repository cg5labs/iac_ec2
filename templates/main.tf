data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

provider "random" {}

resource "random_pet" "name" {}

#resource "aws_instance" "web" {
#  ami           = data.aws_ami.ubuntu.id
#  instance_type = "t2.micro"
#  user_data     = file("../lib/init-script.sh")
#
#  key_name               = "debian-test"
#  monitoring             = true
#
#  tags = {
#    Name = random_pet.name.id
#  }
#}

resource "aws_vpc" "web_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "web-vpc"
  }
}

resource "aws_subnet" "web_subnet" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = "172.16.10.0/24"

  tags = {
    Name = "web-subnet-example"
  }
}

resource "aws_network_interface" "web" {
  subnet_id   = aws_subnet.web_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  key_name      = "debian-test"
  instance_type = "t2.micro"
  monitoring    = true

  tags = {
    Name = random_pet.name.id
  }

  network_interface {
    network_interface_id = aws_network_interface.web.id
    device_index         = 0
  }

}


