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
%token TK_GTE TK_LTE
%token TK_OR TK_AND TK_EQUALS TK_NOT_EQUAL

%%

input: statement_list
    ;


statement_list: statement_list statement ';'
    | statement ';'
    ;

statement: select_stmt
    | insert_stmt
    | update_stmt
    | delete_stmt
    ;

select_stmt: TK_SELECT select_parameter TK_FROM TK_ID where_clause group_by_clause order_by_clause
    ;

select_parameter: '*'
    | parameter_order_list
    ;

where_clause: 
    | TK_WHERE expr
    ;

expr: expr TK_IN '('select_stmt')'
    | expr TK_IN '('values')'
    | logical_or_expression
    ;

group_by_clause: 
    | TK_GROUP_BY TK_ID
    ;

order_by_clause:
    | TK_ORDER_BY parameter_order_list
    ;    

parameter_order_list: parameter_order_list ',' parameter_order
    | parameter_order
    ;

parameter_order: TK_ID
    ;

insert_stmt: TK_INSERT TK_INTO TK_ID '(' parameter_insert_list ')' TK_VALUES '(' values ')'
    ;

parameter_insert_list: parameter_insert_list ',' parameter_insert
    | parameter_insert
    ;

parameter_insert: TK_ID
    ;

values: values ',' value
    | value
    ;

value: primary_expression
    ;

update_stmt: TK_UPDATE TK_ID set_clause where_clause
    ;

set_clause: TK_SET set_parameter_list
    ;

set_parameter_list: set_parameter_list ',' set_parameter
    | set_parameter
    ;

set_parameter: TK_ID TK_EQUALS primary_expression
    ;

delete_stmt: TK_DELETE TK_FROM TK_ID where_clause
    ;

logical_or_expression: logical_or_expression TK_OR logical_and_expression
                    | logical_and_expression
                    ;

logical_and_expression: logical_and_expression TK_AND equality_expression
                      | equality_expression
                      ;

equality_expression: equality_expression TK_EQUALS  relational_expression
                   | equality_expression TK_NOT_EQUAL relational_expression
                   | relational_expression
                   ;

relational_expression: relational_expression '>' additive_expression
                     | relational_expression '<' additive_expression
                     | relational_expression TK_GTE additive_expression
                     | relational_expression TK_LTE additive_expression
                     | additive_expression
                     ;
                
additive_expression: additive_expression '+' multiplicative_expression
                   | additive_expression '-' multiplicative_expression
                   | multiplicative_expression
                   ;

multiplicative_expression: multiplicative_expression '*' primary_expression
                         | multiplicative_expression '/' primary_expression
                         | primary_expression
                         ;

primary_expression: TK_ID
                  | constant
                  | TK_LIT_STRING
                  ;

constant: TK_LIT_INT
        | TK_LIT_FLOAT
        ;

%%