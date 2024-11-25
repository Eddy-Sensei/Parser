
#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

typedef struct Symbol {
    char *name;
    char *type;
    int scope;
    struct Symbol *next;
} Symbol;

void insertSymbol(char *name, char *type, int scope);
Symbol *lookupSymbol(char *name);
void printSymbolTable(void);

#endif

