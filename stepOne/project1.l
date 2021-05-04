%{
int COMMENT=0;
%}
identifier[a-zA-z][a-zA-Z0-9]*
	FILE *file;
	FILE *dosyayaz;	


%%

int {printf("\n%s ->Keyword(INT)",yytext); fprintf(dosyayaz,"\n%s ->Keyword(INT)",yytext);}
float {printf("\n%s ->Keyword(FLOAT)",yytext); fprintf(dosyayaz,"\n%s ->Keyword(FLOAT)",yytext);}
while {printf("\n%s ->Keyword(WHILE)",yytext); fprintf(dosyayaz,"\n%s ->Keyword(WHILE)",yytext);}
if {printf("\n%s ->Keyword(IF)",yytext); fprintf(dosyayaz,"\n%s ->Keyword(IF)",yytext);}
else {printf("\n%s ->Keyword(ELSE)",yytext); fprintf(dosyayaz,"\n%s ->Keyword(ELSE)",yytext);}
"/*" {COMMENT=1;} {printf("\n%s ->YORUM",yytext); fprintf(dosyayaz,"\n%s ->YORUM",yytext);} 
"*/" {COMMENT=1;} {printf("\n%s ->YORUM",yytext); fprintf(dosyayaz,"\n%s ->YORUM",yytext);}
{identifier}(\[[0-9]*\])? {if(!COMMENT) printf("\n%s ->Identifier(ID)",yytext); fprintf(dosyayaz,"\n%s ->Identifier(ID)",yytext);}

\< {if(!COMMENT) printf("\n%s ->Operator(KUCUK)",yytext); fprintf(dosyayaz,"\n%s ->Operator(KUCUK)",yytext);}
\> {if(!COMMENT) printf("\n%s ->Operator(BUYUK)",yytext); fprintf(dosyayaz,"\n%s ->Operator(BUYUK)",yytext);}
\- {if(!COMMENT) printf("\n%s ->Operator(EKSI)",yytext); fprintf(dosyayaz,"\n%s ->Operator(EKSI)",yytext);}
\+ {if(!COMMENT) printf("\n%s ->Operator(ARTI)",yytext); fprintf(dosyayaz,"\n%s ->Operator(ARTI)",yytext);}
\/ {if(!COMMENT) printf("\n%s ->Operator(BOLME)",yytext); fprintf(dosyayaz,"\n%s ->Operator(BOLME)",yytext);}
\* {if(!COMMENT) printf("\n%s ->Operator(CARPMA)",yytext); fprintf(dosyayaz,"\n%s ->Operator(CARPMA)",yytext);}
"||" {if(!COMMENT) printf("\n%s ->Operator(VEYA)",yytext); fprintf(dosyayaz,"\n%s ->Operator(VEYA)",yytext);}
"&&" {if(!COMMENT) printf("\n%s ->Operator(VE)",yytext); fprintf(dosyayaz,"\n%s ->Operator(VE)",yytext);}
== {if(!COMMENT) printf("\n%s ->Operator(ESIT)",yytext); fprintf(dosyayaz,"\n%s ->Operator(ESIT)",yytext);}
= {if(!COMMENT) printf("\n%s ->Operator(ATAMA)",yytext); fprintf(dosyayaz,"\n%s ->Operator(ATAMA)",yytext);}
; {if(!COMMENT) printf("\n%s ->Ayrıstırıcı(Noktali_virgul)",yytext); fprintf(dosyayaz,"\n%s ->Ayrıstırıcı(Noktali_virgul)",yytext);}
"(" {if(!COMMENT) printf("\n%s ->Ayrıstırıcı(Parantez_ac)",yytext); fprintf(dosyayaz,"\n%s ->Ayrıstırıcı(Parantez_ac)",yytext);}
")" {if(!COMMENT) printf("\n%s ->Ayrıstırıcı(Parantez_kapa)",yytext); fprintf(dosyayaz,"\n%s ->Ayrıstırıcı(Parantez_kapa)",yytext);}
, {if(!COMMENT) printf("\n%s ->Ayrıstırıcı(Virgul)",yytext);fprintf(dosyayaz,"\n%s ->Ayrıstırıcı(Virgul)",yytext);}
{ {if(!COMMENT) printf("\n%s ->Ayrıstırıcı(SParantez_ac)",yytext); fprintf(dosyayaz,"\n%s ->Ayrıstırıcı(SParantez_ac)",yytext);}
} {if(!COMMENT) printf("\n%s ->Ayrıstırıcı(SParantez_kapa)",yytext); fprintf(dosyayaz,"\n%s ->Ayrıstırıcı(SParantez_kapa)",yytext);}
\[ {if(!COMMENT) printf("\n%s ->Ayrıstırıcı(KParantez_ac)",yytext); fprintf(dosyayaz,"\n%s ->Ayrıstırıcı(KParantez_ac)",yytext);}
\[ {if(!COMMENT) printf("\n%s ->Ayrıstırıcı(KParanez_kapa)",yytext); fprintf(dosyayaz,"\n%s ->Ayrıstırıcı(KParanez_kapa)",yytext);}

{identifier}\( {if(!COMMENT);}
\{ {if(!COMMENT);}
\} {if(!COMMENT);}
\".*\" {if(!COMMENT);}
[0-9]+ {if(!COMMENT);}
 
%%

int main(int argc,char **argv)
{

	char fileName[20];
	printf(".c olmadan dosya adı girin: ");
	scanf("%s" , fileName);
	file=fopen(strcat(fileName,".c"),"r");
	if(!file)
	{
		printf("Dosya acilamadı!");
		exit(0);
	}
	dosyayaz=fopen("firstOutput.txt","w");
	yyin=file;
	yylex();
	printf("\n");
	return(0);
}
int yywrap()
{
	return (1);
}
