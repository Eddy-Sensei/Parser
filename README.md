# Expression Evaluator

## Project Description

This project implements a simple expression evaluator for a basic programming language. The evaluator uses a **Lexical Analyzer (lexer)**, a **Parser**, an **Abstract Syntax Tree (AST)**, and a **Symbol Table** to evaluate arithmetic expressions, assignments, and conditional statements. The result is an Abstract Syntax Tree (AST) that can be used for further analysis or execution.

The project is designed using:
- **Flex** for lexical analysis
- **Bison** for syntax parsing
- **C** for AST construction and symbol table management

### Key Features:
- **Expression Evaluation**: Supports arithmetic operations like addition, subtraction, multiplication, and division.
- **Assignments**: Allows assignment to variables and array elements.
- **Conditionals**: Supports basic `if-else` conditionals.
- **Abstract Syntax Tree (AST)**: Constructs an AST to represent the syntax structure of the program.
- **Symbol Table**: Manages variable declarations and types.

---

## Requirements

- **Flex**: Lexical analyzer generator
- **Bison**: Parser generator
- **GCC**: C compiler

---

## How to Compile and Run

### 1. Compile the Lexer and Parser

To compile the lexer (`lexer.l`) and parser (`parser.y`), run the following commands:

```bash
# Compile the lexer
flex lexer.l

# Compile the parser
bison -v -d parser.y
```

This generates `lex.yy.c` (the lexer code) and `parser.tab.c` and `parser.tab.h` (the parser code and header).

### 2. Build the Project Using Makefile

The project includes a `Makefile` to automate the build process. To compile the entire project, simply run:

```bash
make
```

This will:
- Generate the lexer and parser files.
- Compile and link the generated files with the `main.c` (driver code) into an executable called `expression_evaluator`.

### 3. Clean Up Generated Files

To remove the generated files (object files, lexer/parser files, etc.), run:

```bash
make clean
```

This will clean up all the intermediate files produced during the compilation process.

### 4. Execute the Program

After successfully building the project, run the generated executable:

```bash
./expression_evaluator
```

The program will prompt you to enter expressions. You can type arithmetic expressions, assignments, or conditional statements, and the program will evaluate them and display the resulting AST.

---

## Program Features and Working

### Lexer (lexical analysis)
The lexer (`lexer.l`) breaks the input into tokens such as numbers, identifiers, operators, and keywords (`if`, `else`). It defines rules for recognizing these tokens and outputs them for the parser.

### Parser (syntax analysis)
The parser (`parser.y`) uses **Bison** to define grammar rules for the language. It recognizes expressions, assignments, and conditional statements and builds an Abstract Syntax Tree (AST) for each valid input. The parser will use the tokens from the lexer to construct the AST based on the defined grammar.

### Abstract Syntax Tree (AST)
The AST is a tree representation of the structure of the input program. Each node in the tree represents a part of the program (such as an expression or a statement). The AST is built by functions like `createBinaryNode`, `createIdentifierNode`, etc., and it is used for further evaluation or transformation.

### Symbol Table
The symbol table is used to manage the variables used in the program. When a variable is declared or used, it is added to or looked up in the symbol table. In this project, the symbol table is built during parsing, and each variable is associated with a type (`int`, `array`, etc.).

### Example Usage

You can enter simple expressions, assignments, and conditionals for evaluation. Here are a few examples:

**Arithmetic Expression:**
```
>> 3 + 5 * (2 - 8);
```

**Array Assignment:**
```
>> arr[10] = 5;
```

**Conditional:**
```
>> if (x > 10) y = 5; else y = 0;
```

After entering a statement, the program will generate an AST that represents the structure of the input.

---

## File Structure

The project consists of the following files:

- **lexer.l**: The Flex lexer source file.
- **parser.y**: The Bison parser source file.
- **main.c**: The driver program that uses the lexer and parser.
- **Makefile**: A Makefile to automate the build process.
- **ast.h**: Header file defining the Abstract Syntax Tree (AST) structure and functions.
- **symbol.h**: Header file defining the symbol table structure and functions.
- **ast.c**: Implementation of functions to create and manipulate AST nodes.
- **symbol.c**: Implementation of functions for the symbol table.

---

## Example Makefile

Here’s an example `Makefile` that automates the build and clean process:

```make
CC = gcc
LEX = flex
BISON = bison
CFLAGS = -Wall

# Files
LEX_FILE = lexer.l
BISON_FILE = parser.y
LEX_OUTPUT = lex.yy.c
BISON_OUTPUT_C = parser.tab.c
BISON_OUTPUT_H = parser.tab.h
OUTPUT = expression_evaluator

# Targets
all: $(OUTPUT)

$(OUTPUT): $(LEX_OUTPUT) $(BISON_OUTPUT_C)
	$(CC) $(CFLAGS) $(LEX_OUTPUT) $(BISON_OUTPUT_C) -o $(OUTPUT)

$(LEX_OUTPUT): $(LEX_FILE)
	$(LEX) $(LEX_FILE)

$(BISON_OUTPUT_C): $(BISON_FILE)
	$(BISON) -d $(BISON_FILE)

clean:
	rm -f $(LEX_OUTPUT) $(BISON_OUTPUT_C) $(BISON_OUTPUT_H) $(OUTPUT)

```

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
