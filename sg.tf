
resource "aws_security_group" "allow_http" {
    name = "allow_http"
    description = "Allow Web inbound traffic"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    vpc_id = "${aws_vpc.main.id}"
}