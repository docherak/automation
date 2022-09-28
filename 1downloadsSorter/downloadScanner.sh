#!/bin/bash

# PREREQS
# rename package

# TO GET VARIABLE OUTSIDE OF THE LOOP SCOPE
shopt -s lastpipe

# CONSTANT VARIABLES
DOWN="Downloads"

ARCH="Archives"
BOOKS="Books"
CODE="Code"
DOCS="Docs"
EXECS="Execs"

# VARIABLES FOR INCREMENTING
new_un=0

# FUNCTIONS
foo() {
    file -b "/home/$USER/$DOWN/$1" | awk '{print tolower($0)}'
}

bar() {
    cd /home/$USER/$DOWN
    file * | grep -v "directory" | rename 's/[^a-zA-Z0-9.]//g' *
}

# START NOTIFICATION
notify-send "DOWNLOADS SORTER" "Downloads sorter starting in 5s."
sleep 5

# REMOVE SPECIAL CHARACTERS FROM FILENAMES
bar

# LOOP THROUGH FILENAMES (WORKS FOR MOST TYPES)
ls /home/$USER/$DOWN | while read i
do
    # SORTING ITEMS:
    case "$(foo "$i")" in
        # CODE:
        *c++*  ) mv -n "/home/$USER/$DOWN/$i" "/home/$USER/$DOWN/$CODE/$i";;
        # ARCHIVES:
        *compressed*  ) mv -n "/home/$USER/$DOWN/$i" "/home/$USER/$DOWN/$ARCH/$i";;
        *archive*  ) mv -n "/home/$USER/$DOWN/$i" "/home/$USER/$DOWN/$ARCH/$i";;
        # EXECS:
        *executable*  ) mv -n "/home/$USER/$DOWN/$i" "/home/$USER/$DOWN/$EXECS/$i";;
        *package*  ) mv -n "/home/$USER/$DOWN/$i" "/home/$USER/$DOWN/$EXECS/$i";;
        # BOOKS
        *epub*  ) mv -n "/home/$USER/$DOWN/$i" "/home/$USER/$DOWN/$BOOKS/$i";;
        # DOCS:
        *text*  ) mv -n "/home/$USER/$DOWN/$i" "/home/$USER/$DOWN/$DOCS/$i";;
        *pdf*  ) mv -n "/home/$USER/$DOWN/$i" "/home/$USER/$DOWN/$DOCS/$i";;
        *document*  ) mv -n "/home/$USER/$DOWN/$i" "/home/$USER/$DOWN/$DOCS/$i";;
        *"microsoft word"*  ) mv -n "/home/$USER/$DOWN/$i" "/home/$USER/$DOCS/$i";;
        # IMAGE:
        *image*  ) mv -n "/home/$USER/$DOWN/$i" "/home/$USER/Pictures/$i";;
        # SKIP DIRECTORIES
        *directory*  ) continue;;
        # INCREMENT NO. OF NEW FILES
        * ) ((new_un++));;
    esac
done

# POP-UP NOTIFICATION
notify-send "DOWNLOADS SORTER" "Downloads folder has $new_un new uncategorized file(s)."
sleep 5
notify-send "DOWNLOADS SORTER" "Total amount of uncategorized files left: $(file -b "/home/$USER/$DOWN/"* | grep -v "directory" | wc -l)."
