{ ... }:
{

  system = {

    # desktop/windowing
    defaults.WindowManager.EnableStandardClickToShowDesktop = false;
    # disable tiling (handled by rectangle)
    defaults.WindowManager.EnableTiledWindowMargins = false;
    defaults.WindowManager.EnableTilingByEdgeDrag = false;
    defaults.WindowManager.EnableTilingOptionAccelerator = false;
    defaults.WindowManager.EnableTopTilingByEdgeDrag = false;
    # hide desktop icons, show widgets
    defaults.finder.CreateDesktop = false;
    defaults.WindowManager.StandardHideDesktopIcons = true;
    defaults.WindowManager.StandardHideWidgets = false;
    defaults.controlcenter.NowPlaying = true;

    # dock
    defaults.dock = {
      autohide = true;
      autohide-delay = 0.08; # default 0.24
      autohide-time-modifier = 0.66; # default 1.0
    };



    # fix insane finder defaults
    defaults.finder.QuitMenuItem = true;
    defaults.finder.ShowPathbar = true;
    defaults.finder._FXShowPosixPathInTitle = true;
    defaults.hitoolbox.AppleFnUsageType = "Do Nothing";


    # input devices
    # trackpad
    defaults.trackpad.FirstClickThreshold = 2; # firm
    # keyboard
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
      swapLeftCtrlAndFn = true;
    };
    # fix insane autocorrect defaults
    defaults.NSGlobalDomain = {
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      ApplePressAndHoldEnabled = false;
    };

    # key shortcuts
    defaults.CustomUserPreferences = {
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
}
