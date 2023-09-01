{
  description = "Simple Nix Flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    system = "x86_64-darwin";
    devShells.${self.system}.default = nixpkgs.legacyPackages.${self.system}.mkShell {
      shellHook = ''
        echo "Welcome to the World of Nix"
      '';
    };
  };
}
