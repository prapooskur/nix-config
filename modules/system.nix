{ ... }:
{

  system = {

    # keyboard (why isn't this in defaults)
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = false;
      swapLeftCtrlAndFn = false;
    };

    defaults = {
      # desktop/windowing
      WindowManager = {
        EnableStandardClickToShowDesktop = false;
        # disable tiling (handled by rectangle)
        EnableTiledWindowMargins = false;
        EnableTilingByEdgeDrag = false;
        EnableTilingOptionAccelerator = false;
        EnableTopTilingByEdgeDrag = false;
        StandardHideDesktopIcons = true;
        StandardHideWidgets = false;
      };
      # hide desktop icons, show widgets
      finder.CreateDesktop = false;
      # show now playing widget in top bar
      controlcenter.NowPlaying = true;

      # dock
      dock = {
        autohide = true;
        autohide-delay = 0.08; # default 0.24
        autohide-time-modifier = 0.66; # default 1.0
      };

      # fix insane finder defaults
      finder = {
        QuitMenuItem = true;
        ShowPathbar = true;
        _FXShowPosixPathInTitle = true;
      };

      # trackpad
      trackpad.FirstClickThreshold = 2; # firm
      # disable emoji popup
      hitoolbox.AppleFnUsageType = "Do Nothing";
      # fix insane autocorrect defaults
      NSGlobalDomain = {
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        ApplePressAndHoldEnabled = false;
      };

      # key shortcuts
      CustomUserPreferences = {
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {

            # disable dock autohide toggle
            "52" = {
              enabled = false;
              value = {
                parameters = [
                  100
                  2
                  1572864
                ];
                type = "standard";
              };
            };

            # disable stage manager toggle
            "222" = {
              enabled = false;
              value = {
                parameters = [
                  65535
                  65535
                  0
                ];
                type = "standard";
              };
            };

            # Disable: Move focus to next window (Cmd + `) - alttab handles this for us (keep default cmd-tab)
            "27" = {
              enabled = false;
              value = {
                parameters = [
                  96
                  50
                  1048576
                ];
                type = "standard";
              };
            };

            # Disable F11 to show desktop
            "36" = {
              enabled = false;
              value = {
                parameters = [
                  65535
                  103
                  8388608
                ];
                type = "standard";
              };
            };

            # Save picture of selected area as a file (Cmd + Shift + S)
            "31" = {
              enabled = true;
              value = {
                parameters = [
                  115
                  1
                  1179648
                ];
                type = "standard";
              };
            };
            # Disable 'Cmd + Space' for Spotlight Search
            "64" = {
              enabled = false;
            };

            # disable quick note on fn+q
            "190" = {
              enabled = false;
              value = {
                parameters = [
                  113
                  12
                  8388608
                ];
                type = "standard";
              };
            };
          };
        };
      };
    };
  };
}
