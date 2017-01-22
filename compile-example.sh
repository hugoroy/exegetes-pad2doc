#!/bin/bash

cd Dossier/ &&
    # Récupération du contenu des pads
    curl 'PadPrincipalURL' \
	 -o ProjetId.txt
    curl 'PadGardeURL' \
	 -o garde.tex
    # Création d'un fichier json (utile pour développer des filtres mais pas nécessaire en prod)
    # pandoc \
    # 	-f markdown ProjetId.txt \
    # 	-o ProjetId.json -t json --self-contained
    # Création du fichier LaTeX
    pandoc \
	-f markdown ProjetId.txt \
	-o ProjetId.tex -t latex --self-contained \
	--template ../../exegetesDoc/pandocincludes/exegetes.latex \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/latex.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh \
	--filter pandoc-latex-environment \
	--filter ../../exegetesDoc/filters/paranumero.bash
    # Création du PDF avec LaTeX
    pdflatex -interaction=nonstopmode ProjetId.tex &&
    pdflatex -interaction=nonstopmode ProjetId.tex &&
    rm *.aux && rm *.out && rm *.log 
    # Création du fichier docx
    pandoc \
	-f markdown ProjetId.txt \
	-o ProjetId.docx -t docx --self-contained --smart \
	--reference-docx=../../exegetesDoc/pandocincludes/exegetes.docx \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/docx.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh \
	--filter ../../exegetesDoc/filters/nettoyage-etendu.zsh
    # Création du fichier html
    pandoc \
	-f markdown ProjetId.txt \
	-o ProjetId.html -t html --self-contained --smart \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/html.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh \
	--filter ../../exegetesDoc/filters/nettoyage-etendu.zsh
    # Création d'un fichier markdown
    pandoc \
	-f markdown ProjetId.txt \
	-o ProjetId.markdown.txt -t markdown --wrap=none --self-contained --smart \
	--reference-location=block --reference-links \
	--filter pandoc-citeproc \
	--filter ../../exegetesDoc/filters/markdown.zsh \
	--filter ../../exegetesDoc/filters/nettoyage.zsh \
	--filter ../../exegetesDoc/filters/nettoyage-etendu.zsh
