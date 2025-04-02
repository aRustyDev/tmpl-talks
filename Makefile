

all: init build

init:
	@./scripts/init/repo.sh
	@./scripts/init/slidev.sh
	@./scripts/init/pre-commit.sh
	@./scripts/init/repo.sh
	@npm init slidev

build:
	@npm run build
	@npm run export

clean:
	rm -f package.json
