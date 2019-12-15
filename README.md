These modules create the following:

- 2 webservers (with nginx)
- 2 DBs
- 1 ALB (+ rotating logs and stickiness of 1 minute)
- 1 VPC
- 2 Public subnets
- 2 Private subnets
- 1 private route table and its association
- 1 pubic route table and its association
- 1 internet gateway
- 1 nat gateway
- TFstates is saved to S3 bucket (which was created earlier)

Note:
- There are 2 availability zones
- This TF (Network directory) includes 2 registry modules (1. VPC; 2. ALB)

https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.21.0

Running instructions:
- Each directory needs to run separately:
1. Perform the following commands in this order for each directory:
- terraform init
- terraform plan
- terraform apply
2. Apply the "Network" directory first (so the VPC and the ALB will be ready for the instances)
3. Apply the "Application" directory second
4. Destroy order: 1. Application; 2. Network


