{ ... }:
{
  programs.agent-skills = {
    enable = true;

    sources = {
      yuto729 = {
        path = ../../.;
        subdir = "skills";
        filter.maxDepth = 1;
      };
    };

    skills.enable = [
      "check-calendar"
      "check-mail"
      "check-tasks"
      "export-pr-review"
      "git-wt"
    ];

    targets.claude.enable = true;
    targets.codex.enable = true;
  };
}
