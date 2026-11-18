
A simple nix flake for `tuido`.

## Installation
- Add to your flake.nix:

```Nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs;nixos-unstable";
    tuido-tui.url = "github:delta-psi/tuido-tui-flake";
  };

  outputs = { self, nixpkgs, tuido-tui, ... }@inptus: {
    ...
  }
}
```
- Add to your configuration.nix:
```Nix
{ pkgs, inputs, ... }:

{
  environment.systemPackages = [
    tuido-tui.packages.${system}.default
  ];
}
```
- Rebuild your system & enjoy
