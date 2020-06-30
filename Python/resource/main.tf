provider "aws" {

  region = "${var.aws-region}"
  }
resource "aws_instance" "example" {
  ami = "${lookup(var.AMIS, var.aws-region)}"
  instance_type = "t2.micro"


count="${var.num}"
}
resource "null_resource" "remote-exec-1" {
    connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(var.pvt_key)}"
    host        = "${aws_instance.example.public_ip}"
  }
  }
data "aws_availability_zones" "available" {}

resource "aws_security_group" "mySg" {
    name            = "mySg"
    description     = "created from terraform"
    vpc_id          = "${var.vpc_id}"
    ingress{
        cidr_blocks = ["0.0.0.0/0"]
        protocol    = "-1"
        from_port   = "0"
        to_port     = "0"
    }
    egress{
        cidr_blocks = ["0.0.0.0/0"]
        protocol    = "-1"
        from_port   = "0"
        to_port     = "0"
    }

}
resource "aws_launch_configuration" "as_conf" {

  image_id      = "ami-08bc77a2c7eb2b1da"
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "myAutoscalingGrp" {
  launch_configuration = "${aws_launch_configuration.as_conf.id}"
  availability_zones = [
                             "us-east-1a",
                             "us-east-1b",
                             "us-east-1c",
                             "us-east-1d",
                             "us-east-1e",
                             "us-east-1f"
]
  min_size = 2
  max_size = 10
  load_balancers = ["${aws_elb.myloadbalancer.name}"]
  health_check_type = "ELB"

}
resource "aws_security_group" "elbSg" {
  name = "terraform-exmple-elb"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_elb" "myloadbalancer" {
  name = "terraform-asg-example"
  security_groups = ["${aws_security_group.elbSg.id}"]
  availability_zones = [
                          "us-east-1a",
                          "us-east-1b",
                          "us-east-1c",
                          "us-east-1d",
                          "us-east-1e",
                          "us-east-1f"
]
 health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2

    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}

