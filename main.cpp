#include <stdio.h>

using namespace std;

extern FILE * yyin;
int yylval;
int yyparse();
int yylex();


int main(int argc, char*argv[]){

    if (argc != 2)
    {
        fprintf(stderr, "Missing input file %s \n", argv[0]);
        return 1;
    }

    FILE * f = fopen(argv[1], "r");
    if (f == NULL)
    {
        fprintf(stderr, "Couldn't open file %s \n", argv[1]);
        return 1;
    }
    
    yyin = f;

    //yyparse();
    int token;
    while (token = yylex())
    {
        printf("Token type: %d\n",token);
    }
    

    return 0;
}