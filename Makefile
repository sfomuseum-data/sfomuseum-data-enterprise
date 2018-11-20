OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')

prune:
	git gc --aggressive --prune

rm-empty:
	find data -type d -empty -print -delete

scrub: rm-empty prune

stats:
	if test ! -d docs/stats; then mkdir -p docs/stats; fi
	utils/$(OS)/wof-stats-counts -pretty -custom 'properties.sfomuseum:placetype' -out docs/stats/counts.json ./
	utils/$(OS)/wof-stats-du -pretty > docs/stats/diskusage.json ./

# https://github.com/whosonfirst/py-mapzen-whosonfirst-utils >= 0.4.5

wikipedia:
	wof-assign-wikipedia-concordances -d . -p $(PAGE) $(IDS)
