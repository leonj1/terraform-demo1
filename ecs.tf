# US East 1 ECS Resources
resource "aws_ecs_cluster" "us_east_1" {
  provider = aws.us_east_1
  name     = "react-cluster-us-east-1"

  tags = merge(local.common_tags, {
    Name = "ecs-cluster-us-east-1"
  })
}

resource "aws_ecs_task_definition" "react_app_us_east_1" {
  provider                = aws.us_east_1
  family                  = "react-app-us-east-1"
  network_mode           = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                    = 256
  memory                 = 512
  execution_role_arn     = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "react-app"
      image     = "react-hello-world:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
    }
  ])

  tags = merge(local.common_tags, {
    Name = "react-app-task-us-east-1"
  })
}

# US East 2 ECS Resources
resource "aws_ecs_cluster" "us_east_2" {
  provider = aws.us_east_2
  name     = "react-cluster-us-east-2"

  tags = merge(local.common_tags, {
    Name = "ecs-cluster-us-east-2"
  })
}

resource "aws_ecs_task_definition" "react_app_us_east_2" {
  provider                = aws.us_east_2
  family                  = "react-app-us-east-2"
  network_mode           = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                    = 256
  memory                 = 512
  execution_role_arn     = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "react-app"
      image     = "react-hello-world:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
    }
  ])

  tags = merge(local.common_tags, {
    Name = "react-app-task-us-east-2"
  })
}

# Global IAM Resources
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
