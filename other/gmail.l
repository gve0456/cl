%{
#include<stdio.h>
int v=1;
%}

%%
[a-zA-Z][a-zA-Z0-9]*@(gmail|yahoo)\.(com|in) {
    printf("Valid email\n");
}	

[$]	{return 0;}
.+	{printf("invalif");}
%%
int yywrap()
{
return 0;
}
int main()
{

printf("ENter");
yylex();

return 0;
}
