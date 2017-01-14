#!/bin/bash

cd abro-retention/ &&
    # Récupération du contenu des pads
    curl 'https://pad.exegetes.eu.org/p/g.DSXI1kGFT1gjor66$Abro-REP-Tele2-Principal/export/txt' \
	 -o Abro-Tele2.md
    curl 'https://pad.exegetes.eu.org/p/g.DSXI1kGFT1gjor66$Abro-REP-Tele2-Garde/export/txt' \
	 -o garde.tex
    # Création d'un fichier json (utile pour développer des filtres)
    pandoc \
    	-f markdown Abro-Tele2.md \
    	-o Abro-Tele2.json -t json --self-contained
    # Création du fichier d'annexe
    pandoc \
	annexe.docx -o annexe.md
    pandoc \
	annexe.docx -o annexe.tex && cat annexe0.tex annexe.tex annexe1.tex > annexe-tableau.tex
    pandoc \
	annexe.docx -o annexe.pdf --variable classoption=10pt --variable geometry=landscape,a4paper,margin=0.6in  --variable include-before="\pagestyle{empty}"
    # Création du fichier LaTeX
    pandoc \
	-f markdown Abro-Tele2.md \
	-o Abro-Tele2.tex -t latex --self-contained \
	--template ../../exegetesDoc/pandocincludes/exegetes.latex \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/latex.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh \
	--filter pandoc-latex-environment \
	--filter ../../exegetesDoc/filters/paranumero.bash
    # Création du PDF avec LaTeX
    pdflatex -interaction=nonstopmode Abro-Tele2.tex &&
    pdflatex -interaction=nonstopmode Abro-Tele2.tex &&
    rm *.aux && rm *.out && rm *.log 
    # Création du fichier docx
    pandoc \
	-f markdown Abro-Tele2.md \
	-o Abro-Tele2.docx --smart \
	--reference-docx=../../exegetesDoc/pandocincludes/exegetes.docx \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/docx.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh \
	--filter ../../exegetesDoc/filters/nettoyage-etendu.zsh
    # Création du fichier html
    pandoc \
	-f markdown Abro-Tele2.md annexe.md \
	-o Abro-Tele2.html -t html --wrap=none --self-contained --smart \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/html.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh \
	--filter ../../exegetesDoc/filters/nettoyage-etendu.zsh
    # Création d'un fichier markdown
    pandoc \
	-f markdown Abro-Tele2.md annexe.md \
	-o Abro-Tele2.html5 -t markdown --wrap=none --self-contained --smart \
	--reference-location=block --reference-links \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/html.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh \
	--filter ../../exegetesDoc/filters/nettoyage-etendu.zsh
