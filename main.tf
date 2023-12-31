resource "aws_subnet" "private" {
  vpc_id     = data.aws_vpc.vpc.id
  cidr_block = "10.0.171.0/24"

  tags = {
    Name = "Private"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = data.aws_vpc.vpc.id


  tags = {
    Name = "route-table 01"
  }
}
resource "aws_route_table" "route_table1" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name = "route-table 01"
  }
}

resource "aws_route_table_association" "privateRT_with_private1" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.route_table.id
}


resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = data.aws_nat_gateway.nat.id

  depends_on = [data.aws_nat_gateway.nat]
}



resource "aws_security_group" "example01" {
  name_prefix = "example-sg01"
  vpc_id =  data.aws_vpc.vpc.id


  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





resource "aws_lambda_function" "lambda01" {

  filename      = "lambda1.zip"
  function_name = "lambda01"
  role          = data.aws_iam_role.lambda.arn
  handler       = "lambda.lambda_handler"
  timeout = 180

  runtime = "python3.7"
    
  vpc_config {
    subnet_ids = [aws_subnet.private.id]
    security_group_ids = [aws_security_group.example01.id]
  }

  environment {
  variables = {
    subnetId= "${aws_subnet.private.id}"
  }
  
}
}



