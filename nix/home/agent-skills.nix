{ superpowers, ... }:
{
  programs.agent-skills = {
    enable = true;

    sources = {
      yuto729 = {
        path = ../../.;
        subdir = "skills";
        filter.maxDepth = 1;
      };
      superpowers = {
        path = superpowers;
        subdir = "skills";
        filter.maxDepth = 1;
      };
    };

    skills.enable = [
      "check-calendar"
      "check-mail"
      "check-tasks"
      "create-issue"
      "export-pr-review"
      "git-wt"
      "job-hunting"
      "learning-journal"
    ];

    skills.enableAll = [ "superpowers" ];

    targets.claude.enable = true;
  };
}
