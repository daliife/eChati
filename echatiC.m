%--------------------------------------------------------------------------
%
%           ECHATI, el buscador de parelles ideal!
%
%   by Pablo Gonzalez, Dani Reixats, Carlos Quintana i David Gimeno
%--------------------------------------------------------------------------

%INICI DEL PROGRAMA

%Fixem una p inicial
p = 30;

%Inicialització de variables
opcio = 1;
norma_min = 99999999999999;


semblant1 = 0;
coeficient1 = -999999;
semblant2 = 0;
coeficient2 = -999999;
semblant3 = 0;
coeficient3 = -9999999;


while opcio~=6
    
    %Demanem a l'usuari que entri una opcio de les disponibles
    prompt = '\nBENVINGUT A ECHATI\n\n1.Carregar dades\n2.Mostrar un usuari de la base de dades i la seva imatge reconstruida.\n3.Mostrar els usuaris que busquen parella.\n4.eChati estandard.\n5.eChati Premium.\n6.Sortir del programa.\n\nSelecciona una opcio (1-6): ';
    opcio = input(prompt);


    switch opcio
        
        case 1
            load eChati.mat;
            [U,S,V] = svd(double(faces_database));
            Ut = U(:,1:p);
            matriuCanviBase = transpose(Ut);
            St = S(1:p,1:p);
            Vt = V(:,1:p);
            Vtransp = transpose(Vt);
            Arec = Ut * St * Vtransp;
            
            ArecTruncada = Arec(1:p, :);
            
            
                        

            %Trunquem matrius en valors singulars
            Utrunc10 = U(:,1:10);
            Strunc10 = S(1:10, 1:10);
            Vttrunc10 = Vt(:,1:10);
            Vtrunctransp10 = transpose(Vttrunc10);
            
            Arec10 = Utrunc10 * Strunc10 * Vtrunctransp10;
            
            Utrunc20 = U(:,1:20);
            Strunc20 = S(1:20, 1:20);
            Vttrunc20 = Vt(:,1:20);
            Vtrunctransp20 = transpose(Vttrunc20);
            Arec20 = Utrunc20 * Strunc20 * Vtrunctransp20;
            
            Utrunc30 = U(:,1:30);
            Strunc30 = S(1:30, 1:30);
            Vttrunc30 = Vt(:,1:30);
            Vtrunctransp30 = transpose(Vttrunc30);
            Arec30 = Utrunc30 * Strunc30 * Vtrunctransp30;
            

            
            
    

        case 2
            %Demanem a l'usuari quin usuari de la base de dades vol mostrar
            prompt = '\nHAS SELECCIONAT LA OPCIO 1:\nEscriu el numero dusuari a mostrar (1-38): ';
            num_usuari_base = input(prompt);

            %Recreem de la matriu faces_database el usuari corresponent en una
            %nova matriu de 100 per 90
            original = reshape(faces_database(:,num_usuari_base),100,90);
           
            
            %Recreem la matriu recontruida/truncada per la dvs
            reconstruida10 = reshape(Arec10(:,num_usuari_base), 100, 90);
            reconstruida20 = reshape(Arec20(:,num_usuari_base), 100, 90);
            reconstruida30 = reshape(Arec30(:,num_usuari_base), 100, 90);
            %Mostrem les dues imatges, original i reconstruida, en una nova
            %finestra

            figure('Name','RESULTAT OPCIO 2','NumberTitle','off');
            subplot(3,2,3), imshow(mat2gray(original));
            title('Imatge original');
            subplot(3,2,2), imshow(mat2gray(reconstruida10));
            title('10 components');
            subplot(3,2,4), imshow(mat2gray(reconstruida20));
            title('20 components');
            subplot(3,2,6), imshow(mat2gray(reconstruida30));
            title('30 components');
            
            prompt = 'Clicka ENTER per tornar al menu principal...'; 
            enter = input(prompt);
            
            

        case 3

           figure('Name','RESULTAT OPCIO 3','NumberTitle','off');    
           for index = 0:8
                subplot(2,5,index+1),imshow(mat2gray(reshape(faces_users(:,index+1),100,90)));
                subplot(2,5,index+2), imshow(mat2gray(reshape(faces_users(:,(index+2)),100,90)));
           end
           
           prompt = 'Clicka ENTER per tornar al menu principal...'; 
           enter = input(prompt);
            
            
        case 4
            prompt = '\nHAS SELECCIONAT LA OPCIO 4:\nEscriu el numero dusuari que esta cercant parella (1-10): ';
            num_usuari= input(prompt);

            sexe = input('Escriu el sexe de la parella que busca aquest usuari (H/M= masculi // D/F=femeni): ','s');
            
            %Creem una nova variable per despres comprovar el genere al
            %vector boolea gender_database
            if sexe=='H' || sexe=='M' || sexe=='h' || sexe=='m'
                num_sexe=1;
            else
                num_sexe=0;
            end
            
            matriuUsuari = faces_users(:,num_usuari);
            
            % Cal fer el im2double perque si no fa un KABOOOOOOOOM precios,
            % al no poder multiplicar dues matrius de uint8
            usuariEnNovaBase = im2double(matriuCanviBase)*im2double(matriuUsuari);
            
            usuariEnNovaBaseTranspost = transpose(usuariEnNovaBase);
            
            %Comparem un a un el vector de l'usuari seleccionat i tots els
            %usuaris del sexe seleccionat per trobar al mes semblant
            for index_for = 1:38
                if num_sexe == gender_database(index_for)
                    
                    %vUsuari = Arecinici(:, index_for);
                    
                    %vComparar = 
                    
                    usuariAComparar = ArecTruncada(:,index_for);
                    
                    
                    
                    %Calculem la norma entre el vector original i el de
                    %l'usuari a avaluar (amb la mateixa base!!!)
                    
                    %norma=(dotprod(usuariEnNovaBaseTranspost, usuariAComparar))
                    norma = norm(usuariEnNovaBase - usuariAComparar);
                    
                    %Ens guardem la columne que es troba l'usuari mes
                    %semblant en el cas de que tingui una norma
                    if norma < norma_min 
                        usuari_semblant=index_for;
                        norma_min = norma;
                    end 
                end
            end
            
            reconstruida = faces_database(:, usuari_semblant);
            
            %Mostrem els resultats per pantalla
            figure('Name','RESULTAT OPCIO 4','NumberTitle','off');
            subplot(1,2,1), imshow(mat2gray(reshape(matriuUsuari, 100, 90)));
            title(['Usuari numero ',num2str(num_usuari)]);
            subplot(1,2,2), imshow(mat2gray(reshape(reconstruida, 100, 90)));
            title('Millor resultat trobat');
            
            norma_min = 99999999999;

            
            
        case 5
            
            
            
            prompt = '\n****************************\n****** PREMIUM OPTION ******\n****************************\nHAS SELECCIONAT LA OPCIO 5:\nEscriu el numero dusuari que esta cercant parella (1-10): ';
            num_usuari= input(prompt);

            sexe = input('Escriu el sexe de la parella que busca aquest usuari (H/M= masculi // D/F=femeni): ','s');
            
            %Creem una nova variable per despres comprovar el genere al
            %vector boolea gender_database
            if sexe=='H' || sexe=='M' || sexe=='h' || sexe=='m'
                num_sexe=1;
            else
                num_sexe=0;
            end
            
            matriuUsuari = faces_users(:,num_usuari);
            
            % Cal fer el im2double perque si no fa un KABOOOOOOOOM precios,
            % al no poder multiplicar dues matrius de uint8
            usuariEnNovaBase = im2double(matriuCanviBase)*im2double(matriuUsuari);
            
            biometricsUsuariABuscar = biometrics_users(:,num_usuari);
            
            usuariEnNovaBaseTranspost = transpose(usuariEnNovaBase);
            
            %Comparem un a un el vector de l'usuari seleccionat i tots els
            %usuaris del sexe seleccionat per trobar al mes semblant
            for index_for = 1:38
                if num_sexe == gender_database(index_for)
                    
                    %vUsuari = Arecinici(:, index_for);
                    
                    %vComparar = 
                    
                    usuariAComparar = ArecTruncada(:,index_for);
                    
                    
                    
                    %Calculem la norma entre el vector original i el de
                    %l'usuari a avaluar (amb la mateixa base!!!)
                    normaNormal=dotprod(usuariEnNovaBaseTranspost, usuariAComparar);
                    
                    
                    
                    biometricsFor = biometrics_database(:,index_for);
                    
                    normaBiometrica = norm(biometricsUsuariABuscar - biometricsFor);
                    
                    coeficient = normaNormal + normaBiometrica;
                    
                    if(coeficient > coeficient3)
                        if(coeficient > coeficient2)
                           if(coeficient > coeficient1)
                               coeficient1 = coeficient;
                               semblant1 = index_for;
                           else
                               coeficient2 = coeficient;
                               semblant2 = index_for;
                           end
                        else
                            coeficient3 = coeficient;
                            semblant3 = index_for;
                        end
                    end
                end
            end
            
            reconstruida1 = faces_database(:, semblant1);
            reconstruida2 = faces_database(:, semblant2);
            reconstruida3 = faces_database(:, semblant3);
            
            %Mostrem els resultats per pantalla
            figure('Name','RESULTAT OPCIO 5','NumberTitle','off');
            subplot(3,2,3), imshow(mat2gray(reshape(matriuUsuari, 100, 90)));
            title(['Usuari numero ',num2str(num_usuari)]);
            
            subplot(3,2,2), imshow(mat2gray(reshape(reconstruida1, 100, 90)));
            title('Millor resultat trobat');
            subplot(3,2,4), imshow(mat2gray(reshape(reconstruida2, 100, 90)));
            subplot(3,2,6), imshow(mat2gray(reshape(reconstruida3, 100, 90)));
            
            
        case 6
            opcio = 6;

        otherwise
             prompt = '\n\ERROR! Numero dopcio incorrecta (1-6)\nClicka ENTER per tornar al menu principal...'; 
             enter = input(prompt);
             opcio = 1;
    end
    


        
end


prompt = '\nPrograma finalitzat amb ?xit.\nPrem ENTER per acabar...'; 
enter = input(prompt);

%FINALITZACIÓ DEL PROGRAMA

%--------------------------------------------------------------------------
%                                    Algebra 2014
%--------------------------------------------------------------------------