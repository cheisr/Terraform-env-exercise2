##################################################################################
# INSTANCES
##################################################################################

resource "aws_instance" "webserver-1a" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [data.aws_security_group.public.id]
  availability_zone = "us-east-1a"
  associate_public_ip_address = true

  subnet_id = data.aws_subnet.public1a.id

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)

  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "sudo service nginx start",
      "echo '<html>OpsSchool webserver1, hello</head>' | sudo tee /usr/share/nginx/html/index.html",
    ]
  }
  tags = {
    Name = "webserver 1a"
    Owner = "Chen"
  }
}

resource "aws_instance" "webserver-1b" {
  ami = data.aws_ami.aws-linux.id
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = [data.aws_security_group.public.id]
  subnet_id = data.aws_subnet.public1b.id
  availability_zone = "us-east-1b"
  associate_public_ip_address = true

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file(var.private_key_path)

    }

    provisioner "remote-exec" {
      inline = [
        "sudo yum install nginx -y",
        "sudo service nginx start",
        "echo '<html>OpsSchool webserver2, hello</head>' | sudo tee /usr/share/nginx/html/index.html",
      ]
    }
    tags = {
      Name = "webserver 1b"
      Owner = "chen"
    }
  }

  resource "aws_instance" "db-1a" {
    ami = data.aws_ami.aws-linux.id
    instance_type = "t2.micro"
    key_name = var.key_name
    vpc_security_group_ids = [
      data.aws_security_group.private.id]
    availability_zone = "us-east-1a"
    subnet_id = data.aws_subnet.private1a.id
    tags = {
      Name = "DB-1"
      Owner = "chen"
    }

  }

resource "aws_instance" "db-1b" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [data.aws_security_group.private.id]
  availability_zone = "us-east-1b"
  subnet_id = data.aws_subnet.private1b.id
  
  tags = {
    Name = "DB-2"
    Owner = "chen"
  }
}


##################################################################################
# APPLICATION LB MISC
##################################################################################
resource "aws_lb_target_group_attachment" "attach-web1" {
  target_group_arn = data.aws_lb_target_group.targetgroup.arn
  target_id        = aws_instance.webserver-1a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach-web2" {
  target_group_arn = data.aws_lb_target_group.targetgroup.arn
  target_id        = aws_instance.webserver-1b.id
  port             = 80
}
