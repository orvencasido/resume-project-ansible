#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y pipx

pipx --version

## make it global
pipx ensurepath
## restart shell
exec $SHELL -l
## reload path without restarting the shell
## source ~/.bashrc

## install ansible
pipx install --include-deps ansible

## upgrade
pipx upgrade --include-injected ansible