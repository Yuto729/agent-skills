---
name: git-wt
description: git-wtでGit worktreeを扱うスキル。sourceブランチから新しいworktreeを切る、worktree一覧を表示する、不要なworktreeを安全に削除するときに使用する。「git-wtでworktree作って」「origin/mainからbranchを切ってworktreeを生やして」「worktree一覧を見せて」「このworktreeを消して」などのリクエストで発動。明示的に /git-wt でも呼び出し可能。
---

# Git WT

`git-wt` を使って worktree の作成、一覧表示、削除を行う。

## 前提

- Git 管理下のリポジトリ直下、またはその配下で実行する
- `git-wt` は `git wt` サブコマンドとして使う
- 作業前に `git status --short` と `git branch --show-current` で現在地を確認すると安全

## 基本コマンド

```bash
# worktree一覧を表示
git wt

# JSON形式で一覧を表示
git wt --json

# 新しいbranch/worktreeを作成または既存worktreeへ移動
git wt <branch-or-worktree>

# sourceブランチ/開始点を指定して新しいworktreeを作成
git wt <new-branch> <start-point>

# 例: origin/main から feature ブランチを切る
git wt feature/some-task origin/main

# 安全に削除（マージ済みbranchのみ削除）
git wt -d <branch|worktree|path>

# 強制削除
git wt -D <branch|worktree|path>
```

## ガイドライン

- 一覧表示:
  まず `git wt` で現在の worktree 一覧を確認する。機械的に処理したいときだけ `git wt --json` を使う。
- sourceブランチから切る:
  新しい作業ブランチを既存 branch や remote branch から作るときは `git wt <new-branch> <start-point>` を使う。通常の開始点は `origin/main` か `origin/develop`。
- 既存worktreeへ移動:
  対象 branch/worktree がすでに存在するなら `git wt <name>` でその worktree へ移動できる。
- 削除:
  まず `git wt -d` を使う。未マージ branch などで失敗した場合だけ、ユーザー確認のうえで `git wt -D` を使う。
- 削除対象の指定:
  branch 名、worktree 名、path のどれでも指定できる。曖昧さを避けたいときは path を使う。
- デフォルトブランチ保護:
  `main` / `master` などの default branch は保護される。通常は削除しない前提で扱う。

## 推奨フロー

### 1. sourceブランチから新しいworktreeを切る

```bash
git fetch origin
git wt feature/some-task origin/main
```

- ベースを明示したいなら `origin/main` のように remote branch を使う
- リポジトリ運用が `develop` 起点なら `origin/develop` を使う

### 2. worktree一覧を確認する

```bash
git wt
```

- 現在どの branch がどの path にあるかを確認してから次の操作に進む

### 3. 不要なworktreeを削除する

```bash
git wt -d feature/some-task
```

- 安全削除が失敗した場合だけ理由を確認する
- 強制削除が必要なら、ユーザー確認後に `git wt -D feature/some-task` を使う

## 補足

- `git wt <name>` は作成と移動を兼ねるため、既存 branch/worktree に対しても使える
- `git wt --nocd <name>` を使うと、worktree へ移動せず path だけ出力できる
- `wt.basedir` を設定している環境では、worktree 名だけで作成先が決まる
- worktree をリポジトリ内に置くと各種ツールが重複走査することがある。必要なら `.git/wt` や repo 外の basedir を検討する
