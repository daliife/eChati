%--------------------------------------------------------------------------
%
%           ECHATI, el buscador de parelles ideal!
%
%   by Pablo Gonzalez, Dani Reixats, Carlos Quintana i David Gimeno
%--------------------------------------------------------------------------

%INICI DEL PROGRAMA

%Carreguem l'axiu amb totes les dades a tractar de eChati
load eChati.mat
opcio = 1;
norma_min = 10000;

%Descomposicio en valors singulars per facilitar despres el calcul       
%[U,S,V] = svd(double(faces_database));
%Utinici = U(:,1:30);
%Stinici = S(1:30,1:30);
%Vtinici = V(:,1:30);
%Vtranspinici = transpose(Vtinici);
%Arecinici = Utinici * Stinici * Vtranspinici;


while opcio~=5
    
    %Demanem a l'usuari que entri una opcio de les disponibles
    prompt = '\nBENVINGUT A ECHATI\n\n1.Mostrar un usuari de la base de dades i la seva imatge reconstruida.\n2.Mostrar els usuaris que busquen parella.\n3.eChati estandard.\n4.eChati Premium.\n5.Sortir del programa.\n\nSelecciona una opcio (1-5): ';
    opcio = input(prompt);


    switch opcio

        case 1
            %Demanem a l'usuari quin usuari de la base de dades vol mostrar
            prompt = '\nHAS SELECCIONAT LA OPCIO 1:\nEscriu el numero dusuari a mostrar (1-38): ';
            num_usuari_base= input(prompt);

            %Recreem de la matriu faces_database el usuari corresponent en una
            %nova matriu de 100 per 90
            original = reshape(faces_database(:,num_usuari_base),100,90);

            %Demanem a l'usuari el nombre de components que vol agafar per fer
            %la descomposicio en valors singulars
            prompt = 'Escriu el numero de components que vols agafar per fer la descomposicio: '; 
            p = input(prompt);

            %Descomposicio en valors singulars
            [U,S,V] = svd(double(faces_database));
            Ut = U(:,1:p);
            St = S(1:p,1:p);
            Vt = V(:,1:p);
            Vtransp = transpose(Vt);
            Arec = Ut * St * Vtransp;

            %Recreem la matriu recontruida/truncada per la dvs
            reconstruida = reshape(Arec(:,num_usuari_base), 100, 90);

            %Mostrem les dues imatges, original i reconstruida, en una nova
            %finestra

            figure('Name','RESULTAT OPCIO 1','NumberTitle','off');
            subplot(1,2,1), imshow(mat2gray(original));
            subplot(1,2,2), imshow(mat2gray(reconstruida));
            
            
            prompt = 'Clicka ENTER per tornar al menu principal...'; 
            enter = input(prompt);

        case 2

           figure('Name','RESULTAT OPCIO 2','NumberTitle','off');    
           for index = 0:8
                subplot(2,5,index+1), imshow(mat2gray(reshape(faces_users(:,index+1),100,90)));
                subplot(2,5,index+2), imshow(mat2gray(reshape(faces_users(:,(index+2)),100,90)));
           end
           
           prompt = 'Clicka ENTER per tornar al menu principal...'; 
           enter = input(prompt);
            
            
        case 3
            prompt = '\nHAS SELECCIONAT LA OPCIO 3:\nEscriu el numero dusuari que esta cercant parella (1-10): ';
            num_usuari= input(prompt);

            sexe = input('Escriu el sexe de la parella que busca aquest usuari (H/M= masculi // D/F=femeni): ','s');
            
            %Creem una nova variable per despres comprovar el genere al
            %vector boolea gender_database
            if sexe=='H' || sexe=='M' || sexe=='h' || sexe=='m'
                num_sexe=1;
            else
                num_sexe=0;
            end
            
            
            %Comparem un a un el vector de l'usuari seleccionat i tots els
            %usuaris del sexe seleccionat per trobar al mes semblant
            for index_for = 1:19
                if num_sexe == gender_database(index_for)
                    
                    vUsuari = Arecinici(:, index_for);
                    
                    vComparar = 
                                         
                    
                    %Calculem la norma entre el vector original i el de
                    %l'usuari a avaluar (amb la mateixa base!!!)
                    norma=sqrt(dotprod(A(1,:),B(:,1)));
                    
                    %Ens guardem la columne que es troba l'usuari mes
                    %semblant en el cas de que tingui una norma
                    if norma < norma_min 
                        usuari_semblant=index_for;
                    end 
                end
            end
            
            %Mostrem els resultats per pantalla
            figure('Name','RESULTAT OPCIO 3','NumberTitle','off');
            subplot(1,2,1), imshow(mat2gray(original));
            subplot(1,2,2), imshow(mat2gray(reconstruida));

            
            
        case 4
            
        case 5
            opcio = 5;

        otherwise
             prompt = '\n\ERROR! Numero dopcio incorrecta (1-5)\nClicka ENTER per tornar al menu principal...'; 
             enter = input(prompt);
             opcio = 1;
    end
    


        
end


prompt = '\nPrograma finalitzat amb èxit.\nPrem ENTER per acabar...'; 
enter = input(prompt);

%FINALITZACIó DEL PROGRAMA

%--------------------------------------------------------------------------
%                                    algebra 2014
%--------------------------------------------------------------------------










