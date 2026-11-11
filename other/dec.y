
%{
#include<stdio.h>
int yylex();
int yyerror(char *s);
%}

%token TYPE NAME VALUE

%%

S : TYPE NAME '=' VALUE ';'
    {
        printf("VALID DECLARATION\n");
    }
    ;

%%

int yyerror(char *s)
{
    printf("INVALID DECLARATION\n");
    return 0;
}

int main()
{
    printf("Enter declaration statement:\n");
    yyparse();
    return 0;
}

