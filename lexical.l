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
    rechercher(yytext, "Mot cle", "-1", "-1", "-1", "-1", 1);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwVAR_GLOBAL;
}

DECLARATION { 
    rechercher(yytext, "Mot cle", "-1", "-1", "-1", "-1", 1);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwDECLARATION;
}

INSTRUCTION { 
    rechercher(yytext, "Mot cle", "-1", "-1", "-1", "-1", 1);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwINSTRUCTION;
}

CHAR {
    rechercher(yytext, "Mot cle", "-1", "-1", "-1", "-1", 1);
    ECHO; 
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwCHARACTER;
}

INTEGER {
    rechercher(yytext, "Mot cle", "-1", "-1", "-1", "-1", 1);
    ECHO; 
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwINTEGER;
}
    
FLOAT { 
    rechercher(yytext, "Mot cle", "-1", "-1", "-1", "-1", 1);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwFLOAT;
}

CONST { 
    rechercher(yytext, "Mot cle", "-1", "-1", "-1", "-1", 1);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwCONST;
}

READ { 
    rechercher(yytext, "Mot cle", "-1", "-1", "-1", "-1", 1);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwREAD;
}

WRITE { 
    rechercher(yytext, "Mot cle", "-1", "-1", "-1", "-1", 1);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwWRITE;
}

IF { 
    rechercher(yytext, "Mot cle", "-1", "-1", "-1", "-1", 1);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwIF;
}

ELSE { 
    rechercher(yytext, "Mot cle", "-1", "-1", "-1", "-1", 1);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwELSE;
}

FOR {
    rechercher(yytext, "Mot cle", "-1", "-1", "-1", "-1", 1);
    ECHO; 
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwFOR;
}

"||" {
    rechercher(yytext, "Separateur", "-1", "-1", "-1", "-1", 2);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwOR;
}

"&&" { 
    rechercher(yytext, "Separateur", "-1", "-1", "-1", "-1", 2);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwAND;
}

">" { 
    rechercher(yytext, "Separateur", "-1", "-1", "-1", "-1", 2);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwGT;
}

">=" { 
    rechercher(yytext, "Separateur", "-1", "-1", "-1", "-1", 2);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwGE;
}

"==" {
    rechercher(yytext, "Separateur", "-1", "-1", "-1", "-1", 2);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwEQ;
}

"<=" { 
    rechercher(yytext, "Separateur", "-1", "-1", "-1", "-1", 2);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwLE;
}

"<" { 
    rechercher(yytext, "Separateur", "-1", "-1", "-1", "-1", 2);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwLT;
}

"!=" { 
    rechercher(yytext, "Separateur", "-1", "-1", "-1", "-1", 2);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    return kwNE;
}

{real} {
    if (atof(yytext) >= -32768.32767 && atof(yytext) <= 32767.32767) {
        rechercher(yytext, "REEL", "-1", yytext, "-1", "-1", 0);
        ECHO;
        nb_character += strlen(yytext);
        yylval.str=strdup(yytext);
        return real;
    }
    else {
        printf("File '%s', line %d, character %d: lexical error - real number out of range\n", 
               file_name, nb_line, nb_character);
    }
}

{integer} {    
    if (atoi(yytext) >= -32768 && atoi(yytext) <= 32767) { 
        rechercher(yytext, "INT", "-1", yytext, "-1", "-1", 0);
        ECHO;
        nb_character += strlen(yytext);
        yylval.str=strdup(yytext);
        return integer;
    } 
    else {
        printf("File '%s', line %d, character %d: lexical error - integer out of range\n",
               file_name, nb_line, nb_character);
    }    
}

{character} {
    rechercher(yytext, "CHAR", "-1", yytext, "-1", "-1", 0);
    ECHO;
    nb_character += strlen(yytext);
    sprintf(x,"%d",strlen(yytext)-2);
    yylval.str=strdup(yytext);
    return character;
}

{IDF} {
    if(strlen(yytext)>8){        
        printf("File '%s', line %d, character %d: lexical error - identifier too long\n",
               file_name, nb_line, nb_character);
    }
    else {
        rechercher(yytext, "IDF", "-1", "-1", "-1", "-1", 0);
        ECHO;
        yylval.str=strdup(yytext);
        return idf;
    }
}

[+\-*/=;().,:{}[\]] {
    rechercher(yytext, "Separateur", "-1", "-1", "-1", "-1", 2);
    ECHO;
    nb_character += strlen(yytext);
    yylval.str=strdup(yytext);
    switch(yytext[0]) {
        case '+': return plus;
        case '-': return minus;
        case '*': return mul;
        case '/': return divi;
        case '=': return aff;
        case ';': return pvg;
        case '(': return po;
        case ')': return pf;
        case '.': return pt;
        case ',': return vg;
        case ':': return dp;
        case '{': return ao;
        case '}': return af;
        case '[': return co;
        case ']': return cf;
    }
}

{commentaire} { ECHO; nb_character += strlen(yytext); }
[ \t] { ECHO; nb_character += strlen(yytext); }
\n { ECHO; nb_line++; nb_character=0; }

. {
    nb_character += strlen(yytext);
    printf("File '%s', line %d, character %d: lexical error - invalid character\n",
           file_name, nb_line, nb_character);
}

%%
