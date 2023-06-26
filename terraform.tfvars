region = "eu-west-2"

# variables for ccl-project vpc cidr_block
ccl-project = "10.0.0.0/16"

# variables for ccl-project vpc tenancy
tenancy = "default"

# variables for ccl-project vpc host_name
host_name = true

# Subnets variables
app-private_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
web-public_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]

# in order to reference the subnet ids in my instance i choose to create a variable for it.
subnet_ids = ["web-public1", "web-public2", "app-private1", "app-private2"]

# Availability zones variables
azs = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]

# ccl route table variables for 2 route tables
ccl-rt = ["ccl-rt1", "ccl-rt2"]

# Internet gateway attachment (route) 
ccl-rt-cidr_block = "0.0.0.0/0"

# NAT Gateway CIDR block variable
ccl-nat_cidr_block = "0.0.0.0/0"

# variable for ccl-sg inbound and outbound rules
ccl-sg = "allow acess on port 80 and 22"

# ingress rule #1
ccl-ssh-port  = "allow ssh access"
ssh-port      = 22
protocol_type = "tcp"
ccl-port      = "0.0.0.0/0"

# ingress rule #2
ccl-http-port = "allow http access"
http-port     = 80
mysqlport     = "allow rds connection"
port          = 3306

# egress variables
egress-port     = 0
egress-protocol = -1

# variable for ccl-servers 
aws_instance-ccl-server = ["ami-084e8c05825742534", "ami-084e8c05825742534", "ami-084e8c05825742534", "ami-084e8c05825742534"]

# Instance type components 
component = "t2.micro"

#key-pair
key_name = "eden"

# instance tenancy
ccl-ten = "default"

# variables for the RDS db called = ccl-projectrds
engine            = "mysql"
engine_version    = "8.0.30"
instance_class    = "db.t3.micro"
allocated_storage = "20"
storage_type      = "gp2"
identifier        = "ccl-db"
username          = "admin"
password          = "cloudrock"
multi_az          = true






