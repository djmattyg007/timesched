all: compress

compress: lib/generated/data.js
	uglifyjs \
		lib/jquery.js \
		lib/jquery-ui.js \
		lib/angular.js \
		lib/bootstrap/js/bootstrap.js \
		lib/sortable.js \
		lib/slider.js \
		lib/ui-bootstrap.js \
		lib/moment.js \
		lib/moment-timezone.js \
		lib/typeahead.js \
			-c > lib/generated/compressed.js
	uglifyjs \
		lib/generated/data.js \
		-c > lib/generated/data-compressed.js

download-timezone-info:
	wget https://raw.githubusercontent.com/moment/moment-timezone/develop/data/packed/latest.json -O data/timezones.json
	wget http://unicode.org/repos/cldr/trunk/common/supplemental/windowsZones.xml -O data/windows_zones.xml
	wget http://unicode.org/repos/cldr/trunk/common/supplemental/supplementalData.xml -O data/supplemental_data.xml

lib/generated/data.js: data/*.json
	python3 data/convert.py

prepare-deploy: clean
	mkdir _deploy
	cp timesched.html _deploy/index.html
	cp -R lib _deploy
	cp -R static _deploy
	find _deploy -name '.git*' -print -delete

clean:
	rm -rf _deploy

.PHONY: compress download-timezone-info prepare-deploy clean
