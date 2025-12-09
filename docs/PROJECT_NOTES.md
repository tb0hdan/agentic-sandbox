# Agentic Sandbox - Project Notes

## Project Overview

**Agentic Sandbox** is a Docker-based development environment that provides a unified sandbox for running multiple AI coding assistants. It supports three major AI CLI tools:

- **Claude Code** (Anthropic) - `@anthropic-ai/claude-code`
- **Codex** (OpenAI) - `@openai/codex`
- **Gemini CLI** (Google) - `@google/gemini-cli`

The project enables developers to experiment with and compare different AI coding assistants in an isolated, reproducible environment.

## Project Structure

```
agentic-sandbox/
├── bin/
│   └── agent              # Entrypoint script for launching agents
├── build/
│   └── home/              # Mounted as /home/node in container (runtime data)
├── deployments/
│   └── Dockerfile         # Container image definition
├── docs/
│   └── PROJECT_NOTES.md   # This file
├── AGENTS.md              # Codex agent instructions (redirects to CLAUDE.md)
├── CLAUDE.md              # Claude Code instructions
├── GEMINI.md              # Gemini CLI instructions (redirects to CLAUDE.md)
├── LICENSE                # BSD 3-Clause License
├── Makefile               # Build and run commands
└── README.md              # Basic project description
```

## Architecture

### Docker Container

The sandbox runs on `node:25` base image with all three AI CLI tools pre-installed globally via npm:

- `@anthropic-ai/claude-code@latest`
- `@openai/codex@latest`
- `@google/gemini-cli@latest`

### Volume Mounts

The container uses two volume mounts:
1. **Home directory** (`$HOME_DIR` → `/home/node`) - Persists AI tool configurations, credentials, and cache
2. **Project directory** (`$PROJECT_DIR` → `/home/node/project`) - The working directory for the AI agent

### Port Mapping

- Port `1455` is exposed for Codex (mapped to localhost only for security)

## Usage

### Building the Container

```bash
make build
# or
docker build -t tb0hdan/agentic-sandbox -f deployments/Dockerfile .
```

### Running AI Agents

```bash
# Run Claude Code
make claude

# Run OpenAI Codex
make codex

# Run Google Gemini CLI
make gemini
```

### Manual Execution

```bash
./bin/agent <claude|codex|gemini> <home_dir> <project_dir>
```

Default directories:
- `HOME_DIR`: `build/home`
- `PROJECT_DIR`: `build/home/project`

## Configuration Files

### AI Agent Instructions

All three AI tools are configured to read `CLAUDE.md` for project instructions:
- `CLAUDE.md` - Primary instruction file
- `AGENTS.md` - Redirects to CLAUDE.md (for Codex compatibility)
- `GEMINI.md` - Redirects to CLAUDE.md (for Gemini compatibility)

This unified approach ensures consistent behavior across all AI assistants.

## Current Implementation Status

### Completed
- [x] Docker container with all three AI CLI tools
- [x] Unified agent launcher script (`bin/agent`)
- [x] Makefile targets for build and agent execution
- [x] Volume mount configuration for persistent state
- [x] Instruction files for all three AI tools
- [x] BSD 3-Clause license

### Future Considerations
- [ ] Add health checks to Dockerfile
- [ ] Support for additional AI coding assistants
- [ ] Environment variable configuration for API keys
- [ ] Multiple project directory support
- [ ] Automated testing of agent functionality
- [ ] CI/CD pipeline for container builds

## Security Considerations

1. **Localhost-only port binding** - Port 1455 is bound to 127.0.0.1 to prevent external access
2. **Isolated environment** - Each agent runs in an isolated container
3. **Credential management** - Credentials are stored in the mounted home directory, not baked into the image

## Dependencies

- Docker
- Make (optional, for convenience targets)
- API keys for respective AI services (configured at runtime)

## License

BSD 3-Clause License - Copyright (c) 2025, Bohdan Turkynevych

## Changelog

### Initial Release
- Created Docker-based sandbox environment
- Added support for Claude Code, Codex, and Gemini CLI
- Implemented unified launcher script
- Established project documentation structure
