.PHONY: all

all: manuscript.pdf

manuscript.pdf: report/manuscript.tex
	cd report\
	&& pdflatex manuscript.tex\
	&& open manuscript.pdf

clear_notebooks:
	jupyter nbconvert notebooks/*.ipynb --clear-output --inplace

clear_report:
	rm report/manuscript.bbl
	rm report/manuscript.blg
	rm report/manuscript.log
	rm report/manuscript.out
	rm report/manuscript.aux