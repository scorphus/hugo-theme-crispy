criticalpath: layouts/partials/criticalpath.html

setup:
	@npm install -g minifier

static/css/crisp.min.css: static/css/crisp.css
	@minify static/css/crisp.css

layouts/partials/criticalpath.html: static/css/crisp.min.css
	@echo '<style>' > layouts/partials/criticalpath.html
	@cat static/css/crisp.min.css >> layouts/partials/criticalpath.html
	@echo '</style>' >> layouts/partials/criticalpath.html
