resource "aws_ecs_task_definition" "service" {
  family                   = "fargate-task-definition"
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "1024"
  requires_compatibilities = ["FARGATE"]
  container_definitions = <<DEFINITION
  [
    {
      "command": [
        "/bin/sh -c \"echo '<html> <head> <title>Test/title></head><body> <h1>It works!</h1> Yaaaay!</body></html>' >  /usr/share/nginx/html/index.html\""
      ],
      "entryPoint": [
        "sh",
        "-c"
      ],
      "essential": true,
      "image": "nginx:latest",
      "name": "nginx",
      "portMappings": [
            {
              "containerPort": 80,
              "hostPort": 80,
              "protocol": "tcp"
            }
          ]
      }
  ]
  DEFINITION
  }

resource "aws_ecs_cluster" "nginx" {
  name = "nginx"
}

resource "aws_ecs_service" "nginx" {
  name            = "nginx"
  cluster         = aws_ecs_cluster.nginx.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.oktest.id]
    subnets          = module.vpc.private_subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nginx.arn
    container_name   = "nginx"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.http]

  tags = {
    Environment = "test"
    Application = "nginx"
  }
}