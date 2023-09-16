packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
  }
}

variable "cloud_token" {
  type    = string
  default = "${env("VAGRANT_CLOUD_TOKEN")}"
}

variable "box_version" {
  type    = string
  default = "1.0.0"
}

source "vagrant" "centos8_puppet" {
  add_force    = true
  communicator = "ssh"
  provider     = "virtualbox"
  source_path  = "generic/centos8"
  box_version  = "v4.2.16"
  output_dir   = "box_puppet"
}

build {
  sources = ["source.vagrant.centos8_puppet"]

  provisioner "shell" {
    script = "scripts/centos8_puppet.sh"
  }

  post-processors {
    post-processor "vagrant-cloud" {
      access_token = "${var.cloud_token}"
      box_tag      = "devops_jason/centos8_puppet"
      version      = "${var.box_version}"
    }
  }
}
