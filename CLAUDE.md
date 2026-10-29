# claude-code-mod-api (front desk)

Nested ICM of a Nightlab bet (N-020). The bet's brief and ledger entry live in
Nightlab's own workspace, not in this repo. Read this, then
`00-catalog/CATALOG.md`, then only what it points to.

Rules: the script stays one file, offline, no dependencies, under 400 lines;
it copies names and signatures, never the declaration file's comments, and the
file itself is never committed; every committed `index/<version>/` is exactly
what `render()` makes of its `summary.json` (a test asserts it); a new version
is a new folder, a CHANGELOG line and a version bump together; the gate passes
on every push to main. Kill date 2026-11-12.
