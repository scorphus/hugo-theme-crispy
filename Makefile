all: criticalpath crisico share syntax

clean:
	@find . -iname \*.min.css -delete -print

criticalpath: layouts/partials/criticalpath.html

crisico: static/css/crisico.min.css

share: static/css/share.min.css

syntax: static/css/syntax.min.css

setup:
	@go get -u -v github.com/tdewolff/minify/cmd/minify

static/css/crisp.min.css: static/css/crisp.css
	@minify static/css/crisp.css -o static/css/crisp.min.css -v

static/css/crisico.min.css: static/css/crisico.css
	@minify static/css/crisico.css -o static/css/crisico.min.css -v

static/css/share.min.css: static/css/share.css
	@minify static/css/share.css -o static/css/share.min.css -v

static/css/syntax.min.css: static/css/syntax.css
	@minify static/css/syntax.css -o static/css/syntax.min.css -v

layouts/partials/criticalpath.html: static/css/crisp.min.css
	@echo '<style>' > layouts/partials/criticalpath.html
	@cat static/css/crisp.min.css >> layouts/partials/criticalpath.html
	@echo '</style>' >> layouts/partials/criticalpath.html
