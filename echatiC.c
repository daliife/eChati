#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void main(){

	opcio=0;

	//carreguem dades de l'arxiu proporcionat
	load ('eChati.h');

	prompt = 'BENVINGUT A eCHATI!\n1.Mostrar un usuari de la base de dades i la seva imatge reconstruida.\n2.\nSelecciona una opcio (1-5): ';
	result = input(prompt)


	while(opcio!=5){

		if (!isempty(opcio)){
			switch(opcio){
				case 1:
					prompt = '\nEscriu el numero de usuari que vols mostrar';
					num_usuari = input(prompt);
					original = reshape(faces_database(:,num_usuari),100,90);
					

					prompt = '\nEscriu el numero de components que vols que tingui la imatge reconstruida';
					p = input(prompt);

					//Descomposicio valors singulars
					[U,S,V] = svd(double(faces_database));
					Ut = U(:,1:p);
					St = S(1:p,1:p);
					Vt = V(:,1:p);

					//Transposem la matriu V
					Vtransp = transpose(Vt);

					//Formem la nova matriu truncada
					Arec = Ut * St * Vtransp;

					//Redimensionem i mostrem per pantalla l'usuari corresponent.
					reconstruida = reshape(Arec(:,num_usuari), 100, 90);
					subplot(1,2,1), imshow(mat2gray(original));
					subplot(1,2,2), imshow(mat2gray(reconstruida));

				case 2:

				case 3:

				case 4:

				case 5:
			}
		}else{
			prompt= '\nERROR: Escriu una opcio correcta (1-5).\n';
		}

		

	}











}

