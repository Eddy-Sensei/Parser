%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"    //  AST header
#include "symbol.h" // Symbol Table header
 


int yy_scan_string(const char *str);
extern int yylex(); // Lexical analyzer function
void yyerror(const char *s); // Error function

ASTNode *createIfElseNode(ASTNode *condition, ASTNode *thenBranch, ASTNode *elseBranch) {
    ASTNode *node = createBinaryNode("if_else", condition, thenBranch);
    node->right = elseBranch; // Link the else branch
    return node;
}

ASTNode *root; // variabe AST root
%}

%union {
    int num;
    char *id;
    struct ASTNode *ast;
}

%token <num> NUMBER
%token <id> IDENTIFIER
%token IF ELSE
%token GE LE EQ NE '>' '<' 
%token '+' '-' '*' '/' '(' ')' '=' ';'

%right '='
%left GE LE EQ NE '>' '<'
%left '+' '-'
%left '*' '/'
%left '[' ']'
%nonassoc IFX
%nonassoc ELSE


%type <ast> expression term factor assignment statement conditional
%type <ast> program comparison_expr array_access

%% // Grammar Rules

program:
    statement ';' {
        root = $1; 
    }
;

statement:
    expression ';'{
        $$ = $1; 
    } 
    | assignment {
        $$ = $1; 
    }
    | conditional {
        $$ = $1; 
    }
;

assignment:
    IDENTIFIER '=' expression {
	insertSymbol($1, "int", 0);
        $$ = createBinaryNode("assign", createIdentifierNode($1), $3);
    }
    | array_access '=' expression {
	$$ = createBinaryNode("assign", $1, $3);
    }
;

array_access: 
    IDENTIFIER '[' expression ']' {
	$$ = createArrayAccessNode($1,$3);
    }
;

conditional:
    IF '(' comparison_expr ')' statement %prec IFX {
	$$ = createBinaryNode("if", $3, $5);
    }
    | IF '(' comparison_expr ')' statement ELSE statement {
        $$ = createIfElseNode($3, $5, $7);
        }
;  

comparison_expr: 
    expression '>' expression {
	$$ = createBinaryNode("greater", $1, $3);
    }
    | expression '<' expression {
	$$ = createBinaryNode("less", $1, $3);
    }
    | expression GE expression {
	$$ = createBinaryNode("greater_equal", $1, $3);
    }
    | expression LE expression {
	$$ = createBinaryNode("less_equal", $1, $3);
    }
    | expression EQ expression {
	$$  = createBinaryNode("equal", $1, $3);
    }
    | expression NE expression {
	$$ = createBinaryNode("not_equal", $1, $3);
    }
;

expression:
    expression '+' term {
	$$ = createBinaryNode("add", $1, $3);
    }
    | expression '-' term {
	$$ = createBinaryNode("subtract", $1, $3);
    }
    | term {
	$$ = $1;
    }
;

term:
    term '*' factor {
	$$ = createBinaryNode("multiply", $1, $3);
    }
    | term '/' factor {
	$$ = createBinaryNode("divide", $1, $3);
    }
    | factor {
	$$ = $1;
    }
;


factor:
     NUMBER {
        $$ = createTerminalNode("number", $1);
    }
    | IDENTIFIER {
        $$ = createIdentifierNode($1);
    }
    | array_access {
	$$ = $1;
    }
    | '(' expression ')' {
	$$ = $2;
    }
;

%% // Error Handling

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter your expressions (end with ; and type 'exit' to quit):\n");
    while (1) {
        char input[256];
        printf(">> ");
        if (fgets(input, sizeof(input), stdin) == NULL) {
            break; // Handle end of input
        }
        if (strcmp(input, "exit\n") == 0) {
            break; // Exit condition
        }
        yy_scan_string(input); // Pass the input to the lexer
        if (yyparse() == 0) {  // Call the parser
	 printSymbolTable();
            if (root != NULL) {
                printAST(root, 0); // Print the AST
            } else {
                printf("Error: syntax error\n");
            }
        }
    }
    return 0;
}

