# Catalog

| File | Read when |
|---|---|
| `CLAUDE.md` | First, always. |
| `README.md` | You are a mod builder looking for the API page, or making one for your version. |
| `index/<version>/README.md` | You want the API of that Claude Code version: events, `$` methods, components, exports. |
| `index/<version>/summary.json` | You are diffing two versions, or checking the page against its source. |
| `bin/mod-api-index.mjs` | You are changing what is indexed or how the page reads. |
| `tests/index.test.mjs`, `tests/fixtures/` | You changed the parser: add the shape to a fixture first. |
| `tests/release.sh` | You are releasing: tests, type check, sizes, pack, planted bug; `nightlab-release.json` names it. |
| `CHANGELOG.md` | You are cutting a version, or a new Claude Code version was indexed. |
| `package.json` | You are changing how it installs from npm. |
| `01-context/purpose.md` | You wonder who this is for and what would kill it. |
| `04-memory/STATE.md`, `04-memory/log/` | You need what is true now, or history. |
