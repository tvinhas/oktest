output "lb_url" {
  description = "URL of load balancer"
//  value       = aws_lb.nginx.dns_name
  value       = "http://${aws_lb.nginx.dns_name}/"
}