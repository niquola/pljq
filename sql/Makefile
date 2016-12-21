# MODULE_big = jsonb_extra

OBJS = builtin.o execute.o jv_aux.o jv_parse.o lexer.o bytecode.o inject_errors.o jv.o  jv_print.o  linker.o  parser.o compile.o jv_alloc.o jv_file.o jv_unicode.o locfile.o util.o
SRCS = builtin.o execute.o jv_aux.o jv_parse.o lexer.o bytecode.o inject_errors.o jv.o  jv_print.o  linker.o  parser.o compile.o jv_alloc.o jv_file.o jv_unicode.o locfile.o util.o

all: jq

jq: main.c
	gcc -c main.c

clean:
	rm -rf *.o hello
