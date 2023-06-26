# 2 (t2.micro) Servers to be placed in public and 2 to be in the private subnets
# deploying 2 ec2 instances each
resource "aws_instance" "ccl-server" {
  count                  = length(var.aws_instance-ccl-server)
  ami                    = element(var.aws_instance-ccl-server, count.index)
  instance_type          = var.component
  vpc_security_group_ids = ["${aws_security_group.ccl-sg.id}"]
  tenancy                = var.ccl-ten
  key_name               = var.key_name
  subnet_id              = element(var.subnet_ids, count.index)

  tags = {
    Name = "ccl-server"
  }
}
