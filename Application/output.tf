##################################################################################
# OUTPUT
##################################################################################

output "app_lb_public_DNS_name" {
  value = data.aws_lb.app-lb.dns_name
  }

output "aws_instance_web1_public_IP" {
  value = aws_instance.webserver-1a.public_ip
  }

output "aws_instance_web2_public_IP" {
  value = aws_instance.webserver-1b.public_ip
  }

output "aws_instance_db1_private_IP" {
  value = aws_instance.db-1a.private_ip
  }

  output "aws_instance_db2_private_IP" {
  value = aws_instance.db-1b.private_ip
  }
