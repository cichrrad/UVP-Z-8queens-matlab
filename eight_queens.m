function solutions = osm_dam_graf()
    
    %Inicializace herni desky - 8x8 
    plocha = zeros(8, 8);
    %Inicialiace pocitadla a reseni
    count = 0;
    solutions = {};
    
    %Pokladani damy do prvniho sloupce
    poloz_damu(plocha, 1);
    
    function poloz_damu(plocha, col)
        
        %podminka nalezeni reseni - pokud mam polozit do 9. sloupce
        %(=mimo herni plochu) -> reseni nalezeno
        if col == 9
            %Ulozeni reseni do pole solutions
            count = count +1;
            solutions{count} = plocha;
            return;
        end
        
        %Pokladani dam na kazdou radku v danem sloupci
        for row = 1:8
            %Jedna se o legalni krok
            if je_validni(plocha, row, col)
                %Polozim damu
                plocha(row, col) = 1;
                
                %Rekurzivne se posouvam ve sloupcich doprava
                poloz_damu(plocha, col+1);
                
                %Kdyz tahle cesta nevysla -> zvednu damu
                plocha(row, col) = 0;
            end
        end
    end

    %Kontrola, jestli je dane pole ohrozene
    %staci kontrolovat pole doprava(+doprava diag.) od aktualniho mista
    function valid = je_validni(plocha, row, col)
        %defaultne neni ohrozene
        valid = true;
        
        %Pokud na danem radku najdu damu vpravo -> ohrozene
        if any(plocha(row,:))
            valid = false;
            return;
        end
        
        %Sloupce
        if any(plocha(:,col))
            valid = false;
            return;
        end
        
        %Diagonala
        i = row - 1;
        j = col - 1;
        while i >= 1 && j >= 1
            if plocha(i, j)
                valid = false;
                return;
            end
            i = i - 1;
            j = j - 1;
        end
        
        i = row + 1;
        j = col + 1;
        while i <= 8 && j <= 8
            if plocha(i, j)
                valid = false;
                return;
            end
            i = i + 1;
            j = j + 1;
        end
        
        %Diagonala 2
        i = row - 1;
        j = col + 1;
        while i >= 1 && j <= 8
            if plocha(i, j)
                valid = false;
                return;
            end
            i = i - 1;
            j = j + 1;
        end
        
        i = row + 1;
        j = col - 1;
        while i <= 8 && j >= 1
            if plocha(i, j)
                valid = false;
                return;
            end
            i = i + 1;
            j = j - 1;
        end
    end
end
