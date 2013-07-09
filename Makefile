REPORT=
LATEXMK_OPTIONS=-f -pdf 

all: $(REPORT).pdf

cont:
	./latexmk.pl $(LATEXMK_OPTIONS) -pvc $(REPORT).tex

$(REPORT).pdf: 	
	./latexmk.pl $(LATEXMK_OPTIONS) $(REPORT).tex

spell:
	make clean
	for i in $(SRCS) ; do ispell $$i; done

open:
	open -a "Skim" $(REPORT).pdf

clean:
	./latexmk.pl -C $(REPORT).tex

prepare:
	bundle