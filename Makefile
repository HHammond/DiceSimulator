
dice.o: dice.c
	gcc -c dice.c -o dice.o -Ofast

dice.dylib: dice.o
	gcc -dynamiclib -undefined suppress -flat_namespace *.o -o dice.dylib

build: dice.dylib

run: dice.dylib
	julia -p 8 driver.jl

clean:
	-find . -name *.o -delete
	-rm dice.dylib
