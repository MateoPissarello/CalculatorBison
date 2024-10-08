/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/fb1-5.l,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */

/* recognize tokens for the calculator and print them out */

%{
    #include "fb1-5.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
void yyerror(const char *s);
%}

%%
"+"	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return DIV; }
"|"     { return ABS; }
"("     { return OP; }
")"     { return CP; }
-?[0-9]+	{ yylval.ival = atoi(yytext); return NUMBER; }
-?[0-9]+(\.[0-9]*)? { yylval.fval = atof(yytext); return DECIMAL; }

\n      { return EOL; }
"//".*  
[ \t]   { /* ignore white space */ }
.	{   
        char msg[50];
        sprintf(msg, "Mystery character %c", *yytext);
        yyerror(msg);
    }
%%