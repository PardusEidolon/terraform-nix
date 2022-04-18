################################################################################
# Hasicorp Credentials
################################################################################
terraform {
  cloud {
    organization = "jack-sandbox"
    workspaces {
      name = "nix-dev"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # version = "~> 4.0"
      # versions above 3.27 of terreform seem to have issues with credential files. issue solved by providing the verbose credential files paths in list.
    }
  }
}
################################################################################
# Amazon Credentials
################################################################################
provider "aws" {
  # shared_config_files      = ["~/.aws/config"]
  # shared_credentials_files = ["~/.aws/credentials"]
  region = local.region
}

locals {
  #   availability_zone = "${local.region}a"
  #   name              = "ec2-volume-attachment"
  region = "ap-southeast-2"
  tags = {
    Name        = "nix-dev"
    Owner       = "parduseidolon"
    Environment = "dev"
  }
}
################################################################################
# Ec2 Instance
################################################################################

resource "aws_instance" "ec2_instance" {
  ami                         = "ami-0b7dcd6e6fd797935" # Ubuntu Server 20.04 LTS
  instance_type               = "t2.micro"
  key_name                    = "id_ed25519"
  monitoring                  = true
  vpc_security_group_ids      = ["sg-0c9187e9829310c01"]
  subnet_id                   = "subnet-099bdb73dcd32aad6"
  associate_public_ip_address = true
  # user_data                 = # This feature does not seem to work

  root_block_device {
    encrypted   = true
    volume_type = "gp2"
    # throughput  = 350
    volume_size           = 20
    delete_on_termination = true
    tags                  = local.tags
  }

  # copy script into instances
  provisioner "file" {
    source      = "./nix-init.sh"
    destination = "/home/ubuntu/nix-init.sh"
  }
  # install nix & execute script
  provisioner "remote-exec" {
    inline = ["sudo curl https://nixos.org/releases/nix/nix-2.7.0/install | sh", "sudo bash nix-init.sh"]
  }
  # Connect via ssh
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
#     private_key = file("~/.ssh/id_ed25519")
    timeout     = "3m"
  }
  tags = local.tags
}
