## Advanced

### 1. Build the container

```bash
make build
```

### 2. Run an AI agent

```bash
# Run Claude Code
make claude

# Run OpenAI Codex
make codex

# Run Google Gemini CLI
make gemini
```

On first run, each agent will prompt you to authenticate with your API key.

## Usage

### Using Make (Recommended)

The Makefile provides convenient targets:

| Command | Description |
|---------|-------------|
| `make build` | Build the Docker container |
| `make claude` | Launch Claude Code |
| `make codex` | Launch OpenAI Codex |
| `make gemini` | Launch Google Gemini CLI |

### Using the Agent Script Directly

For custom directories:

```bash
./bin/agent <agent> <home_dir> <project_dir>
```

**Parameters:**
- `<agent>` - One of: `claude`, `codex`, or `gemini`
- `<home_dir>` - Directory for agent configs and credentials (mounted as `/home/node`)
- `<project_dir>` - Your project directory (mounted as `/home/node/<dirname>`)

**Example:**

```bash
./bin/agent claude ./my-home ./my-project
```

### Default Directories

When using `make` commands:
- Home directory: `build/home`
- Project directory: `build/home/project`

## Configuration

### API Key Setup

Each agent manages its own authentication. On first run:

- **Claude Code** - Prompts for Anthropic API key or OAuth login
- **Codex** - Prompts for OpenAI API key
- **Gemini CLI** - Prompts for Google authentication

Credentials are stored in the mounted home directory and persist between sessions.

### Project Instructions

To provide instructions to AI agents, create or edit these files in your project:

| File | Used By |
|------|---------|
| `CLAUDE.md` | Claude Code (primary) |
| `AGENTS.md` | Codex |
| `GEMINI.md` | Gemini CLI |

For consistent behavior, `AGENTS.md` and `GEMINI.md` redirect to `CLAUDE.md` by default.

## Architecture

```
┌─────────────────────────────────────────────────┐
│              Docker Container                   │
│  ┌─────────────────────────────────────────┐    │
│  │  Node.js 25 + AI CLI Tools              │    │
│  │  - @anthropic-ai/claude-code            │    │
│  │  - @openai/codex                        │    │
│  │  - @google/gemini-cli                   │    │
│  └─────────────────────────────────────────┘    │
│                     │                           │
│     ┌───────────────┴───────────────┐           │
│     ▼                               ▼           │
│  /home/node                  /home/node/project │
└─────┬───────────────────────────────┬───────────┘
      │                               │
      ▼                               ▼
  build/home                    Your Project
  (configs)                     (source code)
```

## Security

- Port 1455 (used by Codex) is bound to localhost only
- Containers run as non-root user (`node`)
- Credentials are stored locally, not in the image

## Troubleshooting

### Container not starting

Ensure Docker is running:
```bash
docker info
```

### Agent not found

Rebuild the container to get the latest versions:
```bash
make build
```

### Permission denied

Ensure the `bin/agent` script is executable:
```bash
chmod +x bin/agent
```

### API key issues

Delete the credentials and re-authenticate:
```bash
# For Claude
rm -rf build/home/.claude

# For Codex
rm -rf build/home/.codex

# For Gemini
rm -rf build/home/.gemini
```
