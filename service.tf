# US East 1 Resources
resource "aws_security_group" "react_service_us_east_1" {
  provider    = aws.us_east_1
  name        = "react-service-sg-us-east-1"
  description = "Security group for React ECS service in us-east-1"
  vpc_id      = aws_vpc.us_east_1.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "react-service-sg-us-east-1"
  })
}

resource "aws_ecs_service" "react_app_us_east_1" {
  provider         = aws.us_east_1
  name            = "react-service-us-east-1"
  cluster         = aws_ecs_cluster.us_east_1.id
  task_definition = aws_ecs_task_definition.react_app_us_east_1.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.us_east_1_public[*].id
    security_groups  = [aws_security_group.react_service_us_east_1.id]
    assign_public_ip = true
  }

  tags = merge(local.common_tags, {
    Name = "react-service-us-east-1"
  })
}

# US East 2 Resources
resource "aws_security_group" "react_service_us_east_2" {
  provider    = aws.us_east_2
  name        = "react-service-sg-us-east-2"
  description = "Security group for React ECS service in us-east-2"
  vpc_id      = aws_vpc.us_east_2.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "react-service-sg-us-east-2"
  })
}

resource "aws_ecs_service" "react_app_us_east_2" {
  provider         = aws.us_east_2
  name            = "react-service-us-east-2"
  cluster         = aws_ecs_cluster.us_east_2.id
  task_definition = aws_ecs_task_definition.react_app_us_east_2.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.us_east_2_public[*].id
    security_groups  = [aws_security_group.react_service_us_east_2.id]
    assign_public_ip = true
  }

  tags = merge(local.common_tags, {
    Name = "react-service-us-east-2"
  })
}
