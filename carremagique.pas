{
ALGORITHME carremagique

BUT  Faire un carré magique fonctionnant pour un tableau de dimensions 5*5 et 7*7
ENTREE Rien
SORTIE Un carré magique

CONST
	MAX=7;

TYPE
	tableau2dim = TABLEAU[1..MAX,1..MAX] DE ENTIER;
	position = TABLEAU[1..2] DE ENTIER;

//On initialise le tableau
	
PROCEDURE initTableau(var tableau, caseActuelle : tableau2dim) : tableau2dim

VAR
	i,j : ENTIER;

DEBUT
	//La valeur de chaque case devient 0
	POUR i DE 1 A MAX
	FAIRE
		POUR j DE 1 A MAX
		FAIRE
			tableau[i,j]<-0;
		FINPOUR
	FINPOUR
	//La valeur au milieu en haut devient 1
	tableau[MAX DIV 2][MAX DIV 2 + 1]<-1;
	
	//On initialise les valeurs des coordonnées ou se trouve la case 1
	caseActuelle[1]<-MAX DIV 2;
	caseActuelle[2]<-MAX DIV 2 + 1;
FIN

//On affiche le tableau
PROCEDURE afficherTableau(tableau: tableau2dim)

VAR
	i,j : ENTIER

DEBUT
		POUR i DE 1 A MAX 
		FAIRE
			POUR j DE 1 A MAX
			FAIRE
				//Si la valeur est inférieure à 10, on met un 0 avant (ex : 3 -> 03)
				SI tableau[i][j]<10 ALORS
					ECRIRE(0, tableau[i][j], ' ');
				SINON
					ECRIRE(tableau[i][j], ' ');
				FINSI
			FINPOUR
			writeln();
		FIN
FIN

//On gère les déplacements
PROCEDURE deplacement(var tableau, caseActuelle, direction)

DEBUT
	//On change les coordonnées en fonction de la direction choisie
	CAS direction PARMI
		'nord' : 
			DEBUT
				caseActuelle[1]<-caseActuelle[1]-1
			FIN
		'est' : 
			DEBUT
				caseActuelle[2]<-caseActuelle[2]+1
			FIN
		'ouest' : 
			DEBUT
				caseActuelle[2]<-caseActuelle[2]-1
			FIN
	FINCASPARMI
	
	
	//Si la valeur de la coordonnée est inférieure à 1, elle devient le maximum et inversement
	SI caseActuelle[1]>MAX ALORS
	DEBUT
		caseActuelle[1]<-1
	FIN
	SI caseActuelle[1]<1 ALORS
	DEBUT
		caseActuelle[1]<-MAX
	FIN
	
	SI caseActuelle[2]>MAX ALORS
	DEBUT
		caseActuelle[2]<-1
	FIN
	SI caseActuelle[2]<1 ALORS
	DEBUT
		caseActuelle[2]<-MAX
	FIN

	deplacement<-caseActuelle
FIN

//On place toutes les valeurs dans chaque case
FONTION placement(var tableau, caseActuelle : tableau2dim) : tableau2dim

VAR
	i,j : ENTIER;
	
DEBUT
	POUR i DE 1 A MAX*MAX FAIRE
		//On se déplace au nord est
		caseActuelle<-deplacement(tableau, caseActuelle, 'nord');
		caseActuelle<-deplacement(tableau, caseActuelle, 'est');
	
		//On se déplace au nord-ouest si la case d'arrivée n'est pas égale à 0
		POUR tableau[caseActuelle[1]][caseActuelle[2]] <> 0 FAIRE
		DEBUT
			caseActuelle<-deplacement(tableau, caseActuelle, 'nord');
			caseActuelle<-deplacement(tableau, caseActuelle, 'ouest');
		FIN	
		
		//On assigne la bonne valeur à la case où on se retrouve
		tableau[caseActuelle[1]][caseActuelle[2]]<-i;		
	FINPOUR
FIN

//Le core du programme
VAR 
	tableau: tableau2dim;
	caseActuelle: position;
DEBUT
	initTableau(tableau, caseActuelle);  //On initialise le tableau
	placement(tableau, caseActuelle);    //On place toutes les valeurs dans chaque case

	
	afficherTableau(tableau);            //On affiche le tableau
FIN
}


