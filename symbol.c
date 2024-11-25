// symbol_table.c
#include "symbol.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static Symbol *symbolTable = NULL;

void insertSymbol(char *name, char *type, int scope) {
    Symbol *newSymbol = (Symbol*)malloc(sizeof(Symbol));
    newSymbol->name = strdup(name);
    newSymbol->type = strdup(type);
    newSymbol->scope = scope;
    newSymbol->next = symbolTable;
    symbolTable = newSymbol;
}

Symbol *lookupSymbol(char *name) {
    Symbol *current = symbolTable;
    while (current != NULL) {
        if (strcmp(current->name, name) == 0) {
            return current;
        }
        current = current->next;
    }
    return NULL;
}

void printSymbolTable(void) {
    Symbol *current = symbolTable;
    printf("Symbol Table:\n");
    while (current != NULL) {
        printf("Name: %s, Type: %s, Scope: %d\n", current->name, current->type, current->scope);
        current = current->next;
    }
}

