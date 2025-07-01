% viikko2  projekti

% luetaan kuva

im_orig = imread('original_irma.jpg');

% poistettava alue:

inpx = 40; % start x
inpy = 45; % start y
row  = 120; % poistettavan palan koko y-suunta
col  = 90; % poistettavan palan koko x-suunta

% kutsu funktio joka tekee poistettavalle palalle
% matriisin keskiarvoperiaatteella

A = FD_Laplace(row,col)

im_result = im_orig;

% loop joka tekee värinpoiston kanaville järjestyksessä:
% 1 = punainen 2 = vihreä 3 = sininen
for ch = 1:3  
    % ota väripikselit poistettavan alueen ympäriltä
    % valitaan värikanavaksi ch:n arvo
    vec_t = double(im_orig(inpy,inpx+(1:col), ch));
    vec_b = double(im_orig(inpy+row+1,inpx+(1:col), ch));
    vec_l= double(im_orig(inpy+(1:row),inpx,ch));
    vec_r=double(im_orig(inpy+(1:row),inpx+col+1,ch));

    % luo oikeanpuoleinen vektori b käyttäen poistettavan 
    % kuvapalan reunavektoreita 
    b = zeros(row * col, 1);
    for iii = 1:row
        for jjj = 1:col
            ind = (jjj-1)*row + iii;
            if iii == 1
                b(ind) = b(ind) + vec_t(jjj);
            end
            if iii == row
                b(ind) = b(ind) + vec_b(jjj);
            end
            if jjj == 1
                b(ind) = b(ind) + vec_l(iii);
            end
            if jjj == col
                b(ind) = b(ind) + vec_r(iii);
            end
        end
    end

    % ratkaise vektori Psol
    Psol = A \ b;

    % laitetaan oikeaan kokoon
    Psol = reshape(Psol, row, col);

    % muutetaan väriskaala
    Psol = min(max(Psol, 0), 255);  

    % korvaa uudet ratkaistut pikselit alkuperäiseen kuvaan
    im_result(inpy+(1:row), inpx+(1:col), ch) = uint8(Psol);

    % näytä ensimmäisen (punaisen) kanavan poisto erikseen
    if ch == 1
    figure(1)
    imshow(im_result);
    imwrite(im_result,'inpainted_one_channel_irma.jpg')
    end
end

% näytä lopullinen kuva josta poistettu kaikki värikanavat
figure(2)
imshow(im_result);
imwrite(im_result,'inpainted_all_channels_irma.jpg')



           