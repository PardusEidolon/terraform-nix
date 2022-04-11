#!/bin/bash
#NIX222=sudo curl https://nixos.org/releases/nix/nix-2.7.0/install | sh
# NIXSINGLEUSER= sudo sh <(curl -L https://nixos.org/nix/install) --no-daemon

echo "Starting..."
# sudo mkdir -m 0755 /nix && chown root /nix

sleep 1
# intstall nix-unstable with flake support
# sh <(curl -L https://nixos.org/nix/install) --no-daemon

#rest for 5 seconds
echo "adding vaiables..."
# sleep 1

# #Load nix enviroment variables into bashrc
echo "source /home/$(whoami)/.nix-profile/etc/profile.d/nix.sh" >> .bashrc
sleep 1
source ./.bashrc
reset

# #install git onto nix profile
sleep 1
echo "installing git..."
sudo apt-get update
sudo apt-get install git

#enable nix-flake support
mkdir -p /home/ubuntu/.config/nix
touch /home/ubuntu/.config/nix/nix.conf
echo experimental-features = nix-command flakes >> /home/ubuntu/.config/nix/nix.conf
