analysis.zip : *.dat
	zip $@ $^

.PHONY : dats
dats : isles.dat abyss.dat last.dat

# count words
isles.dat : books/isles.txt wordcount.py
	python wordcount.py $< $@
	
abyss.dat : books/abyss.txt wordcount.py
	python wordcount.py $< $@
	
last.dat : books/last.txt wordcount.py
	python wordcount.py $< $@
	

	
.PHONY : Clean	
clean : 
	rm -f *.dat *.zip