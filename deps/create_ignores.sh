#!/bin/bash

declare -a endings=(".aux" ".log" ".bbl" ".blg" ".fdb_latexmk" ".fls" ".out" ".pdfsync")

function handlegit {
  for j in $endings
    do
      echo "$REPORT$J" >> .gitignore
  done
  echo "deps.lst" >> .gitignore
  echo "Gemfile.lock" >> .gitignore
}

function handlesvn {
  svn propget svn:ignore . > tmp.ignore
  echo "deps.lst" >> tmp.ignore
  echo "Gemfile.lock" >> tmp.ignore
  
  for j in ${endings[@]}
    do
      echo "$REPORT$j" >> tmp.ignore      
    done
  svn propset svn:ignore -F tmp.ignore .
  rm tmp.ignore
}


# Check which VCS we are using
if [ -e .git ]
  then
  handlegit
  exit 0
fi

if [ -e .svn ]
  then
  handlesvn  
  exit 0
fi

git status > /dev/null 2>&1
if [ "$?" -eq "0" ]
  then
  handlegit
  exit 0
fi

svn st 2>&1 | grep -v "not a working copy" > /dev/null 2>&1 
if [ "$?" -eq "0" ]
  then
  handlesvn
  exit 0
else
  echo "No version control system found, you better get one..."
fi
