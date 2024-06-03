{
  description = "Jake's NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
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
            pkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
          } // inputs;
          modules = [ ./. ];
        };
        legion = lib.nixosSystem {
          inherit system;
          specialArgs = {
            username = "jake";
            hostName = "legion";
          } // inputs;
          modules = [ ./. ];
        };
      };
    };
}
