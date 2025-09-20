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
    skopeo
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
