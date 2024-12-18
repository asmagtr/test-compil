%{
	#include "syntaxique.tab.h"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	extern int nb_line;
	extern int nb_character;
	extern char *file_name;
	extern YYSTYPE yylval;
	char x[20];
	extern int emp;
%}

letter [a-zA-Z]
number [0-9]
IDF {letter}({letter}|{number})* 
integer [-]?{number}+
real [-]?{number}+"."{number}+
character "\"".+"\""
commentaire %%[^\n]+

%%

VAR_GLOBAL { 
	ECHO;
	nb_character += strlen(yytext);
	yylval.str=strdup(yytext);
	return kwVAR_GLOBAL;}


DECLARATION { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwDECLARATION;}

INSTRUCTION { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwINSTRUCTION;}

CHAR {
	ECHO; 
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwCHARACTER;}

INTEGER {
	ECHO; 
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwINTEGER;}
    
FLOAT { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwFLOAT;}

CONST { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwCONST;}


READ { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwREAD;}

WRITE { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwWRITE;}

IF { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwIF;}

ELSE { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwELSE;}

FOR {
	ECHO; 
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwFOR;}




"||" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwOR;}
"&&" { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwAND;}
">" { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwGT;}
">=" { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwGE;}
"==" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwEQ;}
"<=" { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwLE;}
"<" { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwLT;}
"!=" { 
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return kwNE;}



{real} {
	if (atof(yytext) >= -32768.32767 && atof(yytext) <= 32767.32767) {
		ECHO;
		nb_character += strlen(yytext);
		
		yylval.str=strdup(yytext);
		return real;
	}
	else{
		printf("File '%s', line %d, character %d: lexical error\n",file_name,nb_line,nb_character);
	}
}
{integer} {	
	if (atoi(yytext) >= -32768 && atoi(yytext) <= 32767) { 
		ECHO;
		nb_character += strlen(yytext);
		
		yylval.str=strdup(yytext);
		return integer;
    } 
	else{
		printf("File '%s', line %d, character %d: lexical error\n",file_name,nb_line,nb_character);
	}	
}
{character} {
	ECHO;
	nb_character += strlen(yytext);
	sprintf(x,"%d",strlen(yytext)-2);
	
	yylval.str=strdup(yytext);
	return character;
}
{IDF} {
	if(strlen(yytext)>10){		
		printf("File '%s', line %d, character %d: lexical error\n",file_name,nb_line,nb_character);
	}
	else{
		ECHO;
		yylval.str=strdup(yytext);
		return idf;
	}
}

"+" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return plus;}
"-" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return minus;}
"*" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return mul;}
"/" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return divi;}

"=" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return aff;}
	
";" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return pvg;}
"(" {
    ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return po;}
")" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return pf;}
"." {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return pt;}
"," {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return vg;}


":" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return dp;}

"{" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return ao;}
"}" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return af;}

"[" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return co;}

"]" {
	ECHO;
	nb_character += strlen(yytext);
	
	yylval.str=strdup(yytext);
	return cf;}

{commentaire} {
	ECHO;
	nb_character += strlen(yytext);
}
[ \t] {
	ECHO;
	nb_character += strlen(yytext);
}
\n {ECHO; nb_line++; nb_character=0;}
. {
	nb_character += strlen(yytext);
	printf("File '%s', line %d, character %d: lexical error\n",file_name,nb_line,nb_character);
}
