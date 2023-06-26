# Creating a resource with aws provider in eu-wse-2 region
variable "aws" {
  default = "eu-west-2"
}

# variables for ccl-project vpc
variable "ccl-project" {
  type        = string
  description = "ccl project CIDR values"
  default     = "10.0.0.0/16"
}

# variables for ccl-project vpc
variable "tenancy" {
  type        = string
  description = "vpc tenancy"
  default     = "default"
}

# variables for ccl-project vpc
variable "host_name" {
  type        = string
  description = "vpc dns hostname"
  default     = true
}

# Subnets variables
variable "web-public_cidrs" {
  type        = list(string)
  description = "web public CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "app-private_cidrs" {
  type        = list(string)
  description = "app private CIDR values"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# in order to reference the subnet ids in my instance i choose to create a variable for it.
variable "subnet_ids" {
  type    = list(string)
  default = ["web-public1", "web-public2", "app-private1", "app-private2"]
}


# Availability zones variables
variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

# ccl route table variables for 2 route tables
variable "ccl-rt" {
  type        = list(string)
  description = "route tables"
  default     = ["ccl-rt1", "ccl-rt2"]
}

# Internet gateway attachment (route)  
variable "ccl-rt-cidr_block" {
  type        = string
  description = "cidr block"
  default     = "0.0.0.0/0"
}

# NAT Gateway CIDR block variable
variable "ccl-nat_cidr_block" {
  type        = string
  description = "Nat gateway cidr_block"
  default     = "0.0.0.0/0"
}

# variable for ccl-sg inbound and outbound rules
variable "ccl-sg" {
  type        = list(string)
  default     = "allow acess on port 80 and 22"
  description = "security groups"
}

# ingress rule #1
variable "ccl-ssh-port" {
  type        = string
  default     = "allow ssh access"
  description = "inbound rule for ssh"
}

variable "ssh-port" {
  type        = string
  default     = 22
  description = "ssh port"
}

variable "protocol_type" {
  type        = string
  default     = "tcp"
  description = "ingress protocol type"
}

variable "ccl-port" {
  type        = string
  default     = "0.0.0.0/0"
  description = "cidr block"
}

# ingress rule #2
variable "ccl-http-port" {
  type        = string
  default     = "allow http access"
  description = "inbound rule for http"
}

variable "http-port" {
  type        = string
  default     = 80
  description = "http port"
}

variable "mysqlport" {
  type        = string
  default     = "allow rds connection"
  description = "rds port connection"
}

variable "port" {
  type        = string
  default     = 3306
  description = "DB port"
}

# egress variables
variable "egress-port" {
  type        = string
  default     = 0
  description = "egress port"
}

variable "egress-protocol" {
  type        = string
  default     = -1
  description = "egress protocol type"
}

# variable for ccl-servers 
variable "aws_instance-ccl-server" {
  type        = list(string)
  default     = ["ami-084e8c05825742534", "ami-084e8c05825742534", "ami-084e8c05825742534", "ami-084e8c05825742534"]
  description = "ccl instance server"
}

# Instance type components 
variable "component" {
  type        = string
  default     = "t2.micro"
  description = "instance type"
}

#key-pair
variable "key_name" {
  type    = string
  default = "eden"
}

# instance tenancy
variable "ccl-ten" {
  type        = string
  default     = "default"
  description = "ccl-server tenancy"
}


# variables for the RDS db called = ccl-projectrds
variable "engine" {
  type        = string
  default     = "mysql"
  description = "engine for ccl-projectrds"
}

variable "engine_version" {
  type        = string
  default     = "8.0.30"
  description = "The engine version to use."
}

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "The instance type of the RDS instance."
}

variable "allocated_storage" {
  type        = string
  default     = "20"
  description = "The allocated storage in gibibytes."
}

variable "storage_type" {
  type        = string
  default     = "gp2"
  description = " The name of the RDS instance."
}

variable "identifier" {
  type        = string
  default     = "ccl-db"
  description = " The name of the RDS instance."
}

variable "username" {
  type        = string
  default     = "admin"
  description = "Username for the master DB user."
}

variable "password" {
  type        = string
  default     = "cloudrock"
  description = "Password for the master DB user."
}

variable "multi_az" {
  default     = true
  type        = string
  description = "Specifies the RDS instance is multi-AZ."
}




