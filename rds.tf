/* Create an RDS using the MySQL with the latest version within the 5 engines. (Ports for to be opened 
are 3306,80 and 22). */

resource "aws_db_instance" "ccl-projectrds" {
  engine              = var.engine
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  allocated_storage   = var.allocated_storage
  storage_type        = var.storage_type
  identifier          = var.identifier
  username            = var.username
  password            = var.password
  multi_az            = var.multi_az
  port                = var.port
  skip_final_snapshot = true

  tags = {
    Name = "ccl-rds-db"
  }
}



/* 1. https://www.terraform.io/docs/providers/aws/r/db_instance.html = source

   2. Amazon RDS will default to a recent release if no version is specified.
   https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt 

   3. The DB instance class determines the computation and memory capacity of an Amazon RDS DB instance.
    it is recomended to only use db.t2 instance classes for development and test servers, 
    or other non-production servers.
   https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html 

    4. General purpose SSD is from 20GB to 32 TiB. for this project i will choose 20 GB

    5. https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Limits.html#RDS_Limits.Constraints
     paremeter for db identifier must be in lower case 
    and must not end with a hyphen */

# https://www.terraform.io/docs/providers/aws/r/security_group.html
