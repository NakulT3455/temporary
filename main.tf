resource "aws_subnet" "private" {
  vpc_id     = data.aws_vpc.vpc.id
  cidr_block = "10.0.171.0/24"

  tags = {
    Name = "Private"
  }
}

resource "aws_route_table" "route_table1" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "10.0.171.0/24"
   
  }

  tags = {
    Name = "route-table 01"
  }
}

resource "aws_route_table_association" "privateRT_with_private1" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.route_table1.id
}


resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_route_table.route_table1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = data.aws_nat_gateway.nat.id

  depends_on = [data.aws_nat_gateway.nat]
}



resource "aws_security_group" "example01" {
  name_prefix = "example-sg01"
  vpc_id =  data.aws_vpc.vpc.id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





resource "aws_lambda_function" "lambda" {

  filename      = "lambda.zip"
  function_name = "lambda"
  role          = data.aws_iam_role.lambda.arn
  handler       = "lambda.lambda_handler"
  timeout = 180

  runtime = "python3.7"
    
  vpc_config {
    subnet_ids = [aws_subnet.private.id]
    security_group_ids = [aws_security_group.example01.id]
  }

  
}

output "subnet_id" {
  description = "private subnet ID"
  value       = aws_subnet.private.id
}




