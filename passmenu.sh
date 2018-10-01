#!/bin/bash

shopt -s nullglob globstar

icons=/usr/share/icons/gnome/24x24

passmenu=$0
indent=""

indent_incr() {
    indent="$indent    "
}

indent_decr() {
    indent="${indent%    }"
}

puts() {
    echo "$indent$@"
}

puts_indent() {
    indent_incr
    puts "$@"
    indent_decr
}

menudir() {
    local dir=$1
    shift

    indent_incr
    
    local dirs=( $dir/*/ )
    local files=( $dir/*.gpg )

    for d in ${dirs[@]}; do
        d=${d%/}
        name=$(basename "$d")

        puts "<menu id=\"passmenu-$d\" label=\"$name/\" icon=\"$icons/places/folder.png\">"
        menudir $d
        puts "</menu>"
    done
    
    if [ ${#dirs[@]} -gt 0 -a ${#files[@]} -gt 0 ]; then
        echo "<separator/>"
    fi

    for f in ${files[@]}; do
        fullname="${f#$pwstore/}"
        fullname="${fullname%.gpg}"
        name=$(basename "$fullname")
        name=${name/_/__}

        puts "<menu id=\"passmenu-$f\" label=\"$name\" icon=\"$icons/status/dialog-password.png\">"
        indent_incr
        puts "<item label=\"Copy\" icon=\"$icons/actions/edit-copy.png\">"
        indent_incr
        puts "<action name=\"Execute\">"
        puts "<command>bash -c 'pass show -c \"$fullname\" 2>/dev/null'</command>"
        puts "</action>"
        puts "</item>"
        indent_decr
        puts "<item label=\"Insert\" icon=\"$icons/actions/edit-paste.png\">"
        indent_incr
        puts "<action name=\"Execute\">"
        puts "<command>bash -c 'pass show \"$fullname\" | { IFS= read -r pass; printf %s \"\$pass\"; } | xdotool type --clearmodifiers --file -'</command>"
        puts "</action>"
        indent_decr
        puts "</item>"
        indent_decr
        puts "</menu>"
    done

    indent_decr
}

pwstore=${PASSWORD_STORE_DIR-~/.password-store}
if [ -n "$1" ]; then
    pwstore=$1
fi

cat <<-EOF
<?xml version="1.0" encoding="utf-8"?>
<openbox_pipe_menu xmlns="http://openbox.org/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://openbox.org/ file:///usr/share/openbox/menu.xsd">

EOF

puts "<separator label=\"Password Store\" />"
menudir $pwstore
if command -v qtpass >/dev/null 2>&1; then
    puts "<separator />"
    puts "<item label=\"QtPass\">"
    indent_incr
    puts "<action name=\"Execute\">"
    puts_indent "<command>qtpass</command>"
    puts "</action>"
    indent_decr
    puts "</item>"
fi

cat <<-EOF
</openbox_pipe_menu>
EOF
