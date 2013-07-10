#!/bin/bash

all_files=($(fgrep -E -v '#|:|(^\s+/)' deps.lst| sed s/\\\\// | sed -e 's/^[ \t]*//' | sed -e 's/^\.\///' | sort -u))

function diffLists {
  declare -a tex_files=("${!1}")
  declare -a vcs_files=("${!2}")

  oldIFS=$IFS
  IFS=$'\n\t'
  # First sort the arrays and then continue with diffing them
  declare -a Array3=($(comm -2 -3 <(echo "${tex_files[*]}") <(echo "${vcs_files[*]}")))
  
  sz=${#Array3[@]}
  if [ "$sz" -gt "0" ] 
    then
    printmsg Array3[@]
  else
    echo "No untracked files found!"
  fi

  IFS=$oldIFS
}

function printmsg {
  echo "There are a few files left that belong to the LaTeX document"
  echo "but are not added to the repository:"

  declare -a result=("${!1}")
  for j in ${result[@]}; do
    echo "   * $j" 
  done
}

function handlegit {
  echo "Git repository found, checking..."
  git_files=($(git ls-files --cached --modified --exclude-standard | sort -u))
  diffLists all_files[@] git_files[@]
}

function handlesvn {
  echo "SVN repository found, checking files"
  svn_files=($(svn ls -R | sort -u))
  diffLists all_files[@] svn_files[@]
}

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
