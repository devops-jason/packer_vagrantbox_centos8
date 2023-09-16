variable "version" {
  type    = string
  default = "1.0.0"
}

variable "cloud_token" {
  type    = string
  default = "${env("VAGRANT_CLOUD_TOKEN")}"
}

packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
  }
}

source "vagrant" "centos8_chef" {
  add_force     = true
  communicator  = "ssh"
  provider      = "virtualbox"
  source_path   = "generic/centos8"
  box_version   = "v4.2.16"
  output_dir    = "target"
  synced_folder = "files"
}

build {
  sources = ["source.vagrant.centos8_chef"]

  provisioner "shell" {
    script = "scripts/centos8_chef.sh"
  }

  post-processors {
    post-processor "vagrant-cloud" {
      access_token = "${var.cloud_token}"
      box_tag      = "devops_jason/centos8_chef"
      version      = "${var.version}"
    }

  }

}
