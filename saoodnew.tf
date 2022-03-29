provider "aws" {
  region     = "us-east-1"

}
resource "aws_instance" "terraform" {
  ami= "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  tags = {
    Name = "saood_instance"
  }
}

resource "aws_ebs_volume" "TFebs1" {
 availability_zone = aws_instance.terraform.availability_zone
 size = 1

 tags = {
  Name = "Extra_EBS"
 }

}
resource "aws_volume_attachment" "attach_ebs_1" {
device_name = "/dev/sdh"
volume_id = aws_ebs_volume.TFebs1.id
instance_id =aws_instance.terraform.id
}
resource "aws_eip" "lb" {
  instance = aws_instance.terraform.id
  vpc      = true
}


resource "aws_security_group" "security" {
  name = "saood_security group"


  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["103.43.4.102/32"]
  }

  #Outgoing traffic
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
