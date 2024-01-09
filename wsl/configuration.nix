# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  # Configure SSH for Legacy Systems
  programs.ssh.ciphers = [
    "chacha20-poly1305@openssh.com"
    "aes256-gcm@openssh.com"
    "aes128-cbc"
    "3des-cbc"
    "aes192-cbc"
    "aes256-cbc"
    "aes128-ctr"
    "aes192-ctr"
    "aes256-ctr"
  ];
  programs.ssh.hostKeyAlgorithms = [
    "ssh-ed25519"
    "ssh-rsa"
  ];
  programs.ssh.kexAlgorithms = [
    "diffie-hellman-group1-sha1"
    "curve25519-sha256@libssh.org"
    "ecdh-sha2-nistp256"
    "ecdh-sha2-nistp384"
    "ecdh-sha2-nistp521"
    "diffie-hellman-group-exchange-sha256"
    "diffie-hellman-group14-sha1"
    "diffie-hellman-group1-sha1"
  ];
  programs.ssh.macs = [
    "hmac-sha1"
    "hmac-sha1-96"
    "hmac-sha2-256"
    "hmac-sha2-512"
    "hmac-md5"
    "hmac-md5-96"
    "umac-64@openssh.com"
    "umac-128@openssh.com"
    "hmac-sha1-etm@openssh.com"
    "hmac-sha1-96-etm@openssh.com"
    "hmac-sha2-256-etm@openssh.com"
    "hmac-sha2-512-etm@openssh.com"
    "hmac-md5-etm@openssh.com"
    "hmac-md5-96-etm@openssh.com"
    "umac-64-etm@openssh.com"
    "umac-128-etm@openssh.com"
  ];


  environment.systemPackages = with pkgs; [
    git
    gh
    ansible
    sshpass
    vim
    neovim
    tmux
    jq
    clang
    gcc
    lazygit
  ];  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
