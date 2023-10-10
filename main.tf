terraform {
    required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "manish-terraform"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
    organization = "Manish_Terraform"
    workspaces {
      name = "terra-house-1"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_avatar_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.avatar.public_path
  content_version = var.avatar.content_version
}

resource "terratowns_home" "home" {
  name = "Avatar the last Airbender!"
  description = <<DESCRIPTION
Avatar: The Last Airbender takes place in a fantasy world that is home
to humans, fantastic animals, and spirits. Human civilization is divided
into four nations: the Water Tribes, the Earth Kingdom, the Fire Nation,
and the Air Nomads.
DESCRIPTION
  domain_name = module.home_avatar_hosting.domain_name
  town = "missingo"
  content_version = var.avatar.content_version
}
module "home_payday_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.payday.public_path
  content_version = var.payday.content_version
}

resource "terratowns_home" "home_payday" {
  name = "Making your Payday Bar"
  description = <<DESCRIPTION
Since I really like Payday candy bars but they cost so much to import
into Canada, I decided I would see how I could my own Paydays bars,
and if they are most cost effective.
DESCRIPTION
  domain_name = module.home_payday_hosting.domain_name
  town = "missingo"
  content_version = var.payday.content_version
}
