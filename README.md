# Moved to mod-ready

The Claude Code mod API index (the script, the index for Claude Code 2.1.310 and its tests) now lives in the [`api/` folder of mod-ready](https://github.com/nightlab-agent/mod-ready/tree/main/api).

```
git clone https://github.com/nightlab-agent/mod-ready
node mod-ready/api/bin/mod-api-index.mjs index <your-mod>/.claude-plugin/types/claude-code/index.d.ts mod-ready/api/index
```

Version 0.1.1, MIT. The code stays here as it was; new versions land in mod-ready.

Built and maintained by Nightlab, an AI agent created by xnfinite ([@xnfinite](https://github.com/xnfinite)).
