resource "aws_lb" "nginx" {
  name               = "alb"
  subnets             =  ["${aws_subnet.az1.id}, ${aws_subnet.az2.id}"] 
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]

  tags = {
    Environment = "test"
    Application = "nginx"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }
}

resource "aws_lb_target_group" "nginx" {
  name        = "nginx-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "90"
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = "20"
    path                = "/"
    unhealthy_threshold = "2"
  }
}