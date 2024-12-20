#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

// Definition des structures de données

typedef struct Element {
    char name[96];
    char code[20];
    char type[20];
    char val[20];
    char taille[20];
    char colonne[20]; // pour la dimension d'un tableau
    char update[20];
    struct Element* next;
} Element;

typedef struct MotCle {
    char name[20];
    char type[20];
    struct MotCle* next;
} MotCle;

typedef struct Separateur {
    char name[20];
    char type[20];
    struct Separateur* next;
} Separateur;

typedef struct SymbolTables {
    Element* tab;
    MotCle* tabm;
    Separateur* tabs;
} SymbolTables;

SymbolTables table; 

// Initialisation de l'état des cases des tables des symboles
void initialisation() {
    table.tab = NULL;
    table.tabm = NULL;
    table.tabs = NULL;
}

// Insertion des entités lexicales dans les tables des symboles
void inserer(char entite[], char code[], char type[], char val[],char taille[],char colonne[],int y) {
        switch (y) {
        case 0: { // insertion dans la table des IDF et CONST
            Element* newNode = (Element*)malloc(sizeof(Element));
            if (newNode == NULL) {
                fprintf(stderr, "Memory allocation failed.\n");
                exit(EXIT_FAILURE);
            }
            strcpy(newNode->name, entite);
            
            strcpy(newNode->code," ");
            strcpy(newNode->type," ");
            strcpy(newNode->val," ");
            strcpy(newNode->taille," ");
            strcpy(newNode->colonne," ");
            strcpy(newNode->update,"LEXICAL");

            if (strcmp(code,"-1")!=0){
                strcpy(newNode->code, code);
            }
            if (strcmp(type,"-1")!=0){
                strcpy(newNode->type, type);
            }
            if (strcmp(val,"-1")!=0){
                strcpy(newNode->val,val);
            }
            if (strcmp(taille,"-1")!=0){
                strcpy(newNode->taille,taille);
            }
            if (strcmp(colonne,"-1")!=0){
                strcpy(newNode->colonne,colonne);
            }


            newNode->next = NULL; 
             if (table.tab == NULL) {
                table.tab = newNode;
            } else {
                Element* current = table.tab;
                while (current->next != NULL) {
                    current = current->next;
                }
                current->next = newNode;
            }

            break;
        }

        case 1: { // insertion dans la table des mots clés
            MotCle* newNode = (MotCle*)malloc(sizeof(MotCle));
            if (newNode == NULL) {
                fprintf(stderr, "Memory allocation failed.\n");
                exit(EXIT_FAILURE);
            }

            strcpy(newNode->name, entite);
            strcpy(newNode->type, code);
            newNode->next = NULL; 
            if (table.tabm == NULL) {
                table.tabm = newNode;
            } else {
                MotCle* current = table.tabm;
                while (current->next != NULL) {
                    current = current->next;
                }
                current->next = newNode;
            }
            break;
        }

        case 2: { // insertion dans la table des séparateurs
            Separateur* newNode = (Separateur*)malloc(sizeof(Separateur));
            if (newNode == NULL) {
                fprintf(stderr, "Memory allocation failed.\n");
                exit(EXIT_FAILURE);
            }
            strcpy(newNode->name, entite);
            strcpy(newNode->type, code);

            newNode->next = NULL;  
            if (table.tabs == NULL) {
                table.tabs = newNode;
            } else {
                Separateur* current = table.tabs;
                while (current->next != NULL) {
                    current = current->next;
                }
                current->next = newNode;
            }
            break;
        }
    }
}


void miseajour(char entite[], char code[], char type[], char val[],char taille[],char colonne[],char update[]) {
    Element* current = table.tab;
    while (current != NULL) {
        if ( strcmp(entite, current->name) == 0 ) {
            if (strcmp(code,"-1")!=0){
                strcpy(current->code, code);
                strcpy(current->update,update);
            }
            if (strcmp(type,"-1")!=0){
                strcpy(current->type, type);
                strcpy(current->update,update);
            }
            if (strcmp(val,"-1")!=0){
                strcpy(current->val,val);
                strcpy(current->update,update);
            }
            if (strcmp(taille,"-1")!=0){
                strcpy(current->taille,taille);
                strcpy(current->update,update);
            }
            if (strcmp(colonne,"-1")!=0){
                strcpy(current->colonne,colonne);
                strcpy(current->update,update);
            }
        }
        current = current->next;
    } 

 
}

void rechercher(char entite[], char code[], char type[], char val[],char taille[],char colonne[], int y) {
        switch (y) {
        case 0: // vérifier si la case dans la table des IDF et CONST est libre
        {
            Element* current = table.tab;
            while (current != NULL && (strcmp(entite, current->name) != 0)) {
                current = current->next;
            }  
            if (current == NULL) {
                inserer(entite, code, type, val,taille,colonne,0);
            } 
        break;
        }

        case 1: // vérifier si la case dans la table des mots clés est libre
        {
            MotCle* current = table.tabm;
            while (current != NULL && (strcmp(entite, current->name) != 0)) {
                current = current->next;
            }

            if (current == NULL) {
                inserer(entite, code, type, val,taille,colonne,1);
            } 
            break;
        }

        case 2: // vérifier si la case dans la table des séparateurs est libre
        {
            Separateur* current = table.tabs;
            while (current != NULL && (strcmp(entite, current->name) != 0)) {
                current = current->next;
            }

            if (current == NULL) {
                inserer(entite, code, type, val,taille,colonne,2);
            }
            break;
        }
        
        case 3: // mise a jour des idf des fonctions appelées et des messages
        {
            Element* current = table.tab;
            while (current != NULL && (strcmp(entite, current->name) != 0) && (strcmp(code,current->code) != 0))
            {
                current = current->next;
            }
                if (strcmp(type,current->type) == 0)
                {
                    miseajour(entite,"Message de sortie","-1",val,taille,colonne,"SYNTAXIQUE");
                }
        break;
        
        }
    }
}

// verifier si l'idf existe dans la ts
bool idf_existe(char entite[],char code[]){
    Element* current = table.tab;
    while (current != NULL && (strcmp(entite, current->name) != 0 || strcmp(code,current->code) != 0)) {
            current = current->next;
        }
    if (current != NULL) {
        return true;
    }
    return false;   
}

// retourner le type d'un idf
char* getType(char entite[],char code[]){
   
    Element* current = table.tab;
        while (current != NULL && (strcmp(entite, current->name) != 0|| strcmp(code,current->code) != 0)) {
            current = current->next;
        }
    if (current != NULL) {
        return current->type;
    }
    else{
        return "NULL";
    }       
}

// verifie si l'indice du tableau existe selon sa dimension
bool verif_index(char entite[],char code[],char index[]){
    Element* current = table.tab;
    while (current != NULL && (strcmp(entite, current->name) != 0  || strcmp(code,current->code) != 0)) {
        current = current->next;
    }

}