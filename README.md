# agent-skills

Yuto729 用の Agent Skill をまとめて管理するリポジトリ。

## Structure

- `skills/` を source of truth として管理する
- 各 skill は `SKILL.md` を持つフラットなディレクトリとして置く
- 配布は `agent-skills-nix` を通して `~/.claude/skills` と `~/.codex/skills` に行う

## Files

- `flake.nix`: child flake
- `nix/home/agent-skills.nix`: Home Manager module
- `skills/`: local skills catalog

## Home Manager

```nix
inputs.agent-skills-local.url = "path:/home/mitomi/ghq/github.com/Yuto729/agent-skills";

imports = [
  inputs.agent-skills-local.homeManagerModules.default
];
```

反映:

```bash
home-manager switch --flake ~/.config/home-manager#${USER} --impure
```

## Notes

- `skills/` 以外の配布先は直接編集しない
- skill を追加したら `nix/home/agent-skills.nix` の `skills.enable` に追記する
- `filter.maxDepth = 1` でフラットな catalog として扱う
- target の structure はデフォルトの `symlink-tree` を使い、skills ディレクトリ全体を同期する
- `agent-skills-nix` の固定は `flake.lock` で管理し、更新時は `nix flake lock --update-input agent-skills` を使う
