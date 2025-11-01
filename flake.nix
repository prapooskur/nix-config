{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
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

  };


  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew, homebrew-core, homebrew-cask, speedtest }:
  let
    configuration = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;

      users.users.prasiddh = {
        home = "/Users/prasiddh";
      };

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;
        [
          vim
          htop
          btop
          tmux
          atuin
          fd
          ripgrep
          fastfetch
          fortune
          cowsay
          lolcat
          nmap
          jdk21
          jujutsu
          imagemagick
          tmux
          starship
          gh
          dua
          ffmpeg
        ];

      homebrew = {
        enable = true;
        onActivation.cleanup = "zap";

        caskArgs.no_quarantine = true;
        casks =
          [
             "visual-studio-code"
             "zed"
             "obsidian"
             "prismlauncher"
             "whisky"
             "losslesscut"
             "kicad"
             "karabiner-elements"
             "mx-power-gadget"
             "raycast"
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
      system.primaryUser = "prasiddh";

      # keyboard
      system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
      system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
      system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
      system.defaults.NSGlobalDomain.NSAutomaticInlinePredictionEnabled = false;
      system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
      system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
      system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;

      # dock
      system.defaults.dock.autohide = true;
      system.defaults.dock.autohide-delay = 0.08; # default 0.24
      system.defaults.dock.autohide-time-modifier = 0.66; # default 1.0
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#United-Kingdom-of-Great-Britain-and-Northern-Ireland
    darwinConfigurations."United-Kingdom-of-Great-Britain-and-Northern-Ireland" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.prasiddh =  import ./home.nix;

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
