%option caseless
%option yylineno
%option noyywrap

%{
    #include "tokens.h"
    /*enum yytokentype{
        TK_SELECT = 258,
        TK_UPDATE = 259,
        TK_DELETE = 260,
        TK_INSERT = 261,
        TK_WHERE = 262,
        TK_GROUP_BY = 263,
        TK_IN = 264,
        TK_ORDER_BY =265,
        TK_LIT_INT = 266,
        TK_ID= 267,
        TK_LIT_STRING=268
    };
    extern int yylval;*/
%}

DIGIT [0-9]

%%
[\t \r \n] { /* do nothing */}
"select" { return TK_SELECT; }
"from" { return TK_FROM; }
"update" { return TK_UPDATE; }
"delete" { return TK_DELETE; }
"insert" { return TK_INSERT; }
"where" { return TK_WHERE; }
"group by" { return TK_GROUP_BY; }
"in" { return TK_IN; }
"order by" { return TK_ORDER_BY; }
"into" { return TK_INTO; }
"values" { return TK_VALUES; }
"set" { return TK_SET; }
"or" { return TK_OR; }
"and" { return TK_AND; }
{DIGIT}+ { yylval.int_t = atoi(yytext); return TK_LIT_INT;}
[a-zA-Z]({DIGIT}|[a-zA-Z_0-9]|_)* { yylval.string_t = strdup(yytext);  return TK_ID;}
\'.*\' { yylval.string_t = strdup(yytext); return TK_LIT_STRING; }
"(" { return '('; }
")" { return ')'; }
"*" { return '*'; }
"+" { return '+'; }
"-" { return '-'; }
"/" { return '/'; }
";" { return ';'; }
"," { return ','; }
">=" { return TK_GTE; }
"<=" { return TK_LTE; }

"=" { return TK_EQUALS; }
"!=" { return TK_NOT_EQUAL; }
. {printf("Invalid character %c, line %d\n", yytext[0], yylineno);}


%%