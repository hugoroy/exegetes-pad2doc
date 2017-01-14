#!/bin/bash

cd tes/ &&
    curl 'https://pad.exegetes.eu.org/p/g.R2gex8jsN350W1tb$ReqIntro-REP-Page-de-garde/export/txt' \
	 -o ReqIntro-REP-Page-de-garde.tex &&
    curl 'https://pad.exegetes.eu.org/p/g.R2gex8jsN350W1tb$Intro-sommaire/export/txt' \
	 -o Tes-REP-Intro-Sommaire.md &&
    pandoc \
	-f markdown Tes-REP-Intro-Sommaire.md \
	-o Tes-REP-Intro-Sommaire.json -t json --self-contained &&
    pandoc \
	-f markdown Tes-REP-Intro-Sommaire.md \
	-o Tes-REP-Intro-Sommaire.tex -t latex --self-contained \
	--template ../../exegetesDoc/pandocincludes/exegetes.latex \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/latex.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh \
	--filter pandoc-latex-environment \
	--filter ../../exegetesDoc/filters/paranumero.bash &&
    pdflatex Tes-REP-Intro-Sommaire.tex && pdflatex Tes-REP-Intro-Sommaire.tex &&
    pandoc \
	-f markdown Tes-REP-Intro-Sommaire.md \
	-o Tes-REP-Intro-Sommaire.docx --smart \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/docx.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh
