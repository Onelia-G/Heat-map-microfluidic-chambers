clear all
close all
clc

load A % matrix A contains the sequence of luminescenze images in the time 

chamber1=A(129:256,:,:);  
chamber2=A(1:128,:,:); 

%% CHAMBER 1
chamber=chamber1;

% divide the chamber in ROIs of 8x8 pixel 
% i=rows
% j=columns
% k=time
[r,c,t]=size(chamber(:,:,:));
passo=8;
ch_int_roi=zeros((r/passo)*2-1,(c/passo)*2-1,t); 
b=0; 
for k=1:t 
    d=1; 
for i=1:passo/2:r-passo/2
    for j=1:passo/2:c-passo/2
        roi=chamber(i:i+passo-1,j:j+passo-1,k);
        roi_m=mean(roi,1);
        roi_m=mean(roi_m,2);
        roi_m=squeeze(roi_m);
        b=b+1;
        ch_int_roi(d,b,k)=roi_m;
    end
    b=0;
    d=d+1;
end
end


% horizontal heat map: keep a row fixed and scan the columns
[r,c,t]=size(ch_int_roi(:,:,24:312));
index_riga=15;
index_colonna_below=1;
index_colonna_above=63;%20;
index_tempo_below=24;
index_tempo_above=312;

matrice_heat=zeros(c,t);
matrice_heat_m=zeros(c,t);

for j=index_colonna_below:index_colonna_above
    v_bis=squeeze(ch_int_roi(index_riga,j,index_tempo_below:index_tempo_above));
    media_v_bis=mean(v_bis);
    v_bis_m= v_bis./media_v_bis;
    matrice_heat(j,:)=v_bis;
    matrice_heat_m(j,:)=v_bis_m*media_v_bis;
end

matrice_heat_hor_1=matrice_heat;
matrice_heat_hor_m1=matrice_heat_m;
index_riga_hor1=index_riga;
index_colonna_hor_below1=index_colonna_below;
index_colonna_hor_above1=index_colonna_above;


% vertical heat map: keep a column fixed, and scan the rows
[r,c,t]=size(ch_int_roi(:,:,24:312));
index_colonna=30;
index_riga_below=1;
index_riga_above=31;
index_tempo_below=24;
index_tempo_above=312;

matrice_heat=zeros(r,t);
matrice_heat_m=zeros(r,t);

for i=index_riga_below:index_riga_above
    v_bis=squeeze(ch_int_roi(i,index_colonna,index_tempo_below:index_tempo_above));
    media_v_bis=mean(v_bis);
    v_bis_m= v_bis./media_v_bis;
    matrice_heat(i,:)=v_bis;
    matrice_heat_m(i,:)=v_bis_m*media_v_bis;
end

matrice_heat_vert_1=matrice_heat;
matrice_heat_vert_m1=matrice_heat_m;
index_colonna_vert1=index_riga;
index_riga_vert_below1=index_riga_below;
index_riga_vert_above1=index_riga_above;

% horizontal and vertical heat map
figure()
subplot(2,1,1)
image(matrice_heat_hor_1)
title(['vertical heat map chamber1 24h'])
subplot(2,1,2)
image(matrice_heat_vert_1)
title(['horizontal heat map chamber1 24h'])
colormap('jet')

%% CHAMBER 2
chamber=chamber2; 

% divide the chamber in ROIs of 8x8 pixel 
% i=rows
% j=columns
% k=time
[r,c,t]=size(chamber(:,:,:));
passo=8;
ch_int_roi=zeros((r/passo)*2-1,(c/passo)*2-1,t); 
b=0; 
for k=1:t 
    d=1; 
for i=1:passo/2:r-passo/2
    for j=1:passo/2:c-passo/2
        roi=chamber(i:i+passo-1,j:j+passo-1,k);
        roi_m=mean(roi,1);
        roi_m=mean(roi_m,2);
        roi_m=squeeze(roi_m);
        b=b+1;
        ch_int_roi(d,b,k)=roi_m;
    end
    b=0;
    d=d+1;
end
end


% horizontal heat map: keep a row fixed and scan the columns
[r,c,t]=size(ch_int_roi(:,:,24:312));
index_riga=15;
index_colonna_below=1;
index_colonna_above=63;
index_tempo_below=24;
index_tempo_above=312;

matrice_heat=zeros(c,t);
matrice_heat_m=zeros(c,t);

for j=index_colonna_below:index_colonna_above
    v_bis=squeeze(ch_int_roi(index_riga,j,index_tempo_below:index_tempo_above));
    media_v_bis=mean(v_bis);
    v_bis_m= v_bis./media_v_bis;
    matrice_heat(j,:)=v_bis;
    matrice_heat_m(j,:)=v_bis_m*media_v_bis;
end


matrice_heat_hor_2=matrice_heat;
matrice_heat_hor_m2=matrice_heat_m;
index_riga_hor2=index_riga;
index_colonna_hor_below2=index_colonna_below;
index_colonna_hor_above2=index_colonna_above;



% vertical heat map: keep a column fixed and scan the rows
[r,c,t]=size(ch_int_roi(:,:,24:312));
index_colonna=30;
index_riga_below=1;
index_riga_above=31;
index_tempo_below=24;
index_tempo_above=312;

matrice_heat=zeros(r,t);
matrice_heat_m=zeros(r,t);

for i=index_riga_below:index_riga_above
    v_bis=squeeze(ch_int_roi(i,index_colonna,index_tempo_below:index_tempo_above));
    media_v_bis=mean(v_bis);
    v_bis_m= v_bis./media_v_bis;
    matrice_heat(i,:)=v_bis;
    matrice_heat_m(i,:)=v_bis_m*media_v_bis;
end

matrice_heat_vert_2=matrice_heat;
matrice_heat_vert_m2=matrice_heat_m;
index_colonna_vert2=index_riga;
index_riga_vert_below2=index_riga_below;
index_riga_vert_above2=index_riga_above;

% horizontal and vertical heat mapfigure()
figure()
subplot(2,1,1)
image(matrice_heat_hor_2)
title(['vertical heat map chamber2 1h'])
subplot(2,1,2)
image(matrice_heat_vert_2)
title(['horizontal heat map chamber2 1h'])
colormap('jet')

