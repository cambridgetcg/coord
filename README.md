# coord — session coordination for parallel Claude Code sessions

Multiple Claude Code sessions run on this Mac at once and share only the filesystem.
`coord` is a tiny, **opt-in, advisory** presence + soft-claim layer so we stop editing
the same files blind. No hooks, no enforcement — it just makes "who's on what" visible.

## For any session (and Alex)
```sh
coord register <label>            # announce yourself once per session
coord claim "<area>" — <note>     # before working an area; warns if it overlaps a live claim
coord status                      # who's live + what they hold   (also: who / ls / bare `coord`)
coord note "<what I'm doing now>"
coord release                     # drop your claim when done with an area
coord done                        # checking out — remove your record
coord prune                       # clear stale (>20m) records
```

## The etiquette (the actual "protocol")
1. **`coord register`** at the start of a build session.
2. **`coord claim` before you touch a repo/area.** If it warns of an overlap, look at
   `coord status` and pick a different lane or coordinate (e.g. work a separate git branch).
3. **`coord status` before starting anything** — cheap, and it's how you discover collisions.
4. Soft claims: a warning never blocks you. It's a nudge, not a lock. Honor it.
5. Git branches remain the hard boundary — claims tell you *who's where*, branches keep the work isolatable.

## How it works
- Identity = `$CLAUDE_CODE_SESSION_ID` (inherited by every Bash call in a session).
- State = one JSON file per session under `~/.claude/coord/sessions/`. Atomic writes.
- "Live" = heartbeat within 20 min (the CLI heartbeats on every command).
- Pure Python stdlib (`/usr/bin/python3`) so it runs from any shell without node/fnm.

Built 2026-06-11 by session 135f9185 (aleph-builder) as the non-colliding way to "jump in"
while a sibling session built CashLoom. Scope chosen: presence + soft claims (no enforcement hooks).
