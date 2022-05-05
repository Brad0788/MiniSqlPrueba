%{
    #include <cstdio>
    using namespace std;
    int yylex();
    extern int yylineno;

    void yyerror(const char * s){
        fprintf(stderr, "Line %d, error: %s\n", yylineno, s);
    }
%}

%union{
    const char* string_t;
    int int_t;
    float float_t;
}

%token<string_t> TK_ID TK_LIT_STRING
%token<int_t> TK_LIT_INT
%token<float_t> TK_LIT_FLOAT
%token TK_SELECT
%token TK_UPDATE
%token TK_DELETE
%token TK_INSERT
%token TK_WHERE TK_GROUP_BY TK_IN TK_ORDER_BY
%token TK_INTO TK_VALUES TK_SET TK_FROM

%%

input: input statement_list
    ;

statement_list: statement ';'
    | statement_list statement ';'

statement: select_stmt
    ;

select_stmt: TK_SELECT select_parameter TK_FROM TK_ID where_clause group_by_clause order_by_clause
    ;

select_parameter: '*'
    ;

where_clause: 
    | TK_WHERE expr
    ;

expr:
    ;


