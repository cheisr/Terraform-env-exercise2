##################################################################################
# S3 Backend
##################################################################################
terraform {
  backend "s3" {
  bucket = "chen-tfbucket"
  key = "terraform_Application.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
