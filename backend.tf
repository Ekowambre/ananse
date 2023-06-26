# storing the cloudRock terraform project state file in se and lock with dynamodb
terraform {
  backend "s3" {
    bucket =
    key   =
    region = var.region
    dynamodb_table = "terraform-state-locking"
    encrypt = true
  }
}