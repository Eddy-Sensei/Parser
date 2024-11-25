#ifndef AST_H
#define AST_H

typedef struct ASTNode ASTNode;

struct ASTNode {
    char *nodeType;
    union {
        int num;
        char *id;
    };
    struct ASTNode *left;
    struct ASTNode *right;
    int arraySize;
};

ASTNode *createBinaryNode(const char *type, ASTNode *left, ASTNode *right);
ASTNode *createTerminalNode(const char *type, int value);
ASTNode *createIdentifierNode(const char *id);
ASTNode *createArrayAccessNode(const char *id, ASTNode *index);
ASTNode *createIfElseNode(ASTNode *condition, ASTNode *thenBranch, ASTNode *elseBranch); 
void printAST(ASTNode *node, int depth);
void freeAST(ASTNode *node); // Function to avoid any memory leaks

#endif 

// AST_H

