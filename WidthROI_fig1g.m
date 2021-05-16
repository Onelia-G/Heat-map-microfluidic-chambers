clearvars; clc; close all

% A folder containing images pre-processed with ImageJ in .tif is input here.

i1 = 1;
i2 = 330;
numPics = length(i1:i2);

% Width ROIs
ROI_width = 16;
ROI_height = 96;
corner1 = [116,15];
corner2 = [116,140];

n_px = 16;
k1max = ROI_height/n_px;
ROI_ch1 = cell(k1max,1);
ROI_ch2 = cell(k1max,1);

ch1 = zeros(numPics,k1max);
ch2 = zeros(numPics,k1max);
ch1_std = zeros(numPics,k1max);
ch2_std = zeros(numPics,k1max);

for i = 1:numPics
    j = num2str(i1+i-1);
    I = imread(['image_',j,'.tif']);
       
    for k1 = 1:k1max
        corner1k = [corner1(1),corner1(2)+(k1-1)*n_px];
        corner2k = [corner2(1),corner2(2)+(k1-1)*n_px];
        ROI_ch1{k1,1} = I(corner1k(2):corner1k(2)+n_px-1,corner1k(1):corner1k(1)+n_px-1);
        ROI_ch2{k1,1} = I(corner2k(2):corner2k(2)+n_px-1,corner2k(1):corner2k(1)+n_px-1);
    end
    ROItot_ch1 = I(corner1(2):corner1(2)+ROI_height-1,corner1(1):corner1(1)+ROI_width-1);
    ROItot_ch2 = I(corner2(2):corner2(2)+ROI_height-1,corner2(1):corner2(1)+ROI_width-1);
       
    % Calculate mean and std intensity in the ROIs
    for k = 1:k1max
        ch1(i,k) = mean(mean(ROI_ch1{k,1}));
        ch2(i,k) = mean(mean(ROI_ch2{k,1}));
        
        ch1_std(i,k) = std(double(ROI_ch1{k,1}(:)));
        ch2_std(i,k) = std(double(ROI_ch1{k,1}(:)));
    end
end

clear i i1 i2 j I k1 k1max n_px corner1 corner2 corner1k corner2k

figure;
colormap('jet')
subplot(1,2,1,'CLim',[0 2e4])
hold on
imagesc(ch1')
xlabel('Time (d)')
ylabel('ROIs')
title('F = 1/24 h^{-1}')
colorbar

subplot(1,2,2,'CLim',[0 2e4])
hold on
imagesc(ch2')
xlabel('Time (d)')
ylabel('ROIs')
title('F = 1 h^{-1}')
colorbar
