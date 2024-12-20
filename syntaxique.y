%{
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
extern int yylex(); // Declare the lexer function
extern int yylineno; // Declare the line number variable if used

int nb_line=1;
int nb_character=0;
char *file_name;
char taille[20];
char empla[20];
int emp=1;
char typeIDF[20];
char savet[20];
int param=0;
char para[20];
char stri[]="whatever";

char i[20];
int deb_else;
int fin_if;
int fin_dowhile;
int deb_dowhile;
int qc;

char partie1_1[20];
char partie2_1[20];
char partie1_2[20];
char partie2_2[20];
char ch[20];
char cat[20];
int tmp=0;
char temp[20];

char tab[20];

%}

%union {
    char* str;
}

%type <str>EXPRESSION INDEX AFFECTATION CONDITION CONTROLE BOUCLE OPCOMP OPLOG TYPE MEMBREIDF MESSAGE MESSAGEIDF
;

%token <str>plus minus mul divi aff pvg po pf pt vg dp
        kwVAR_GLOBAL kwDECLARATION kwCONST kwINSTRUCTION kwINTEGER kwFLOAT kwCHARACTER kwREAD kwWRITE kwIF kwFOR
       kwELSE kwENDIF  kwOR kwAND kwGT kwGE kwEQ kwLE kwLT kwNE 
       integer real character idf boolean ao af co cf
;

%start CODE

%right aff 
%left plus minus
%left mul divi
%left kwEQ kwNE kwLT kwLE kwGT kwGE
%left kwOR
%left kwAND 

%%
CODE: kwVAR_GLOBAL ao DEC af MAIN {printf("\n\nCode correct!\n\n"); YYACCEPT;}
;

MAIN: kwINSTRUCTION ao INST af { printf("\n\n declaration main correct!\n\n");}
;

DEC: DECSOLO DEC 
   | DECTAB  DEC
   |
;

TYPE: kwINTEGER  {$$=strdup($1);strcpy(savet,$1);}
    | kwFLOAT     {$$=strdup($1);strcpy(savet,$1);}
    | kwCHARACTER  {$$=strdup($1);strcpy(savet,$1);}
;

DECSOLO: TYPE idf LISTVAR pvg 
              { 
              printf("\n\n %s declaration TYPE idf Listvar pvg correct!\n\n",stri);
              }
       | TYPE idf aff EXPRESSION LISTVAR pvg 
              { 
                printf("\n\n %s declaration correct!\n\n",stri);
              }
; 

DECTAB: TYPE idf po integer pf LISTVAR pvg 
            { 
             printf("\n\n %s declaration correct!\n\n",stri);
            }
;

LISTVAR: LISTVARSOLO
       | LISTVARTAB
       |
;

LISTVARSOLO: vg idf LISTVAR 
                  {  
                   printf("\n\n %s declaration correct!\n\n",stri);
                  }
           | vg idf aff EXPRESSION LISTVAR 
                  { 
                    printf("\n\n %s declaration correct!\n\n",stri);
                  }
;

LISTVARTAB: vg idf po integer pf LISTVAR 
                  { 
                    printf("\n\n %s declaration correct!\n\n",stri);
                  }
;

INST: INSTS INST
    |
;

INSTS: ENTREE      pvg 
     | SORTIE      pvg 
     | AFFECTATION pvg 
     | CONTROLE        
     | BOUCLE     
; 

AFFECTATION: idf aff EXPRESSION  
                  { 
                    printf("\n\n %s affectation correct!\n\n",stri);
                  }
           | idf co INDEX cf aff EXPRESSION
                  { 
                    printf("\n\n %s declaration correct!\n\n",stri);
                  }   
;
 
EXPRESSION: EXPRESSION plus EXPRESSION
                  { 
                   printf("\n\n %s declaration correct!\n\n",stri);
                  }  
          | EXPRESSION minus EXPRESSION
                  { 
                    printf("\n\n %s declaration correct!\n\n",stri);
                  }  
          | EXPRESSION mul EXPRESSION
                  { 
                  printf("\n\n %s declaration correct!\n\n",stri);
                  }  
          | EXPRESSION divi EXPRESSION 
                  {  
                    printf("\n\n %s declaration correct!\n\n",stri);
                  } 
          | idf  
                  { 
                   printf("\n\n %s declaration correct!\n\n",stri);
                  }      
          | idf co INDEX cf 
                  {
                    printf("\n\n %s declaration correct!\n\n",stri);
                  }
          | real    
              {
                strcpy(cat,"REAL-");
                strcat(cat,$1);
                $$=strdup(cat);
              }                
          | integer  
              {
                strcpy(cat,"INTEGER-");
                strcat(cat,$1);
                $$=strdup(cat);
              }                  
          | boolean  
              {
                strcpy(cat,"LOGICAL-");
                strcat(cat,$1);
                $$=strdup(cat);
              }                    
          | character  
              {
                strcpy(cat,"CHARACTER-");
                strcat(cat,$1);
                $$=strdup(cat);
              }                 
          | po EXPRESSION pf  
              {
                $$=strdup($2);
              }        
