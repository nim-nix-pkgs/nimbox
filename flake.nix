{
  description = ''A Rustbox-inspired termbox wrapper'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."nimbox-master".dir   = "master";
  inputs."nimbox-master".owner = "nim-nix-pkgs";
  inputs."nimbox-master".ref   = "master";
  inputs."nimbox-master".repo  = "nimbox";
  inputs."nimbox-master".type  = "github";
  inputs."nimbox-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimbox-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}