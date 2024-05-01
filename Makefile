CFLAGS = -pthread -std=c11 -pedantic -Wall -Werror -D_XOPEN_SOURCE=700
CC = gcc
AR = ar

.PHONY: all clean

all: libintbuffer.a libintbuffer-dynamic.so

clean:
	rm -f libintbuffer.a libintbuffer-dynamic.so intbuffer.o sem.o intbuffer-test.o intbuffer-dyn.o sem-dyn.o

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

libintbuffer.a: intbuffer.o sem.o
	$(AR) -rcs $@ $^

libintbuffer-dynamic.so: sem-dyn.o intbuffer-dyn.o
	$(CC) -shared -fPIC $(CFLAGS) -o $@ $^

intbuffer-dyn.o: intbuffer.c sem.h
	$(CC) -fPIC $(CFLAGS) -c -o $@ $<

sem-dyn.o: sem.c sem.h
	$(CC) -fPIC $(CFLAGS) -c -o $@ $<

intbuffer-test.o: intbuffer-test.c intbuffer.h

intbuffer.o: intbuffer.c sem.h

sem.o: sem.c sem.h
