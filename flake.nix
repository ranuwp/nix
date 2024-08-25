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
            bun

            # ZSH Configuration
            zsh
            oh-my-zsh
            zsh-autosuggestions
          ];
          shellHook = ''
            echo '### Welcome to NIX ###'

            # Setup ZSH
            export NIX_LOCAL_FOLDER=~/.local/share/ranuwp/nix
            mkdir $NIX_LOCAL_FOLDER -p
            cp ${oh-my-zsh}/share/oh-my-zsh $NIX_LOCAL_FOLDER -r
            echo 'export ZSH=${oh-my-zsh}/share/oh-my-zsh' > $NIX_LOCAL_FOLDER/.zshrc
            echo 'ZSH_THEME="robbyrussell"' >> $NIX_LOCAL_FOLDER/.zshrc
            echo 'plugins=(git timer zsh-interactive-cd)' >> $NIX_LOCAL_FOLDER/.zshrc
            echo '$NIX_LOCAL_FOLDER/oh-my-zsh/oh-my-zsh.sh' >> $NIX_LOCAL_FOLDER/.zshrc
            echo 'source ${zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> $NIX_LOCAL_FOLDER/.zshrc
            export ZDOTDIR=$NIX_LOCAL_FOLDER

            zsh
            echo '### Exit from NIX ###'
            exit
          '';
          };
      }
    );
}
