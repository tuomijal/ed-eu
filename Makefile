.PHONY: all

all: output/manuscript.pdf

# List of plot image targets
PLOTS = output/plots/severity.png\
		output/plots/causes.png\
		output/plots/benefit.png\
		output/plots/definition.png\
		output/plots/crowding_map.png\
		output/plots/country_crowding.png\
		output/plots/interventions.png\
		output/plots/usage.png\
		output/plots/horizon.png\
		output/plots/enabled.png\

TABLES = output/tables/description.tex

output/manuscript.pdf: report/manuscript.tex $(PLOTS) $(TABLES)
	cd report\
	&& pdflatex manuscript.tex\
	&& open manuscript.pdf\
	&& mv manuscript.pdf ../output/manuscript.pdf

data/base/data.csv: notebooks/make_basedata.ipynb
	cd notebooks\
	&& papermill make_basedata.ipynb /dev/null

$(TABLES): output/tables/%.tex: notebooks/tab_%.ipynb data/base/data.csv
	cd notebooks\
	&& papermill $(notdir $<) /dev/null

$(PLOTS): output/plots/%.png: notebooks/plot_%.ipynb data/base/data.csv
	cd notebooks\
	&& papermill $(notdir $<) /dev/null

clear_notebooks:
	jupyter nbconvert notebooks/*.ipynb --clear-output --inplace

clear_report:
	rm report/manuscript.bbl
	rm report/manuscript.blg
	rm report/manuscript.log
	rm report/manuscript.out
	rm report/manuscript.aux