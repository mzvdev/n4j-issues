let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs
    pkgs.yarn
  ];
}