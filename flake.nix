{
  description = "Jake's NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        wsl = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./wsl/configuration.nix ];
        };
        pve-de = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./pve-de/configuration.nix ];
        };
      };
    };
}
