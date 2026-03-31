LATEXMK := latexmk
LATEXMK_FLAGS := -pdf -interaction=nonstopmode -halt-on-error

MODELS_DIR := models/LaTeX

.PHONY: all covers front-cover back-cover thesis clean clean-models

all: thesis

# Build both covers in sequence.
covers: back-cover

# First cover page.
front-cover: $(MODELS_DIR)/1ere.pdf

# Last cover page, forced to wait for front cover.
back-cover: front-cover $(MODELS_DIR)/4eme.pdf

# Main thesis, forced to wait for both covers.
thesis: back-cover main.pdf

$(MODELS_DIR)/1ere.pdf: $(MODELS_DIR)/1ere.tex
	cd $(MODELS_DIR) && $(LATEXMK) $(LATEXMK_FLAGS) 1ere.tex

$(MODELS_DIR)/4eme.pdf: $(MODELS_DIR)/4eme.tex $(MODELS_DIR)/1ere.pdf
	cd $(MODELS_DIR) && $(LATEXMK) $(LATEXMK_FLAGS) 4eme.tex

main.pdf: main.tex $(MODELS_DIR)/1ere.pdf $(MODELS_DIR)/4eme.pdf
	$(LATEXMK) $(LATEXMK_FLAGS) main.tex

clean-models:
	cd $(MODELS_DIR) && $(LATEXMK) -C 1ere.tex
	cd $(MODELS_DIR) && $(LATEXMK) -C 4eme.tex

clean: clean-models
	$(LATEXMK) -C main.tex
