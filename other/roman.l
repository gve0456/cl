%{
#include <stdio.h>
#include <stdlib.h>

int values[] = {1000, 900, 500, 400, 100, 90, 50,
                40, 10, 9, 5, 4, 1};

char *roman[] = {"M", "CM", "D", "CD", "C", "XC", "L",
                 "XL", "X", "IX", "V", "IV", "I"};
%}

%%
[0-9]+ {
    int num = atoi(yytext);

    for (int i = 0; i < 13; i++) {
        while (num >= values[i]) {
            printf("%s", roman[i]);
            num = num - values[i];
        }
    }

    printf("\n");
}

\n      { return 0; }
.       { printf("Invalid input\n"); }
%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter the number: ");
    yylex();
    return 0;
}a
