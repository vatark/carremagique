#include <stdio.h>
#include <stdlib.h>

//On crée la structure position
struct position
{
  int x;
  int y;
};

typedef struct position position;

//On affihe le carré magique
void afficherTableau(int **Tableau, int taille)
{
  int i, j;

  for (i = 0; i < taille; i++) {
    for (j = 0; j < taille; j++) {
       printf("% 5d", Tableau[j][i]);
    }
    printf("\n");
  }
}

//On génère le carré magique
void placement(int **Tableau, int taille)
{
  int i, bonneCase = 0;
  position coordonnees;

  //On place le nombre 1 dans le tableau
  coordonnees.x = taille/2;
  coordonnees.y = taille/2-1;

  Tableau[coordonnees.x][coordonnees.y] = 1;

  //On place les autres nombres
  for (i = 2; i < taille*taille+1; i++) {
    //On va au nord-est du nombre précédant
    coordonnees.x = coordonnees.x+1;
    coordonnees.y = coordonnees.y-1;

    if(coordonnees.x >= taille) {
      coordonnees.x = 0;
    }
    if (coordonnees.y < 0) {
      coordonnees.y = taille-1;
    }

    //Si il y a déjà un nombre on va au nord-ouest
    if (Tableau[coordonnees.x][coordonnees.y]) {  
      coordonnees.x = (coordonnees.x-1);
      coordonnees.y = (coordonnees.y-1);
      
      if(coordonnees.x < 0) {
	coordonnees.x = taille-1;
      }
      if (coordonnees.y < 0) {
	coordonnees.y = taille-1;
      }
      
    }

    //On place le nombre
    Tableau[coordonnees.x][coordonnees.y] = i;
  }
}

int main()
{
  int i, tailleTableau, **tableau, paire = 0;

  //Taille du tablau
  do {
    printf("Donnez la taille de votre tableau (un nombre impair supérieur à 1) : ");
    scanf("%d", &tailleTableau);
    printf("\n");
    if (tailleTableau%2 != 0 && tailleTableau > 1) {
      paire = 1;
    }
  } while (!paire);

  //Allocation de la mémoire pour le tableau contenant le carré magique
  tableau = (int**)malloc(sizeof(int*) * tailleTableau);
  for (i = 0; i < tailleTableau; i++) {
    tableau[i] = (int*)calloc(tailleTableau, sizeof(int));
  }

  //Placement des nombres dans le tableau
  placement(tableau, tailleTableau);

  //Affichage du tableau
  afficherTableau(tableau, tailleTableau);

  //Libération de la mémoire
  for (i = 0; i < tailleTableau; i++) {
    free(tableau[i]);
  }

  free(tableau);
  
  return 0;
}
