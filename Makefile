.PHONY: all clean install

all: passmenu.xml

passmenu.xml: passmenu.xml.in
	sed -e "s:@DIR@:$$PWD:g" < $< > $@

install: all
	@echo "******************************************************************"
	@echo ""
	@echo "  Add the following snippet into the <menu> section in your"
	@echo "  openbox configuration (usually at ~/.config/openbox/*rc.xml):"
	@echo ""
	@echo "  <menu>"
	@echo "    ..."
	@echo "    <file>$$PWD/passmenu.xml</file>"
	@echo "    ..."
	@echo "  </menu>"
	@echo ""
	@echo "******************************************************************"

clean:
	rm -f passmenu.xml
