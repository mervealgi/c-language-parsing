%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *fp;


%}

%token INT FLOAT 
%token FOR WHILE
%token IF ELSE PRINTF
%token STRUCT
%token ID
%token INCLUDE
%token NOKTA

%right '='
%left '<' '>' ESIT NE KUCUK BUYUK VE VEYA ESITDEGIL 
%%

start:  Function
    | Declaration
    ;

/* Declaration block */
Declaration: Type Assignment ';'
    | Assignment ';'
    | FunctionCall ';'
    | ArrayUsage ';'
    | Type ArrayUsage ';'
    | StructStmt ';'
    | error
    ;

/* Assignment block */
Assignment: ID '=' Assignment
    | ID '=' FunctionCall
    | ID '=' ArrayUsage
    | ArrayUsage '=' Assignment
    | ID ',' Assignment
    | ID '+' Assignment
    | ID '-' Assignment
    | ID '*' Assignment
    | ID '/' Assignment
    | '\'' Assignment '\''
    | '(' Assignment ')'
    | '-' '(' Assignment ')'
    | '-' ID
    |   ID
    ;

/* Function Call Block */
FunctionCall : ID'('')'
    | ID'('Assignment')'
    ;

/* Array Usage */
ArrayUsage : ID'['Assignment']'
    ;

/* Function block */
Function: Type ID '(' ArgListOpt ')' CompoundStmt
    ;
ArgListOpt: ArgList
    |
    ;
ArgList:  ArgList ',' Arg
    | Arg
    ;
Arg:    Type ID
    ;
CompoundStmt:   '{' StmtList '}'
    ;
StmtList:   StmtList Stmt
    |
    ;
Stmt:   WhileStmt
    | Declaration
    | ForStmt
    | IfStmt
    | PrintFunc
    | ';'
    ;

/* Type Identifier block */
Type:   INT
    | FLOAT
    ;

/* Loop Blocks */
WhileStmt: WHILE '(' Expr ')' Stmt
    | WHILE '(' Expr ')' CompoundStmt
    ;

/* For Block */
ForStmt: FOR '(' Expr ';' Expr ';' Expr ')' Stmt
       | FOR '(' Expr ';' Expr ';' Expr ')' CompoundStmt
       | FOR '(' Expr ')' Stmt
       | FOR '(' Expr ')' CompoundStmt
    ;

/* IfStmt Block */
IfStmt : IF '(' Expr ')'
        Stmt
    ;

/* Struct Statement */
StructStmt : STRUCT ID '{' Type Assignment '}'
    ;

/* Print Function */
PrintFunc : PRINTF '(' Expr ')' ';'
    ;

/*Expression Block*/
Expr:
    | Expr VEYA Expr
    | Expr VE Expr
    | Expr ESITDEGIL Expr
    | Expr ESIT Expr
    | Expr BUYUK Expr
    | Expr KUCUK Expr
    | Assignment
    | ArrayUsage
    ;
%%
#include"lex.yy.c"
#include<ctype.h>
int count=0;


int main(int argc, char *argv[])
{
   FILE *dosyayaz; 	//yazılacak dosya
   FILE *stepOne;	//birinci ödevden okunacak dosya
   int ch;

	dosyayaz=fopen("secondOutput.txt","w");
	stepOne=fopen("firstOutput.txt","r");
	yyin = fopen(argv[1], "r");

      if(!yyparse()){
           printf("\n\n\n Parsing tamamlandı.\n");
           while((ch=fgetc(stepOne)) != EOF){
		fputc(ch,dosyayaz);
	}
	fprintf(dosyayaz,"\nParsing başarılı.");
  	}
    else
        printf("\nHatalı ifade!\n");

    fclose(yyin);
    return 0;
}

yyerror(char *s) {
    printf("%d : %s %s\n", yylineno, s, yytext );
}
