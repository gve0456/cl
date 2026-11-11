%{
#include <stdio.h>
#include <stdlib.h>
%}

%token A B NL

%%
stmnt : S NL
        {
            printf("The string is in the format of a^n b^n\n");
        }
      ;

S : A S B
  | A B
  ;
%%

int yyerror(char *msg)
{
    printf("The string is not in the desired format\n");
    return 0;
}

int main()
{
    printf("Enter the string:\n");
    yyparse();
    return 0;
}
