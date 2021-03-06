ODIR=./obj
BDIR=./bin
SRC=./src

CC = gcc
LDFLAGS = -lncurses
CFLAGS := -Wall -g -std=c11

_HEADERS := display.h generation.h gameplay.h
_OBJECTS := $(_HEADERS:.h=.o)
OBJECTS = $(patsubst %,$(ODIR)/%,$(_OBJECTS))
HEADERS = $(patsubst %,$(SRC)/%,$(_HEADERS))

default: infect

build:
	@test -d $(ODIR) || mkdir $(ODIR)
	@test -d $(BDIR) || mkdir $(BDIR)

clean:
	rm -rf ./obj/
	rm -rf ./bin/
	rm -f ./*~
	rm -f ./*.swp

rebuild: clean default

infect: ${OBJECTS} $(SRC)/include.h
	${CC} $^ $(SRC)/main.c $(LDFLAGS) $(CFLAGS) -o $(BDIR)/$@

$(ODIR)/%.o: $(SRC)/%.c $(SRC)/%.h $(SRC)/include.h build
	${CC} $< -c $(CFLAGS) $(LDFLAGS) -o $@

.PHONY: default clean check dist distcheck install rebuild uninstall