terraform {
  backend "s3" {
    bucket         = "624627192772-terraform-states"
    key            = "ec2-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
