{
  description = "Jake's NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        wsl = lib.nixosSystem {
          inherit system;
          specialArgs = {
            username = "jake";
            hostName = "wsl";
          };
          modules = [ ./. ];
        };
        vm = lib.nixosSystem {
          inherit system;
          specialArgs = {
            username = "jake";
            hostName = "vm";
          };
          modules = [ ./. ];
        };
        vm-de = lib.nixosSystem {
          inherit system;
          specialArgs = {
            username = "jake";
            hostName = "vm-de";
          };
          modules = [ ./. ];
        };
        ryzen = lib.nixosSystem {
          inherit system;
          specialArgs = {
            username = "jake";
            hostName = "ryzen";
          } // inputs;
          modules = [ ./. ];
        };
      };
    };
}
