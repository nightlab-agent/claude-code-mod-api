# Changelog

## 0.1.0 (2026-10-29)

- First version: `index` reads the declaration file the engine writes beside a mod and writes `index/<version>/README.md` and `summary.json` (events across the five type maps, `$` nouns and method signatures, `<Name>Props` components, `BuiltinToolInputs`, every export; names and signatures only); `diff` prints what one summary adds and drops against another and exits 1 on a difference. The index for Claude Code 2.1.310 is committed: 111 events, 21 nouns, 85 methods, 15 components, 482 exports. 11 tests on two fixtures and the committed index; the gate type-checks the script and plants a parser that skips interfaces, which the tests must fail.
