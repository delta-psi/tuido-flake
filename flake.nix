
{
  description = "Nix flake for tuido-tui";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let 
      supportedSystems = [ 
        "x86_64-linux" 
        "aarch64-linux" 
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in {
      packages = forAllSystems (system:
        let 
          pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.python3Packages.buildPythonApplication rec {
            pname = "tuido-tui";
            version = "0.3.1";
            pyproject = true;
            
            src = pkgs.fetchFromGitHub {
              owner = "dmostoller";
              repo = "tuido";
              rev = "v${version}";
              hash = "sha256-v7+pRvvKoEWMocFopIkbAJzs2Q70LVyv04GGyu6LeMo=";
            };
            
            nativeBuildInputs = with pkgs.python3Packages; [
              setuptools
            ];

            propagatedBuildInputs = with pkgs.python3Packages; [
              textual
              cryptography
              httpx
              plotext
              pyperclip
              python-dotenv
              requests
              textual-dev
              tree-sitter
              tree-sitter-markdown
            ];
            
            doCheck = false;
          };
        }
      );
    };
}
