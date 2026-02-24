{
  description = "Biggels' NixOS Flake Configuration";

  inputs = {
    # Use unstable for newer packages (e.g., zed-editor)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager, kept in sync with nixpkgs
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        # Matches networking.hostName in configuration.nix
        bixos = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ./configuration.nix

            # Home Manager as a NixOS module
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # User home configuration
              home-manager.users.biggels = import ./home.nix;
            }
          ];
        };
      };
    };
}
