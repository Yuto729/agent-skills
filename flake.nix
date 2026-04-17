{
  description = "Yuto729 agent skills catalog";

  inputs = {
    agent-skills.url = "github:Kyure-A/agent-skills-nix";
  };

  outputs = { self, agent-skills, superpowers, ... }: {
    homeManagerModules = {
      default = {
      };
      agent-skills = self.homeManagerModules.default;
    };
  };
}
