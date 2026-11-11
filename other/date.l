
%{
#include<stdio.h>
%}

D [0-9]{2}
M (0[1-9]|1[0-2])
Y [0-9]{4}

%%
{D}-{M}-{Y} {
    printf("Date is in DD-MM-YYYY format\n");
}

{Y}-{M}-{D} {
    printf("Date is in YYYY-MM-DD format\n");
}

{D}\/{M}\/{Y} {
    printf("Date is in DD/MM/YYYY format\n");
}

[ \t\n]+ ;

.+ {
    printf("Invalid character: %s\n", yytext);
}
%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter the date:\n");
    yylex();
    return 0;
}
