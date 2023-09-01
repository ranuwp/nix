{
  description = "Simple Nix Flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    system = "x86_64-darwin";
    packages = nixpkgs.legacyPackages.${self.system};
    devShells.${self.system}.default = self.packages.mkShell {
      buildInputs = [
        self.packages.cowsay
      ];
      shellHook = ''
        echo "Welcome to the World of Nix"
      '';
    };
  };
}
