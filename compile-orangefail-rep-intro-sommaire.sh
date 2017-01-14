#!/bin/bash

cd orangefail/ &&
    curl 'https://pad.exegetes.eu.org/p/g.8F3HoIbMFgqDPAzW$Orangefail-REP-Intro-Garde/export/txt' \
	 -o Orangefail-REP-Intro-Garde.tex &&
    curl 'https://pad.exegetes.eu.org/p/g.8F3HoIbMFgqDPAzW$Orangefail-REP-Intro-Principal/export/txt' \
	 -o Orangefail-REP-Intro-Sommaire.md &&
    pandoc \
	-f markdown Orangefail-REP-Intro-Sommaire.md \
	-o Orangefail-REP-Intro-Sommaire.tex -t latex --self-contained \
	--template ../../exegetesDoc/pandocincludes/exegetes.latex \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/latex.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh \
	--filter pandoc-latex-environment \
	--filter ../../exegetesDoc/filters/paranumero.bash &&
    pdflatex Orangefail-REP-Intro-Sommaire.tex && pdflatex Orangefail-REP-Intro-Sommaire.tex &&
    pandoc \
	-f markdown Orangefail-REP-Intro-Sommaire.md \
	-o Orangefail-REP-Intro-Sommaire.docx --smart \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/docx.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh
