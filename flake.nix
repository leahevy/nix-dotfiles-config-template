{
  description = "Config Flake for NXCore";

  inputs.core.url = "github:leahevy/nix-dotfiles/main";

  outputs =
    { self, core, ... }@inputs:
    core.configure {
      config = self;
      additionalInputs = builtins.removeAttrs inputs [
        "core"
        "self"
      ];
    };
}
