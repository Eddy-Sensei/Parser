%{
#include "parser.tab.h" // Bison header file
#include <stdio.h>
#include <stdlib.h>
#undef input
#undef yyunput
%}

%% // Lexer Rules

[0-9]+              { yylval.num = atoi(yytext); return NUMBER; }
[ \t\n]            { /* Ignore whitespace */ }
"if"               { return IF; }
"else"             { return ELSE; }
"="                { return '='; }
"+"                { return '+'; }
"-"                { return '-'; }
"*"                { return '*'; }
"/"                { return '/'; }
";"                { return ';'; }
"("		   { return '('; }
")"		   { return ')'; }
"["                { return '['; }
"]"                { return ']'; }
">"		   { return '>'; }
"<"                { return '<'; }


[a-zA-Z_][a-zA-Z0-9_]* { yylval.id = strdup(yytext); return IDENTIFIER; }
.                  { printf("Lexer: Unrecognized character: %s\n", yytext); }

%%

int yywrap() {
    return 1; 
// End of input
}

