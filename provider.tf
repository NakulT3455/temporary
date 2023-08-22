provider "aws" {
  region  = "ap-south-1" # Don't change the region
}


terraform {
backend "s3" {
    bucket         	   = "3.devops.candidate.exam"
    key              	   = "nakul.thorat"
    region         	   = "ap-south-1"
    #encrypt        	   = true
    #dynamodb_table = "mycomponents_tf_lockid"
  }
}
# Add your S3 backend configuration here
