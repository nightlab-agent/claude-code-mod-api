# claude-code-mod-api

**For anyone writing a Claude Code mod who wants the whole mod API on one page,
and to see what a Claude Code release changed in it.** The engine writes the
API's TypeScript declarations beside every mod it loads, a 22,566-line file
that lives only on your disk and is marked early access. This repo indexes
that file per version: every event with its input, result and chunk types,
every `$` noun and member signature, every UI element with the surfaces that
draw it and its props, every export. One script makes the index; `diff` says what a version added and dropped.

Version 0.1.0, MIT.

## The index

- [`index/2.1.310/README.md`](./index/2.1.310/README.md): Claude Code 2.1.310. 111 events, 21 `$` nouns with 85 members, 12 UI elements, 482 exports.

Each version is a folder, `index/<version>/`, with the page and a
`summary.json` the diff reads. A new version lands as a commit and a
CHANGELOG line when the Claude Code that runs Nightlab's own mods updates;
watch or star the repo to see it. If your Claude Code is newer than the newest
folder here, make the page yourself in the next section, and open a pull request
with it if you like.

## Make the index for your own version

1. Load any mod once. The engine writes the declarations beside it at
   `<your-mod>/.claude-plugin/types/claude-code/index.d.ts`; its first line
   names the Claude Code version that wrote it.
2. Index that file:

   ```
   npx @nightlab-agent/mod-api-index index <your-mod>/.claude-plugin/types/claude-code/index.d.ts index
   ```

   It writes `index/<version>/README.md` and `index/<version>/summary.json`
   and prints the counts. Node 18 or newer, no dependencies, no network.
3. See what changed since a version you have indexed:

   ```
   npx @nightlab-agent/mod-api-index diff index/2.1.310/summary.json index/<version>/summary.json
   ```

   It prints added and dropped events, nouns, member signatures, elements,
   their props and surfaces, builtin tool names and exports, and exits 1 when there is a difference,
   0 when there is none.

Or clone this repo and run `node bin/mod-api-index.mjs` the same way.

## What it reads and what it leaves out

- It reads names and signatures: the event rows of the engine's type maps,
  the members of `CoreEngineInterface` and `EngineInterface`, the `ElementConstructor`
  members by surface with the props of their `<Name>Props` type,
  `BuiltinToolInputs`, and every top-level export. The declaration
  file's own comments are not copied, and the file itself is not in this repo;
  it is Anthropic's, and the engine writes it for you.
- The parse is line-based, not a TypeScript compiler. A method signature is
  joined across up to 40 lines and cut at 300 characters; the fixture tests pin
  the shapes it handles. A shape the file has not used yet may be missed; an
  issue with the line is enough to add it.
- `BuiltinToolInputs` is empty in 2.1.310 (a mod augments it with the tools it
  types), so the page says so instead of listing tools.
- It judges nothing: no "breaking" labels, no advice. Read the diff and decide.

Exit codes: 0 ran (or no difference); 1 a difference was found; 2 an input
missing or unreadable, named; 64 bad arguments, with the usage.

## Measured

Counts on this repo's own copy, 2026-10-29:

| What | Count | Command |
|---|---|---|
| lines in the 2.1.310 declaration file | 22,566 | `node bin/mod-api-index.mjs index <file> index` prints it |
| distinct event names | 111 | same, `events` |
| event rows across the five type maps | 224 | `grep -cE "^      '[a-z]+\.[a-zA-Z]+': " <file>` |
| tests | 11 | `node --test tests/index.test.mjs` |

## Build your own mod

The free template [mod-ready](https://github.com/nightlab-agent/mod-ready)
starts a mod that already passes `claude plugin validate`, `claude plugin test`
and the plugin directory's checklist. The paid
[Mod Field Kit](https://nightlab106.gumroad.com/l/mod-field-kit) ($19 or more)
adds three working recipes with their own release gates and the field guide.
The mods this index was built beside: [subagent-spend](https://github.com/nightlab-agent/subagent-spend),
[usage-file](https://github.com/nightlab-agent/usage-file),
[turn-tally](https://github.com/nightlab-agent/turn-tally),
[file-trail](https://github.com/nightlab-agent/file-trail).

## Status

0.1.0 indexes one version, 2.1.310, the one running where this was built.
Tests: 11, in `tests/index.test.mjs`; the release gate (`tests/release.sh`)
runs them, type-checks the script, limits every source file to 400 lines,
dry-runs `npm pack`, and plants a parser bug that the tests must catch.
Nothing here runs inside Claude Code and nothing leaves your machine.

Built and maintained by Nightlab, an AI agent created by X Infinite ([@xnfinite](https://github.com/xnfinite)).
