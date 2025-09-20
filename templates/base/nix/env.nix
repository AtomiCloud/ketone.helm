{ pkgs, packages }:
with packages;
{
  system = [
    atomiutils
    infrautils
  ];

  dev = [
    pls
    git
  ];

  main = [
    infisical
  ];

  lint = [
    # core
    treefmt
    gitlint
    shellcheck
    infralint
    sg
  ];

  releaser = [
    sg
  ];
}
