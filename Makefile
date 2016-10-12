all: criticalpath icons

criticalpath: layouts/partials/criticalpath.html

icons: static/css/icons.min.css

setup:
	@go get -u -v github.com/tdewolff/minify/cmd/minify

static/css/crisp.min.css: static/css/crisp.css
	@minify static/css/crisp.css -o static/css/crisp.min.css -v

static/css/icons.min.css: static/css/icons.css
	@minify static/css/icons.css -o static/css/icons.min.css -v

layouts/partials/criticalpath.html: static/css/crisp.min.css
	@echo '<style>' > layouts/partials/criticalpath.html
	@cat static/css/crisp.min.css >> layouts/partials/criticalpath.html
	@echo '</style>' >> layouts/partials/criticalpath.html
