{ config, pkgs, ... }:
{
  imports = [
    ./fish
    ./starship
    ./common
  ];
}
