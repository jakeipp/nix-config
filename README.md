# nix-config
My NixOS System Configuration

I have a couple of configs depending on the application.
Right now I have one for a VM with desktop enviroment I named pve-de.
I also have a simple config for wsl which is currently mostly used for running ansible. 

## Commands
To use this repo without cloning it use the following command:
```bash
sudo nixos-rebuild switch --flake github:jakeipp/nix-config#hostname
```


These must be run from the root directory of this repo.
Switch to vm-de:
```bash
sudo nixos-rebuild switch --flake .#vm-de
```
Switch to wsl:
```bash
sudo nixos-rebuild switch --flake .#wsl --impure
```
