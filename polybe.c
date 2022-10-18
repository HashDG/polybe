#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define RESET(string) strcpy(string, "")

char* ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVXYZ";
const int LARGEUR = 5, DECALAGE = 0;

void afficherCarre(char* carre) {
	for (int i = 0; i < LARGEUR; i+=1) {
		for (int j = 0; j < LARGEUR; j+=1) {
			printf("%c ", carre[i * LARGEUR + j]);
		}
		printf("\n");
	}
}

bool estPresent(char * mot, char lettre) {
	bool presence = false;
	int idx = 0;
	while (idx < strlen(mot) && presence == false) {
		if (mot[idx] == lettre) {
			presence = true;
		} else {
			idx += 1;
		}
	}
	return presence;
}

char * initialiserCarreAvecCle(char * carre, char * cle) {
	char charc;
	char buffer[1];
	int idx, jdx, kdx = 0;
	
	while(kdx < LARGEUR * LARGEUR) {
		if (strlen(cle) > idx) {
			charc = cle[idx++];
		} else {
			charc = ALPHABET[jdx++];
		}
		if (charc == 'W') {
			charc = 'V';
		}
		if (estPresent(carre, charc) == false) {
			buffer[0] = charc;
			strcat(carre, buffer);
			kdx += 1;
		}
	}
}

void coderMessage(char * resultat, char * carre, char * message) {
	char buffer[2];
	int idx = 0;
	for (int i = 0; i < strlen(message); i += 1) {
		idx = 0;
		while (idx < strlen(carre) && message[i] != carre[idx]) {
			idx += 1;
		}
		sprintf(buffer, "%d", idx/LARGEUR + DECALAGE);
		strcat(resultat, buffer);
		
		sprintf(buffer, "%d", idx%LARGEUR + DECALAGE);
		strcat(resultat, buffer);
	}
}

void decoderMessage(char * resultat, char * carre, char * message) {
	char buffer[1];
	for (int i = 0; i < strlen(message); i += 2) {		
		buffer[0] = carre[ ( (message[i] - '0' - DECALAGE) * LARGEUR + (message[i + 1] - '0' - DECALAGE) ) ];
		strcat(resultat, buffer);
	}
}

int main() {
	char * resultat, * carre = malloc(sizeof(char) * 25), * entree = malloc(sizeof(char) * 30);
	
	printf("Entrez la clé ");
	scanf("%s", entree);
	
	initialiserCarreAvecCle(carre, entree);
		
	afficherCarre(carre);
	
	printf("Entrez le message à coder ");
	scanf("%s", entree);
	coderMessage(resultat, carre, entree);
	printf("%s\n", resultat);
	
	RESET(resultat);

	printf("Entrez le message à décoder ");
	scanf("%s", entree);
	decoderMessage(resultat, carre, entree);
	printf("%s\n", resultat);
	
	free(carre);
	free(entree);
}
