data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "getmofree"
    workspaces = {
      name = "vpc"
    }
  }
}

output all {
    value = data.terraform_remote_state.vpc.outputs
}

resource "aws_db_subnet_group" "default" {
  name       = "terraform-cloud"
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.default.name
}