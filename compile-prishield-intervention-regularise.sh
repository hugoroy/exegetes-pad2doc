#!/bin/bash

cd prishield/ &&
    curl 'https://pad.exegetes.eu.org/p/g.LOe9KTSEtDDWQW3v$PriShield-DRI-Interv-Garde/export/txt' \
	 -o PriShield-DRI-Interv-Garde.tex &&
    curl 'https://pad.exegetes.eu.org/p/g.LOe9KTSEtDDWQW3v$PriShield-DRI-Intervention/export/txt' \
	 -o PriShield-DRI-Intervention-regularise.md &&
    pandoc \
	-f markdown PriShield-DRI-Intervention-regularise.md \
	-o PriShield-DRI-Intervention-regularise.json -t json --self-contained &&
    pandoc \
	-f markdown PriShield-DRI-Intervention-regularise.md \
	-o PriShield-DRI-Intervention-regularise.tex -t latex --self-contained \
	--template ../../exegetesDoc/pandocincludes/exegetes.latex \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/latex.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh \
	--filter pandoc-latex-environment \
	--filter ../../exegetesDoc/filters/paranumero.bash &&
    pdflatex PriShield-DRI-Intervention-regularise.tex && pdflatex PriShield-DRI-Intervention-regularise.tex &&
    pandoc \
	-f markdown PriShield-DRI-Intervention-regularise.md \
	-o PriShield-DRI-Intervention-regularise.docx --smart \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/docx.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh
