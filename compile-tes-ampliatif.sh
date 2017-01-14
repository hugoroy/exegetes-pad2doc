#!/bin/bash

cd tes/ &&
    curl 'https://pad.exegetes.eu.org/p/g.R2gex8jsN350W1tb$MA-REP-Principal/export/txt' \
	 -o TES-REP-ampliatif.md
    curl 'https://pad.exegetes.eu.org/p/g.R2gex8jsN350W1tb$MA-REP-Page-de-garde/export/txt' \
	 -o garde.tex
    pandoc \
    	-f markdown TES-REP-ampliatif.md \
    	-o TES-REP-ampliatif.json -t json --self-contained &&
    pandoc \
	-f markdown TES-REP-ampliatif.md \
	-o TES-REP-ampliatif.tex -t latex --self-contained \
	--template ../../exegetesDoc/pandocincludes/exegetes.latex \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/latex.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh \
	--filter pandoc-latex-environment \
	--filter ../../exegetesDoc/filters/paranumero.bash &&
    pdflatex TES-REP-ampliatif.tex && pdflatex TES-REP-ampliatif.tex &&
    pandoc \
	-f markdown TES-REP-ampliatif.md \
	-o TES-REP-ampliatif.docx --smart \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/docx.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh &&
    pandoc \
	-f markdown TES-REP-ampliatif.md \
	-o TES-REP-ampliatif.html5 -t html5 --wrap=none --self-contained --smart \
	--reference-location=block --reference-links \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/docx.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh &&
    rm *.aux && rm *.out && rm *.log 

