%{
#include<stdio.h>
int ot=0,ct=0,st=0;
%}
%%
"<"[^>]*"/>"    { st++; }
"</"[^>]+">"    { ct++; }
"<"[^/>][^>]*">" { ot++; }

[$] {return 0;}
. {;}

%%
int yywrap()
{
return 0;
}
int main()
{
	printf("enter statement");
	yylex();
	printf("open tag :%d \n closed tag:%d\n self tag :%d\n",ot,ct,st);
}
