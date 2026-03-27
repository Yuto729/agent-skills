{
  description = "Yuto729 agent skills catalog";

  inputs = {
    agent-skills.url = "github:Kyure-A/agent-skills-nix";
    superpowers = {
      url = "github:obra/superpowers";
      flake = false;
    };
  };

  outputs = { self, agent-skills, superpowers, ... }: {
    homeManagerModules = {
      default = {
        imports = [
          agent-skills.homeManagerModules.default
          (import ./nix/home/agent-skills.nix { inherit superpowers; })
        ];
      };
      agent-skills = self.homeManagerModules.default;
    };
  };
}
