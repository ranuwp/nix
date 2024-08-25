{
  description = "Simple Nix Flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        packages = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
      in
      with packages; {
        devShell = mkShell {
          buildInputs = [
            zsh
          ];
        shellHook = ''
          echo "### Welcome to NIX ###"
          zsh
          echo "Exiting from NIX #"
          exit
        '';
        };
      }
    );
}
