REPORT:=
LATEXMK_OPTIONS := -f -pdf -M -MF deps.lst
LATEXMK := ./deps/latexmk.pl

export LATEXMK
export LATEXMK_OPTIONS
export REPORT


all: $(REPORT).pdf

cont:
	$(LATEXMK) $(LATEXMK_OPTIONS) -pvc $(REPORT).tex

$(REPORT).pdf: 	
	$(LATEXMK) $(LATEXMK_OPTIONS) $(REPORT).tex

# Use ispell as a spell checker
spell:
	make clean
	for i in $(SRCS) ; do ispell $$i; done

open:
	open -a "Skim" $(REPORT).pdf

clean:
	$(LATEXMK) -C $(REPORT).tex

check:
	bash deps/check_files.sh
	
# Installs all local dependencies, in our case these are all gem listed in the
# Gemfile
prepare:
	bundle

