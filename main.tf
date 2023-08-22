resource "aws_subnet" "private" {
  vpc_id     = data.aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Private"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "10.0.1.0/24"
    #gateway_id = aws_internet_gateway.example.id
  }

  tags = {
    Name = "route-table"
  }
}

resource "aws_route_table_association" "privateRT_with_private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.route_table.id
}


resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = data.aws_nat_gateway.nat.id

  depends_on = [data.aws_nat_gateway.nat]
}

resource "aws_lambda_function" "lambda" {

  filename      = "lambda.zip"
  function_name = "lambda"
  role          = data.aws_iam_role.lambda.arn
  handler       = "lambda.lambda_handler"
  timeout = 180

  runtime = "python3.7"

  
}

output "subnet_id" {
  description = "private subnet ID"
  value       = aws_subnet.private.id
}




