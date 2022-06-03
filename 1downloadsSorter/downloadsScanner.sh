#!/bin/bash

search_dir=/home/$USER/Downloads

# Quick access in case of renaming folders
# Downloads folder:
DOKUMENTY=Docs
KOMPRIM=Archives
EXECUTABLES=Execs
PYTHON=Code/Python
# Home folder:
PICS=Pictures

# Checking loop
# prereq: inotify-tools
while inotifywait -e modify,create,delete,move $search_dir
do
	until [ ! -f /home/docherak/Downloads/*.part* ]
	do
		sleep 5
#		echo "hello"
	done
	
	for file in ${search_dir}/*
	do
		filename=$(basename "$file")
#		echo $filename

		if [[ ($filename == *.txt*) ||
			($filename == *.doc*) ||
			($filename == *.pdf*) ||
			($filename == *.xlsx*) ]]
		then
			mv -n $search_dir/"$filename" /home/$USER/Downloads/$DOKUMENTY/"$filename"  
		
		elif [[ ($filename == *.zip*) ||
			($filename == *.tar*) ||
			($filename == *.gz*) ||
		        ($filename == *.br*) ||
			($filename == *.bz*) ||
			($filename == *.xz*) ||
			($filename == *.zst*) ]]
		then
			mv -n $search_dir/"$filename" /home/$USER/Downloads/$KOMPRIM/"$filename"  
		
		elif [[ ($filename == *.deb*) ||
			($filename == *.sh*) ||
			($filename == *.AppImage*) ||
			($filename == *.run*) ]]
		then
			mv -n $search_dir/"$filename" /home/$USER/Downloads/$EXECUTABLES/"$filename"  
		
		elif [[ ($filename == *.jpg*) ||
			($filename == *.png*) ||
			($filename == *.gif*) ||
			($filename == *.jpeg*) ||
			($filename == *.svg*) ]]
		then
			mv -n $search_dir/"$filename" /home/$USER/$PICS/"$filename"
		
		elif [[ ($filename == *.ipynb*) ||
			($filename == *.py*) ]]
		then
			mv -n $search_dir/"$filename" /home/$USER/Downloads/$PYTHON/"$filename"
		fi
	done

done
