# openbox-passmenu

This repository provides a script to access to the passwords saved in
the password manager [pass(1)](https://www.passwordstore.org/) directly from
the window manager [Openbox](http://openbox.org) with a custom menu.

![Screenshot of openbox-passmenu](https://raw.githubusercontent.com/raimue/openbox-passmenu/master/doc/openbox-passmenu.png)

## Installation

    $ git clone https://github.com/raimue/openbox-passmenu.git
    $ cd openbox-passmenu
    $ make

## Configuration

Add the following snippet into the `<menu>` section in your
Openbox configuration (usually at `~/.config/openbox/*rc.xml`):

    <menu>
      ...
      <file>$$PWD/passmenu.xml</file>
      ...
    </menu>

Also configure a keybinding to open the menu in `<keyboard>`:

    <keyboard>
      ...
      <keybind key=\"W-p\">
        <action name=\"ShowMenu\">
          <menu>passmenu</menu>
        </action>
      </keybind>
      ...
    </keyboard>

Finally, load the new configuration and try out the keybinding:

    $ openbox --reconfigure
