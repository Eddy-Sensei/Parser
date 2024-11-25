# Makefile for the Expression Evaluator

# Compiler
CC = gcc

# Compiler flags
CFLAGS = -g -Wall

# Source files
SRCS = ast.c symbol.c parser.tab.c lex.yy.c

# Output executable
TARGET = expression_evaluator

# Linking libraries
LIBS = -lfl

# Build rule
all: expression_evaluator

expression_evaluator: ast.c symbol.c parser.tab.c lex.yy.c
	gcc -g -Wall -o expression_evaluator ast.c symbol.c parser.tab.c lex.yy.c -lfl

# Clean rule
clean:
	rm -f expression_evaluator *.o lex.yy.c parser.tab.c parser.tab.h

# Phony targets
.PHONY: all clean

