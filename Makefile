THEME := themes/tailwind
PUBLIC := public
DIST := dist
HUGO_THEME_REPO := https://github.com/cgxxv/hugo-theme-tailwind.git

.PHONY: all
all: build

.PHONY: clean
clean:
	# rm -rf $(THEME)
	rm -rf $(PUBLIC) $(DIST)

.PHONY: server
server: $(THEME)
	hugo server

.PHONY: build
build: $(THEME)
	hugo --cleanDestinationDir

.PHONY: build-offline
build-offline: $(THEME)
	hugo --baseURL="/" --cleanDestinationDir

.PHONY: update
update: $(THEME)

$(THEME): $(THEME)/theme.toml
$(THEME)/theme.toml:
	if [ $(shell find "$$(dirname $@)" -type f | wc -l) -eq 0 ]; then \
		git submodule add $(HUGO_THEME_REPO) $(THEME); \
	else \
		git submodule update --remote; \
	fi

.PHONY: ddd
ddd:
	echo $(THEME)
	echo $(PUBLIC)
	hugo -v

.PHONY: tools
tools:
	CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest