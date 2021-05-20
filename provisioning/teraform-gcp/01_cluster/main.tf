terraform {
  required_version = "~> 0.12"
}

provider "google" {
  #version = 3.1
  project = "jenkin-307611"
  region  = "global"
}
