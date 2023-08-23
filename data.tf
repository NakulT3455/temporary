data "aws_nat_gateway" "nat" {
  id = "nat-0dcfe22fbe4770124"
}

data "aws_vpc" "vpc" {
  id = "vpc-082b86a23dea8cb5c"
}

data "aws_iam_role" "lambda" {
  name = "lambda-role"
}
