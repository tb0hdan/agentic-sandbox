# Agentic Sandbox

A Docker-based sandbox environment for running AI coding assistants in isolation. Supports Claude Code, OpenAI Codex, and Google Gemini CLI.

## Features

- **Multi-agent support** - Run Claude, Codex, or Gemini in the same environment
- **Isolated execution** - Each agent runs in a Docker container
- **Persistent state** - Configurations and credentials persist between sessions
- **Unified interface** - Single command to launch any agent

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed and running
- API keys for the AI services you want to use:
  - [Anthropic API key](https://console.anthropic.com/) for Claude Code
  - [OpenAI API key](https://platform.openai.com/api-keys) for Codex
  - [Google AI API key](https://aistudio.google.com/apikey) for Gemini CLI

## Quick start

For Claude Code (default):
```bash
make compose
```

For Gemini CLI:
```bash
AGENT_TYPE=gemini make compose
``` 

For OpenAI Codex:
```bash
AGENT_TYPE=codex make compose
```

then

```bash
bin/agent-docker
```

For more information see the [Advanced Usage](docs/ADVANCED.md) guide.

## License

BSD 3-Clause License - See [LICENSE](LICENSE) for details.
