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

## Adding a skill

1. `skills/<skill-name>/` を作り、`SKILL.md` を追加する
2. `nix/home/agent-skills.nix` の `skills.enable` に skill ID を追記する
3. この repo を commit / push する
4. 親の Home Manager repo で local input を更新する

```bash
cd ~/.config/home-manager
nix flake lock --update-input agent-skills-local
home-manager switch --flake ~/.config/home-manager#${USER} --impure
```

補足:

- skill を追加・編集したときに更新するのは親 flake 側の `agent-skills-local` input
- `agent-skills` input は、この child flake が参照している `agent-skills-nix` 自体を更新したいときに使う
