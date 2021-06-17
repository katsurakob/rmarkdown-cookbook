all:
	rm -f docs/*.html &&\
	BOOKDOWN_FULL_PDF=false Rscript --quiet _render.R

pdf:
	Rscript --quiet _render.R "rmdja::pdf_book_ja" &&\
	rm -f css/box.css latex/blackbox.tex latex/infobox.tex &&\
	mv docs/rmarkdown-cookbook.pdf _book/rmarkdown-cookbook-full.pdf &&\
	open docs/rmarkdown-cookbook-full.pdf

gitbook:
	Rscript --quiet _render.R "rmdja::gitbook_ja"

pdf2:
	BOOKDOWN_FULL_PDF=false Rscript --quiet _render.R "bookdown::pdf_book"

clean:
	Rscript -e 'bookdown::clean_book(TRUE)'