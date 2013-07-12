# papertemplate

Papertemplate is a skeleton folder for creating LaTeX documents and provides a
set of useful bash scripts that can make your life easier when working
collaboratively on LaTeX documents.

The easiest way is to use this folder as the base version for your paper and
just drop your files into this folder. For easier reference you should follow
some guidelines.

  1. Put sections into separate files and put all of them into the sections
     folder so that it becomes easier to work with for multiple people.
  2. Images, graphs etc. should all go into the figures folder
  3. Wrap you LaTeX content at 80 cols in your text editor
  4. Use rDBLP for reference management

## Setup

  1. First open the Makefile in your favorite text editor and add in the first
     line the base name (without ending) of your tex file
  2. Execute `make prepare` from the command line and follow the instructions

## Run

This small package offers you some very convenient make targets:

  1. `make` will build the TeX file you specified the required number of times,
     will eventually fetch the references via DBLP and make sure everything is
     alright
  2. `make cont` will do the same but continuously whenever you change a
     dependent file it will rerun `pdflatex`
  3. `make check` will check your repository if all the files that are required
     by the LaTeX document are actually included in the version control system.
     There is even a handy git pre-commit hook that you can use to perform this
     task automatically when you want to commit something.
  4. `make open` opens the document in your favorite PDF viewer, per default
     this is Preview.app on the Mac and acroread on Linux. You can modify the
     file deps/latexmkrc to use your own previewer. See deps/latexmkrc.default
     for examples.
  5. `make clean` will remove all the mess that LaTeX made

## Requirements

Basically, any Linux / Mac operating system should be fine. The basic
requirement is Perl for `latexmk` and Ruby for `rdblp`. Windows? No way. 

## rDBLP for Reference Management

DBLP is a command line tool to fetch required bibtex entries directly from the
DBLP servers. The idea is, that you don't have to maintain all entries in your
own file, but use well known bibtex identifiers instead and then fetch them from
DBLP.

When you want to cite content that is available from DBLP you only need to
search for the entry and copy the Bibtex key and use it for citations. Once the
document compiles this script will automatically download the necessary entry
from the DBLP website and add the entry to the file `dblp.bib`. In your LaTeX
document just add `dblp` as another bibliography file.

More information here: https://github.com/grundprinzip/dblp


## Referenced Software

  Latexmk - http://users.phys.psu.edu/~collins/software/latexmk-jcc/


