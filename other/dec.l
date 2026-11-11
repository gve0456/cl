
%{
#include "y.tab.h"
%}

%%

(int|float|double|char)  { return TYPE; }

[a-zA-Z_][a-zA-Z0-9]*    { return NAME; }

[0-9]+                   { return VALUE; }

[ \t\n]+                 ;

.                        { return yytext[0]; }

%%

int yywrap()
{
    return 1;
}