;

INDEX: idf 
        { 
          printf("\n\n %s declaration correct!\n\n",stri);
        }
     | integer 
        {
          printf("\n\n %s declaration correct!\n\n",stri);
          $$=strdup($1);
        }
;

R2_1_CONTROLE: kwIF CONDITION 
              {
                deb_else=qc;
                fin_if=qc;
                printf("\n\n %s declaration correct!\n\n",stri);
              }
;

R1_2_CONTROLE: R2_1_CONTROLE ao INST af 
              {
                fin_if=qc;
                printf("\n\n %s declaration correct!\n\n",stri);
                sprintf(i,"%d",qc); 
                
              }
;

R3_1_CONTROLE: kwIF EXPRESSION 
              {
                printf("\n\n %s declaration correct!\n\n",stri);
                deb_else=qc;
                fin_if=qc;
                
              }
;

R4_2_CONTROLE: R3_1_CONTROLE ao INST af
              {
                fin_if=qc;
                printf("\n\n %s declaration correct!\n\n",stri);
                sprintf(i,"%d",qc); 
              }
;

CONTROLE: R1_2_CONTROLE kwELSE ao INST af
              {
                sprintf(i,"%d",qc);
                printf("\n\n %s declaration correct!\n\n",stri);
              }
        | R2_1_CONTROLE ao INST af 
              {
                sprintf(i,"%d",qc);
                printf("\n\n %s declaration correct!\n\n",stri);
              }
        | R3_1_CONTROLE ao INST af
              {
                sprintf(i,"%d",qc);
                printf("\n\n %s declaration correct!\n\n",stri);
              }
        | R4_2_CONTROLE kwELSE ao INST af 
              {
                sprintf(i,"%d",qc);
                printf("\n\n %s declaration correct!\n\n",stri);
              }
;

CONDITION: po EXPRESSION OPCOMP EXPRESSION pf
              { 
                printf("\n\n %s declaration correct!\n\n",stri);
              }
         | po CONDITION  OPLOG  CONDITION pf
              {
               printf("\n\n %s declaration correct!\n\n",stri);
              }
         | po CONDITION pf
              {
                printf("\n\n %s declaration correct!\n\n",stri);
              }         
;               

OPLOG: kwAND {$$=strdup($1);}
     | kwOR  {$$=strdup($1);}
;

OPCOMP: kwGT {$$=strdup($1);}
      | kwGE {$$=strdup($1);} 
      | kwEQ {$$=strdup($1);}
      | kwLE {$$=strdup($1);}
      | kwLT {$$=strdup($1);}
      | kwNE {$$=strdup($1);}
;
BOUCLE: kwFOR po AFFECTATION dp EXPRESSION dp CONDITION pf ao INSTS af
            {
              printf("\n\n %s declaration correct!\n\n",stri);
            }
;
MEMBREIDF : idf                      
                { 
                 printf("\n\n %s declaration correct!\n\n",stri);
                  $$=strdup($1);
                }
          | idf co INDEX cf 
                { 
                  printf("\n\n %s declaration correct!\n\n",stri);
                  $$=strdup($1);
                }
;

ENTREE: kwREAD po MEMBREIDF pf 
;

SORTIE: kwWRITE po MESSAGE pf 
          {
            printf("\n\n %s declaration correct!\n\n",stri);
          }
      | kwWRITE po MEMBREIDF pf  
          {
            printf("\n\n %s declaration correct!\n\n",stri);
          }
; 

MESSAGE: character MESSAGEIDF
          {
            strcat(tab,$1);strcat(tab,$2);
            $$=strdup(tab);
            strcpy(tab," ");
            printf("\n\n %s declaration correct!\n\n",stri);
          }
       | character
          {
            $$=strdup($1);
            printf("\n\n %s declaration correct!\n\n",stri);
          }
       | MEMBREIDF vg MESSAGE
          {
            strcat(tab,$1);strcat(tab,$2);strcat(tab,$3);
            $$=strdup(tab);
            strcpy(tab," ");
            printf("\n\n %s declaration correct!\n\n",stri);
          }
;

MESSAGEIDF: vg MEMBREIDF vg MESSAGE
              {
                strcat(tab,$1);strcat(tab,$2);strcat(tab,$3);strcat(tab,$4);
                $$=strdup(tab);
                strcpy(tab," ");
                printf("\n\n %s declaration correct!\n\n",stri);
              }
          | vg MEMBREIDF 
              {
                strcat(tab,$1);strcat(tab,$2);
                $$=strdup(tab);
                strcpy(tab," ");
                printf("\n\n %s declaration correct!\n\n",stri);
              }
;


%%

int yyerror(char *msg) { 
  printf("\nFile '%s', line %d, character %d: syntax error\n",file_name,nb_line,nb_character);
  return 1; 
}

int main(int argc,char *argv[]){
  file_name=argv[1];
  yyparse();
  return 0;
}

int yywrap(){
  return 0;
}

