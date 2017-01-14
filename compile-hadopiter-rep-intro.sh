#!/bin/bash

cd hadopiter/ &&
    curl 'https://pad.exegetes.eu.org/p/g.u9nuSHPxvsgFul15$HadopiTer-REP-Intro-Garde/export/txt' \
	 -o HadopiTer-REP-Intro-Garde.tex &&
    curl 'https://pad.exegetes.eu.org/p/g.u9nuSHPxvsgFul15$HadopiTer-REP-Intro-Principal/export/txt' \
	 -o HadopiTer-REP-Intro-Principal.md &&
    pandoc \
	-f markdown HadopiTer-REP-Intro-Principal.md \
	-o HadopiTer-REP-Intro-Principal.tex -t latex --self-contained \
	--template ../../exegetesDoc/pandocincludes/exegetes.latex \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/latex.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh \
	--filter pandoc-latex-environment \
	--filter ../../exegetesDoc/filters/paranumero.bash &&
    pdflatex HadopiTer-REP-Intro-Principal.tex && pdflatex HadopiTer-REP-Intro-Principal.tex &&
    pandoc \
	-f markdown HadopiTer-REP-Intro-Principal.md \
	-o HadopiTer-REP-Intro-Principal.docx --self-contained \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/docx.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh
