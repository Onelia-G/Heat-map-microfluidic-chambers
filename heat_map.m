clear all
close all
clc

load A
load A_out

% img=imread('im0000.tif');
% imagesc(img)
chamber1=A(129:256,:,:);
chamber2=A(1:128,:,:);
%chamber2=A(53:100,41:200,:);
chamber1_out=A_out(129:256,:,:);
chamber2_out=A_out(1:128,:,:);
% figure()
% image(chamber2(:,:,1))

%% CAMERA 1
% media di tutta la camera 
chamber=chamber1;
media_tot_ch=mean(chamber,1);
media_tot_ch=mean(media_tot_ch,2);
media_tot_ch=squeeze(media_tot_ch);
%media_tot_ch=media_tot_ch.*3;
figure()
plot(media_tot_ch)
hold on

% media di tutta la camera con outlier
chamber_out=chamber2_out;
media_tot_ch_out=mean(chamber_out,1);
media_tot_ch_out=mean(media_tot_ch_out,2);
media_tot_ch_out=squeeze(media_tot_ch_out);
plot(media_tot_ch_out,'r')
legend('clean','outlier')
hold off

% divido l'mmagine in tante ROI
% i=righe
% j=colonne
% k=time
[r,c,t]=size(chamber(:,:,:));
passo=8;
ch_int_roi=zeros(r/passo,c/passo,t); % conterr? le intesit? medie di ogni ROI
b=0; % indice colonna matrice ch_int_roi
for k=1:t 
    d=1; % indice colonna matrice ch_int_roi
for i=1:passo:r
    for j=1:passo:c
        roi=chamber(i:i+passo-1,j:j+passo-1,k);
        roi_m=mean(roi,1);
        roi_m=mean(roi_m,2);
        roi_m=squeeze(roi_m);
        %avg_roi=mean(mean(roi));
        % chamber_roi_int(i,j,k)=avg_roi; 
        b=b+1;
        ch_int_roi(d,b,k)=roi_m;
    end
    b=0;
    d=d+1;
end
end

figure()
plot(media_tot_ch,'r')
title('mean bioluminescence chamber2 1h')


% heat map orizzontale: fisso una riga, scorro le colonne
[r,c,t]=size(ch_int_roi(:,:,24:312));
index_riga=6;
index_colonna_below=1;
index_colonna_above=32;%20;
index_tempo_below=24;
index_tempo_above=312;

matrice_heat=zeros(c,t);
matrice_heat_m=zeros(c,t);

for j=index_colonna_below:index_colonna_above
    v_bis=squeeze(ch_int_roi(index_riga,j,index_tempo_below:index_tempo_above));
    media_v_bis=mean(v_bis);
    v_bis_m= v_bis./media_v_bis;
%     int=uint8(v_bis);
%     int_m=uint8(v_bis_m);
    matrice_heat(j,:)=v_bis;
    matrice_heat_m(j,:)=v_bis_m*media_v_bis;
end

matrice_heat_hor_1=matrice_heat;
matrice_heat_hor_m1=matrice_heat_m;
index_riga_hor1=index_riga;
index_colonna_hor_below1=index_colonna_below;
index_colonna_hor_above1=index_colonna_above;

figure()
subplot(2,1,1)
image(matrice_heat_hor_1)
title(['heat map: riga ',int2str(index_riga_hor1), ', colonne ' int2str(index_colonna_hor_above1), ' to ',  int2str(index_colonna_hor_below1), ' chamber1 24h'])
subplot(2,1,2)
image(matrice_heat_hor_m1)
title(['heat map /*media: riga ',int2str(index_riga_hor1), ', colonne ' int2str(index_colonna_hor_above1), ' to ',  int2str(index_colonna_hor_below1), ' chamber1 24h'])


figure()
imagesc(matrice_heat_hor_1, [20 50])
title('prova imagesc')

% heat map verticale: fisso una colonna, scorro le righe
[r,c,t]=size(ch_int_roi(:,:,24:312));
index_colonna=10;
index_riga_below=1;
index_riga_above=16;
index_tempo_below=24;
index_tempo_above=312;

matrice_heat=zeros(r,t);
matrice_heat_m=zeros(r,t);

for i=index_riga_below:index_riga_above
    v_bis=squeeze(ch_int_roi(i,index_colonna,index_tempo_below:index_tempo_above));
    media_v_bis=mean(v_bis);
    v_bis_m= v_bis./media_v_bis;
%     int=uint8(v_bis);
%     int_m=uint8(v_bis_m);
    matrice_heat(i,:)=v_bis;
    matrice_heat_m(i,:)=v_bis_m*media_v_bis;
end


matrice_heat_vert_1=matrice_heat;
matrice_heat_vert_m1=matrice_heat_m;
index_colonna_vert1=index_riga;
index_riga_vert_below1=index_riga_below;
index_riga_vert_above1=index_riga_above;


figure()
subplot(2,1,1)
image(matrice_heat_vert_1)
title(['heat map: colonna ',int2str(index_colonna_vert1), ', righe ' int2str(index_riga_vert_above1), ' to ',  int2str(index_riga_vert_below1), ' chamber1 24h'])
subplot(2,1,2)
image(matrice_heat_vert_m1)
title(['heat map /* media: colonna ',int2str(index_colonna_vert1), ', righe ', int2str(index_riga_vert_above1), ' to ',  int2str(index_riga_vert_below1), ' chamber1 24h'])
% COMPARE horizontal vertical
figure()
subplot(2,1,1)
image(matrice_heat_hor_1)
title(['heat map: riga ',int2str(index_riga), ', colonne ' int2str(index_colonna_above), ' to ',  int2str(index_colonna_below), ' chamber1 24h'])
subplot(2,1,2)
image(matrice_heat_vert_1)
title(['heat map: colonna ',int2str(index_colonna), ', righe ' int2str(index_riga_above), ' to ',  int2str(index_riga_below), ' chamber1 24h'])


