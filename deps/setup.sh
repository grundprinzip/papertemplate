#!/bin/bash

echo -n "Do you want to use rDBLP to manage references: [y/n]":
read dblp
if [ "$dblp" == "y" ] 
  then
  bundle
  echo "\$use_dblp = 1;" >> deps/latexmkrc
fi

echo -n "Add common files to the ignore list of your version control system: [y/n]"
read ignore
if [ "$ignore" == "y" ] 
  then
  make addignore
fi