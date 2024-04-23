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