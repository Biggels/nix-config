{ config, pkgs, ... }:

{
  imports = [
    ../../common.nix
    # Uncomment the line below once you generate the hardware config on this machine!
    # ./hardware-configuration.nix
  ];

  networking.hostName = "bixos-ibp-9290";
}
