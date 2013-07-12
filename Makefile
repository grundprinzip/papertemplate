REPORT:= #!!# Put the basename of your tex file here
LATEXMK_OPTIONS := -f -pdf -M -MF deps.lst -r deps/latexmkrc
LATEXMK := ./deps/latexmk.pl

export LATEXMK
export LATEXMK_OPTIONS
export REPORT


# Build the document
all: $(REPORT).pdf

# Continous build of the document
cont:
	$(LATEXMK) $(LATEXMK_OPTIONS) -pvc $(REPORT).tex

$(REPORT).pdf: 	
	$(LATEXMK) $(LATEXMK_OPTIONS) $(REPORT).tex

# Use ispell as a spell checker
spell:
	make clean
	for i in $(SRCS) ; do ispell $$i; done

# Open the document in your preferred viewer, you can configure the viewer in
# deps/latexmkrc
open:
	$(LATEXMK) $(LATEXMK_OPTIONS) -pv $(REPORT).tex

clean:
	$(LATEXMK) -C $(REPORT).tex

# Add to ignore list
addignore:
	bash deps/create_ignores.sh

# Checks if all files that are required by the LaTeX document are actually
# included in the repository
check:
	bash deps/check_files.sh
	
# Installs all local dependencies, in our case these are all gem listed in the
# Gemfile
prepare:
	bash deps/setup.sh

