.PHONY: build

HOME_DIR ?= "build/home"
PROJECT_DIR ?= "build/home/project"

all: build

build:
	@docker build -t tb0hdan/agentic-sandbox -f deployments/Dockerfile .

dirs:
	@mkdir -p $(HOME_DIR) $(PROJECT_DIR)

claude: dirs
	@bin/agent claude $(HOME_DIR) $(PROJECT_DIR)

codex: dirs
	@bin/agent codex $(HOME_DIR) $(PROJECT_DIR)

gemini: dirs
	@bin/agent gemini $(HOME_DIR) $(PROJECT_DIR)

compose: dirs
	@docker compose -f deployments/docker-compose.yml up
