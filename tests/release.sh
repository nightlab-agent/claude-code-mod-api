#!/bin/sh
# Release gate: tests, a type check of the script, file sizes, npm pack, and a planted bug that must fail the tests.
set -e
cd "$(dirname "$0")/.."
mkdir -p tests/.work
node --test tests/index.test.mjs
# Type check the script (JS with checkJs). TSC and TYPES default to Nightlab's tools folder; a missing tsc fails the gate.
TSC=${TSC:-/nightlab/tools/node_modules/.bin/tsc}
TYPES=${TYPES:-/nightlab/tools/node_modules/@types}
[ -x "$TSC" ] || { echo "FAIL no tsc at $TSC (set TSC)"; exit 1; }
"$TSC" --noEmit --allowJs --checkJs --noImplicitAny false --useUnknownInCatchVariables false --target es2022 --module nodenext --moduleResolution nodenext --typeRoots "$TYPES" --types node bin/mod-api-index.mjs
for f in bin/mod-api-index.mjs tests/index.test.mjs; do
  n=$(wc -l < "$f"); [ "$n" -le 400 ] || { echo "FAIL $f has $n lines"; exit 1; }
done
command -v npm >/dev/null || { echo "FAIL npm not found"; exit 1; }
npm pack --dry-run --ignore-scripts >/dev/null 2>&1 || { echo "FAIL npm pack --dry-run"; exit 1; }
# Planted bug: a parser that skips interfaces loses the nouns and the tools; the tests must catch it.
rm -rf tests/.work/mut.* 2>/dev/null || true
m=$(mktemp -d tests/.work/mut.XXXXXX) || exit 1
mkdir -p "$m/bin" "$m/tests" "$m/index"
sed 's/if (!m) continue$/if (!m || m[1] === "interface") continue/' bin/mod-api-index.mjs > "$m/bin/mod-api-index.mjs"
cmp -s bin/mod-api-index.mjs "$m/bin/mod-api-index.mjs" && { echo "FAIL mutation did not apply"; exit 1; }
cp -r tests/fixtures tests/index.test.mjs "$m/tests/"; cp -r index/* "$m/index/"; cp package.json CHANGELOG.md README.md "$m/"
if node --test "$m/tests/index.test.mjs" >/dev/null 2>&1; then echo "FAIL a parser that skips interfaces still passes the tests"; exit 1; fi
rm -rf "$m" 2>/dev/null || true
echo "gate PASS"
