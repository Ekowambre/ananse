/* Create a complete VPC in eu-west-2 */
resource "aws_vpc" "ccl-project" {
  cidr_block           = var.ccl-project
  enable_dns_hostnames = var.host_name
  instance_tenancy     = var.tenancy


  tags = {
    Name = "ccl-project"
  }
}

/* creating 2 web-public subnets 
by using the element and count 
index functions */

resource "aws_subnet" "web-public" {
  count             = length(var.web-public_cidrs)
  vpc_id            = aws_vpc.ccl-project.id
  cidr_block        = element(var.web-public_cidrs, count.index)
  availability_zone = element(var.azs, count.index)


  tags = {
    Name = "web public ${count.index + 1}"
  }
}

/* creating 2 app-private subnets 
by using the element and count 
index functions */

resource "aws_subnet" "app-private" {
  count             = length(var.app-private_cidrs)
  vpc_id            = aws_vpc.ccl-project.id
  cidr_block        = element(var.app-private_cidrs, count.index)
  availability_zone = element(var.azs, count.index)


  tags = {
    Name = "app private ${count.index + 1}"
  }
}

/* Allowing internet access 
into ccl-project by creating 
the Internet gateway */

resource "aws_internet_gateway" "ccl-igw" {
  vpc_id = aws_vpc.ccl-project.id

  tags = {
    Name = "ccl vpc igw"
  }
}

/* Creating route table for both 
the private and public subnets 
using the count index function */

resource "aws_route_table" "ccl-rt" {
  count  = length(var.ccl-rt)
  vpc_id = aws_vpc.ccl-project.id

  tags = {
    Name = "ccl-rt ${count.index + 1}"
  }
}

/* creating the route table association 
having the count index in mind, we 
associate it with the count 1 which will be 
ccl-rt1 */

resource "aws_route_table_association" "ccl-rtpub" {
  count          = length(var.web-public_cidrs)
  subnet_id      = element(aws_subnet.web-public[*].id, count.index)
  route_table_id = aws_route_table.ccl-rt[0].id
}

resource "aws_route_table_association" "ccl-rtpriv" {
  count          = length(var.app-private_cidrs)
  subnet_id      = element(aws_subnet.app-private[*].id, count.index)
  route_table_id = aws_route_table.ccl-rt[1].id
}

# Internet gateway attachment (route)
resource "aws_route" "ccl-igwatt" {
  route_table_id         = aws_route_table.ccl-rt[0].id
  destination_cidr_block = var.ccl-rt-cidr_block
  gateway_id             = aws_internet_gateway.ccl-igw.id
}

# elastic ip address
resource "aws_eip" "ccl-eip" {
  vpc = true
}

# NAT gateway components
resource "aws_nat_gateway" "ccl-nat" {
  allocation_id = aws_eip.ccl-eip.id
  count         = length(var.web-public_cidrs)
  subnet_id     = element(aws_subnet.web-public[*].id, count.index)

  tags = {
    Name = "ccl nat"
  }
}

# Nat gateway attachment (route)
resource "aws_route" "ccl-nat-asso" {
  route_table_id         = aws_route_table.ccl-rt[1].id
  destination_cidr_block = var.ccl-nat_cidr_block
  gateway_id             = var.ccl-nat_cidr_block.id
}

/* Create security groups exposing to port 80 and 22. For each security group, you add rules 
that control the traffic based on protocols and port numbers. There are separate sets of 
 rules for inbound traffic and outbound traffic */
# create Security group for the ec2 instance
resource "aws_security_group" "ccl-sg" {
  description = var.ccl-sg
  vpc_id      = aws_vpc.ccl-project.id

  ingress {
    description = var.ccl-ssh-port
    from_port   = var.ssh-port
    to_port     = var.ssh-port
    protocol    = var.protocol_type
    cidr_blocks = var.ccl-port
  }

  ingress {
    description = var.ccl-http-port
    from_port   = var.http-port
    to_port     = var.http-port
    protocol    = var.protocol_type
    cidr_blocks = var.ccl-port
  }

  # for db connection
  ingress {
    description = var.mysqlport
    from_port   = var.port
    to_port     = var.port
    protocol    = var.protocol_type
    cidr_blocks = var.ccl-port
  }

  egress {
    from_port   = var.egress-port
    to_port     = var.egress-port
    protocol    = var.egress-protocol
    cidr_blocks = var.ccl-port
  }
}
