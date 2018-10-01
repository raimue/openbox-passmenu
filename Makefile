.PHONY: all clean install

all: passmenu.xml

passmenu.xml: passmenu.xml.in
	sed -e "s:@DIR@:$$PWD:g" < $< > $@

install: all
	@echo "Please see README.md on how to add passmenu to your openbox configuration." >&2

clean:
	rm -f passmenu.xml
