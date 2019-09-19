{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules
    ];
    
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  swapDevices = [ { device = "/dev/sda1";} ];

  networking.hostName = "bitcoin";
  networking.networkmanager.enable = true;

  # Configure the Nix package manager
  nixpkgs = {
    config.allowUnfree = true;
    config.packageOverrides = super: {
      libgestures = import ./pkgs/libgestures;
      libevdevc = import ./pkgs/libevdevc;
      xf86-input-cmnt = import ./pkgs/xf86-input-cmt;
      chromium-xorg-conf = import ./pkgs/chromium-xorg-conf;
      hcxtools = import ./pkgs/hcxtools;
      hcxdumptool = import ./pkgs/hcxdumptool;
    };
  };

  environment.systemPackages = with pkgs; [
    firefox
    mosh
    git
    tmux
    tree
    python
    gcc
    vim
    vlc
    gnumake
    unzip
    blueman
    networkmanager
    gnupg
    lsof
    usbutils
    nix-prefetch
    nix-prefetch-git
    nix-prefetch-github
    xinput_calibrator
    openssl
    hashcat
    qbittorrent
    libpcap
    python3
    python37Packages.pip
    unetbootin
    nixos.aircrack-ng
    bettercap

    #custom bitcoin related packages

    #custom pkgs for pentesting
    hcxtools
    hcxdumptool
  ];

  

  #Locale
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
    inputMethod.enabled = "uim";
  };
    
  #timezone
  time.timeZone = "Asia/Seoul";
    
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
 
  services.xserver = {
    enable = true;
    xkbModel = "chromebook";
    dpi = 182;
    desktopManager.xfce.enable = true;
    cmt.enable = true;
  };

  users.users.calvin = { #choose a username
    isNormalUser = true;
    home = "/home/calvin";
    
    extraGroups = [ "wheel" "networkmanager" "audio" "input" ];
  };

  programs.bash.shellAliases = {
    l = "ls";
    la = "ls -a";
    vi = "vim";
    googlePing = "ping 8.8.8.8";
    claer = "clear";
    clera = "clear";
    caler = "clear";
  };
 
  system.stateVersion = "19.03";

}
