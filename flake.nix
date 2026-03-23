{
  description = "Yuto729 agent skills catalog";

  inputs = {
    agent-skills.url = "github:Kyure-A/agent-skills-nix";
  };

  outputs = { self, agent-skills, ... }: {
    homeManagerModules = {
      default = {
        imports = [
          agent-skills.homeManagerModules.default
          ./nix/home/agent-skills.nix
        ];
      };
      agent-skills = self.homeManagerModules.default;
    };
  };
}
