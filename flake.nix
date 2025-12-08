{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    speedtest = {
      url = "github:teamookla/homebrew-speedtest";
      flake = false;
    };

    notepad-next = {
      url = "github:dail8859/homebrew-notepadnext";
      flake = false;
    };

    sikarugir = {
      url = "github:Sikarugir-App/homebrew-sikarugir";
      flake = false;
    };

  };


  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, home-manager, nix-homebrew, homebrew-core, homebrew-cask, speedtest, notepad-next, sikarugir }:
  let
    configuration = { pkgs, ... }:
    let
      pkgs-unstable = import nixpkgs-unstable {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
    in
    {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;
        [
          # cli tools
          vim
          micro
          htop
          btop
          tmux
          nmap
          imagemagick
          ghostscript
          tmux
          dua
          ffmpeg
          fd
          fzf
          ripgrep
          nh
          stress
          stress-ng
          zoxide
          yazi
          zathura
          typst
          ocrmypdf
          poppler
          poppler-utils
          binsider
          nixfmt-rfc-style
          wget
          tdf
          texlive.combined.scheme-full
          hugo
          mediainfo
          tree

          # vcs
          git
          git-lfs
          gh
          jujutsu

          # shell
          starship
          atuin

          # programming
          jdk21
          deno

          # fun
          fortune
          cowsay
          lolcat
          fastfetch
          astroterm

          # from unstable, not in nixpkgs stable and brew breaks
          pkgs-unstable.msedit
          pkgs-unstable.bun
        ];

      homebrew = {
        enable = true;
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;

        caskArgs.no_quarantine = true;
        casks =
          [
             # programming
             "visual-studio-code"
             "zed"
             "orbstack"
             "podman-desktop"
             "wireshark-app"

             # productivity
             "zoom"
             "obsidian"
             "losslesscut"
             "kicad"
             "losslesscut"
             "notepadnext"
             "librewolf"
             "calibre"
             "localsend"

             # os utilities
             "utm"
             "raycast"
             "karabiner-elements"
             "alt-tab"
             "maccy"
             "rectangle"
             "notunes"

             # games
             "prismlauncher"
             "whisky"
             "sikarugir"

             # other
             "mx-power-gadget"
             "iina"
          ];

        brews =
          [
            "speedtest"
          ];
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      networking.hostName = "United-Kingdom-of-Great-Britain-and-Northern-Ireland";
      networking.computerName = "United Kingdom of Great Britain and Northern Ireland";

      networking.knownNetworkServices = [
        "Wi-Fi"
        "Thunderbolt Ethernet"
      ];

      networking.dns = [
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
      ];

      security.pam.services.sudo_local.touchIdAuth = true;


      # user-level options

      # home-manager breaks if this not declared
      users.users.prasiddh = {
        home = "/Users/prasiddh";
        shell = pkgs.zsh;
      };

      # defaults.nix options break if this not declared
      system.primaryUser = "prasiddh";





    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#United-Kingdom-of-Great-Britain-and-Northern-Ireland
    darwinConfigurations."United-Kingdom-of-Great-Britain-and-Northern-Ireland" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        ./modules/system.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.prasiddh =  import ./home.nix;
          home-manager.backupFileExtension = "hmbak";

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "prasiddh";

            # Optional: Declarative tap management
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "teamookla/speedtest" = speedtest;
              "dail8859/notepadnext" = notepad-next;
              "Sikarugir-App/homebrew-sikarugir" = sikarugir;
            };

            # Optional: Enable fully-declarative tap management
            #
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            # mutableTaps = false;
          };
        }
        # Optional: Align homebrew taps config with nix-homebrew
        ({config, ...}: {
          homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
        })

      ];
    };
  };
}
