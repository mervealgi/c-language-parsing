identifier[a-zA-z][a-zA-Z0-9]*

%%
[ \t]       ;
[ \n]   { yylineno = yylineno + 1;}
int {return INT;}
float return FLOAT;
while   return WHILE;
if  return IF;
else    return ELSE;
^"#include ".+ ;
{identifier}(\[[0-9]*\])? return ID;
"=="    return ESIT;
">" return BUYUK;
"<" return KUCUK;
";"     return NOKTA;
\/\/.* ;
\/\*(.*\n)*.*\*\/ ;
.       return yytext[0];
%%
