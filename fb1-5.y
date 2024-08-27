%{
  #include <stdio.h>
  #include <math.h>  // Incluir biblioteca matemática para fabs()
  int yylex(void);              // Declaración de yylex
  void yyerror(const char *s);  // Declaración de yyerror
  int has_error = 0;
%}

/* declare tokens */
%token <ival> NUMBER
%token <fval> DECIMAL
%token ADD SUB MUL DIV ABS
%token OP CP
%token EOL
%union {
    int ival;
    float fval;
}

%type <fval> exp factor term
%type <ival> calclist

%%

calclist: /* nothing */
 | calclist exp EOL {
    if (!has_error){
       printf("= %.2f\n> ", $2);
    } else {
      has_error = 1;
      printf("\n> ");
    }


  }  // Cambia %d a %f para imprimir flotantes
 | calclist EOL { printf("> "); } /* blank line or a comment */
 ;

exp: factor
 | exp ADD exp { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 | exp ABS factor { $$ = fabs($3); }  // Cambia la operación bitwise a fabs()
 ;

factor: term
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { if ($3 == 0){
    printf("invalido");
    has_error = 1;
 } else{
  $$ = $1 / $3; 
 }}
 ;

term: NUMBER { $$ = $1; }
 | DECIMAL { $$ = $1; }
 | ABS term { $$ = fabs($2); }  // Cambia la operación bitwise a fabs()
 | OP exp CP { $$ = $2; }
 ;
%%
int main()
{
  printf("> "); 
  yyparse();
  return 0;
}

void yyerror(const char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
