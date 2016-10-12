all: criticalpath crisico

criticalpath: layouts/partials/criticalpath.html

crisico: static/css/crisico.min.css

setup:
	@go get -u -v github.com/tdewolff/minify/cmd/minify

static/css/crisp.min.css: static/css/crisp.css
	@minify static/css/crisp.css -o static/css/crisp.min.css -v

static/css/crisico.min.css: static/css/crisico.css
	@minify static/css/crisico.css -o static/css/crisico.min.css -v

layouts/partials/criticalpath.html: static/css/crisp.min.css
	@echo '<style>' > layouts/partials/criticalpath.html
	@cat static/css/crisp.min.css >> layouts/partials/criticalpath.html
	@echo '</style>' >> layouts/partials/criticalpath.html
