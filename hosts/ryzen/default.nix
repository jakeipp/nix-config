# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, username, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "amdgpu" ];

  networking.hostName = "ryzen"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the GNOME Desktop Environment.
  programs.dconf.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
   };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Syncthing
  services = {
    syncthing = {
        enable = true;
        user = "jake";
        dataDir = "/home/jake/Documents";    # Default folder for new synced folders
        configDir = "/home/jake/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable virutalization
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  programs.virt-manager.enable = true;

  programs.wireshark.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
  };

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "Jake";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      firefox
      thunderbird
      remmina
      obsidian
      libreoffice
      chromium
      openconnect
      librewolf
      tailscale
      wireshark
      dbeaver
      # webex
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    vim
    wget
    neovim
    xclip
    git
    gh
    jq
    tmux
    lazygit
    lazydocker
    lazycli
    go
    sqlite-interactive
    curl
    htop
    unzip
    gcc
    dig
    zsv
    bind
    busybox
    toybox
    radeontop
    usbutils
    pciutils
    virt-manager
    nmap
    dnsrecon
    gnome3.gnome-tweaks
    gnome3.gnome-shell-extensions
    gnomeExtensions.forge
  ];
  nixpkgs.config.allowUnfreePredicate = pkg: 
    builtins.elem (lib.getName pkg) [
      "obsidian"
      "steam"
      "steam-original"
      "steam-run"
      # "webex"
    ];
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
