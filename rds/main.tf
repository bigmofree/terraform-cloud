data "tfe_outputs" "vpc" {
  config = {
    organization = "getmofree"
    workspaces = {
      name = "vpc"
    }
  }
}

output all {
    value = data.tfe_outputs.vpc.outputs
}