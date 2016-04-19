COUNT_SCRIPT = wordcount.py
TXT_FILES = $(wildcard books/*.txt)
DAT_FILES = $(patsubst books/%.txt, %.dat, $(TXT_FILES))

# analysis.zip: isles.dat abyss.dat last.dat
analysis.zip: $(DAT_FILES) $(COUNT_SCRIPT)
#	zip analysis.zip isles.dat abyss.dat last.dat (plus wordcount.py)
	zip $@ $^

.PHONY: dats
dats: $(DAT_FILES)

.PHONY: variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)

# count words
%.dat: books/%.txt $(COUNT_SCRIPT)
	python $(COUNT_SCRIPT) $< $*.dat

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
	rm -f $(DAT_FILES) analysis.zip