program carremagique;

uses crt;

CONST
	MAX=7;


TYPE
	tableau2dim = array[1..MAX,1..MAX] of integer;
	position = array[1..2] of integer;

//On initialise le tableau
PROCEDURE initTableau(var tableau: tableau2dim; var caseActuelle: position);

VAR
	i,j : integer;

BEGIN
	//La valeur de chaque case devient 0
	for i:=1 to MAX do
	BEGIN
		FOR j:=1 to MAX do
		BEGIN
			tableau[i][j]:=0;
		END;
	END;
	//La valeur au milieu en haut devient 1
	tableau[MAX DIV 2][MAX DIV 2 + 1]:=1;
	
	//On initialise les valeurs des coordonnées ou se trouve la case 1
	caseActuelle[1]:=MAX DIV 2;
	caseActuelle[2]:=MAX DIV 2 + 1;
END;

//On affiche le tableau
PROCEDURE afficherTableau(tableau: tableau2dim);

VAR
	i,j : integer;

BEGIN
		for i:=1 to MAX do
		BEGIN
			FOR j:=1 to MAX do
			BEGIN
				//Si la valeur est inférieure à 10, on met un 0 avant (ex : 3 -> 03)
				if tableau[i][j]<10 then
				BEGIN
					write(0, tableau[i][j], ' ');
				END
				else
				BEGIN
					write(tableau[i][j], ' ');
				END;
			END;
			writeln();
		END;
END;

//On gère les déplacements
FUNCTION deplacement(caseActuelle : position; direction : string) : position;

BEGIN
	//On change les coordonnées en fonction de la direction choisie
	CASE direction OF
		'nord' : 
			BEGIN
				caseActuelle[1]:=caseActuelle[1]-1;
			END;
		'est' : 
			BEGIN
				caseActuelle[2]:=caseActuelle[2]+1;
			END;
		'ouest' : 
			BEGIN
				caseActuelle[2]:=caseActuelle[2]-1;
			END;
	END;
	
	//Si la valeur de la coordonnée est inférieure à 1, elle devient le maximum et inversement
	if caseActuelle[1]>MAX then
	BEGIN
		caseActuelle[1]:=1
	END;
	if caseActuelle[1]<1 then
	BEGIN
		caseActuelle[1]:=MAX
	END;
	
	if caseActuelle[2]>MAX then
	BEGIN
		caseActuelle[2]:=1;
	END;
	if caseActuelle[2]<1 then
	BEGIN
		caseActuelle[2]:=MAX
	END;

	deplacement:=caseActuelle;
END;

//On place toutes les valeurs dans chaque case
PROCEDURE placement(var tableau : tableau2dim; caseActuelle : position);

VAR
	i,j : integer;
	
BEGIN
	FOR i:=2 to MAX*MAX do
	BEGIN
		//On se déplace au nord est
		caseActuelle:=deplacement(caseActuelle, 'nord');
		caseActuelle:=deplacement(caseActuelle, 'est');

		//On se déplace au nord-ouest si la case d'arrivée n'est pas égale à 0
		WHILE tableau[caseActuelle[1]][caseActuelle[2]] <> 0 do
		BEGIN
			caseActuelle:=deplacement(caseActuelle, 'nord');
			caseActuelle:=deplacement(caseActuelle, 'ouest');
		END;
		
		//On assigne la bonne valeur à la case où on se retrouve
		tableau[caseActuelle[1]][caseActuelle[2]]:=i;
	END;
END;

//Le core du programme
VAR
	tableau : tableau2dim;
	caseActuelle: position;

BEGIN
	clrscr;

	initTableau(tableau, caseActuelle); //On initialise le tableau
	placement(tableau, caseActuelle);   //On place toutes les valeurs dans chaque case
	
	afficherTableau(tableau);           //On affiche le tableau
	readln();
END.