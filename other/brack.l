%{
#include<stdio.h>
int co=0,cc=0,so=0,sc=0,bo=0,bc=0;
%}
%%
"{" {co++;}
"}" {cc++;}
"(" {bo++;}
")" {bc++;}
"[" {so++;}
"]" {sc++;}
[$] {return 1;}
%%
int yywrap()
{
return 0;
}
int main()
{
yylex();
printf("\n for paranthesis [] open:%d closed :%d\n",so,sc);
printf("\n for parenthesis () open:%d closed :%d\n",bo,bc);
printf("\n for parenthesis {} open:%d closed :%d\n",co,cc);

if(so==sc)
{
printf("All square braces are matched  and BALANCED");
}
if(co==cc)
{
printf("All cury  braces are matched  and BALANCED");
}
if( bo==bc)
{
printf("All paranthesis re matched  and BALANCED");
}
return 1;
}
