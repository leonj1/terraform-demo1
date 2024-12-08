resource "aws_security_group" "react_service" {
  name        = "react-service-sg"
  description = "Security group for React ECS service"
  vpc_id      = aws_vpc.main.id

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
}

resource "aws_ecs_service" "react_app" {
  name            = "react-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.react_app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.public[*].id
    security_groups  = [aws_security_group.react_service.id]
    assign_public_ip = true
  }
}
