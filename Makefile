COUNT_SCRIPT = wordcount.py
PLOT_SCRIPT = plotcount.py

TXT_FILES = $(wildcard books/*.txt)
DAT_FILES = $(patsubst books/%.txt, %.dat, $(TXT_FILES))
PNG_FILES = $(patsubst books/%.txt, %.png, $(TXT_FILES))

# analysis.zip: isles.dat abyss.dat last.dat
analysis.zip: $(DAT_FILES) $(PNG_FILES) $(COUNT_SCRIPT)
#	zip analysis.zip isles.dat abyss.dat last.dat (plus wordcount.py)
	zip $@ $^

.PHONY: dats
dats: $(DAT_FILES)

.PHONY: pngs
pngs: $(PNG_FILES)

.PHONY: variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)

# count words
%.dat: books/%.txt $(COUNT_SCRIPT)
	python $(COUNT_SCRIPT) $< $*.dat

# make plots
%.png: %.dat $(PLOT_SCRIPT)
	python $(PLOT_SCRIPT) $< $*.png

# isles.dat: books/isles.txt wordcount.py
# 	# python wordcount.py books/isles.txt isles.dat
# 	python wordcount.py $< $@

# abyss.dat: books/abyss.txt wordcount.py
# 	# python wordcount.py books/abyss.txt abyss.dat
# 	python wordcount.py $< $@

# last.dat: books/last.txt wordcount.py
# 	# python wordcount.py books/last.txt last.dat
# 	python wordcount.py $< $@

.PHONY: clean
clean: 
	rm -f $(DAT_FILES) $(PNG_FILES) analysis.zip
	