%% CAMERA 2
% media di tutta la camera 
chamber=chamber2;
media_tot_ch=mean(chamber,1);
media_tot_ch=mean(media_tot_ch,2);
media_tot_ch=squeeze(media_tot_ch);
%media_tot_ch=media_tot_ch.*3;
figure()
plot(media_tot_ch)
hold on

% media di tutta la camera con outlier
chamber_out=chamber2_out;
media_tot_ch_out=mean(chamber_out,1);
media_tot_ch_out=mean(media_tot_ch_out,2);
media_tot_ch_out=squeeze(media_tot_ch_out);
plot(media_tot_ch_out,'r')
legend('clean','outlier')
hold off

% divido l'mmagine in tante ROI
% i=righe
% j=colonne
% k=time
[r,c,t]=size(chamber(:,:,:));
passo=8;
ch_int_roi=zeros(r/passo,c/passo,t); % conterr? le intesit? medie di ogni ROI
b=0; % indice colonna matrice ch_int_roi
for k=1:t 
    d=1; % indice colonna matrice ch_int_roi
for i=1:passo:r
    for j=1:passo:c
        roi=chamber(i:i+passo-1,j:j+passo-1,k);
        roi_m=mean(roi,1);
        roi_m=mean(roi_m,2);
        roi_m=squeeze(roi_m);
        %avg_roi=mean(mean(roi));
        % chamber_roi_int(i,j,k)=avg_roi; 
        b=b+1;
        ch_int_roi(d,b,k)=roi_m;
    end
    b=0;
    d=d+1;
end
end

figure()
plot(media_tot_ch,'r')
title('mean bioluminescence chamber2 1h')


% heat map orizzontale: fisso una riga, scorro le colonne
[r,c,t]=size(ch_int_roi(:,:,24:312));
index_riga=6;
index_colonna_below=1;
index_colonna_above=32;
index_tempo_below=24;
index_tempo_above=312;

matrice_heat=zeros(c,t);
matrice_heat_m=zeros(c,t);

for j=index_colonna_below:index_colonna_above
    v_bis=squeeze(ch_int_roi(index_riga,j,index_tempo_below:index_tempo_above));
    media_v_bis=mean(v_bis);
    v_bis_m= v_bis./media_v_bis;
%     int=uint8(v_bis);
%     int_m=uint8(v_bis_m);
    matrice_heat(j,:)=v_bis;
    matrice_heat_m(j,:)=v_bis_m*media_v_bis;
end


matrice_heat_hor_2=matrice_heat;
matrice_heat_hor_m2=matrice_heat_m;
index_riga_hor2=index_riga;
index_colonna_hor_below2=index_colonna_below;
index_colonna_hor_above2=index_colonna_above;

figure()
subplot(2,1,1)
image(matrice_heat_hor_2)
title(['heat map: riga ',int2str(index_riga_hor2), ', colonne ' int2str(index_colonna_hor_above2), ' to ',  int2str(index_colonna_hor_below2), ' chamber2 1h'])
subplot(2,1,2)
image(matrice_heat_hor_m2)
title(['heat map /*media: riga ',int2str(index_riga_hor2), ', colonne ' int2str(index_colonna_hor_above2), ' to ',  int2str(index_colonna_hor_below2), ' chamber2 1h'])


% heat map verticale: fisso una colonna, scorro le righe
[r,c,t]=size(ch_int_roi(:,:,24:312));
index_colonna=10;
index_riga_below=1;
index_riga_above=16;
index_tempo_below=24;
index_tempo_above=312;

matrice_heat=zeros(r,t);
matrice_heat_m=zeros(r,t);

for i=index_riga_below:index_riga_above
    v_bis=squeeze(ch_int_roi(i,index_colonna,index_tempo_below:index_tempo_above));
    media_v_bis=mean(v_bis);
    v_bis_m= v_bis./media_v_bis;
%     int=uint8(v_bis);
%     int_m=uint8(v_bis_m);
    matrice_heat(i,:)=v_bis;
    matrice_heat_m(i,:)=v_bis_m*media_v_bis;
end

matrice_heat_vert_2=matrice_heat;
matrice_heat_vert_m2=matrice_heat_m;
index_colonna_vert2=index_riga;
index_riga_vert_below2=index_riga_below;
index_riga_vert_above2=index_riga_above;

figure()
subplot(2,1,1)
image(matrice_heat_vert_2)
title(['heat map: colonna ',int2str(index_colonna_vert2), ', righe ' int2str(index_riga_vert_above2), ' to ',  int2str(index_riga_vert_below2), ' chamber2 1h'])
subplot(2,1,2)
image(matrice_heat_vert_m2)
title(['heat map /* media: colonna ',int2str(index_colonna_vert2), ', righe ' int2str(index_riga_vert_above2), ' to ',  int2str(index_riga_vert_below2), ' chamber2 1h'])

% COMPARE horizontal vertical
figure()
subplot(2,1,1)
image(matrice_heat_hor_2)
title(['heat map: riga ',int2str(index_riga), ', colonne ' int2str(index_colonna_above), ' to ',  int2str(index_colonna_below), ' chamber2 1h'])
subplot(2,1,2)
image(matrice_heat_vert_2)
title(['heat map: colonna ',int2str(index_colonna), ', righe ' int2str(index_riga_above), ' to ',  int2str(index_riga_below), ' chamber2 1h'])


