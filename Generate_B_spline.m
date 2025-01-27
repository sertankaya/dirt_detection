clc;clear all;close all
tmp=imread('Modified_355319087540089_RearCameraBlackSpotPictureTest_1530117896291.jpg');  %'Rear.jpg'-231-7000 'Modified_Rear_spot.jpg'-232-9000 %Modified_355319087540089_RearCameraBlackSpotPictureTest_1530117896291-234 15000
%figure;imshow(tmp);
tmp_green=tmp(:,:,2);%./max(tmp(:,:,2));
%figure;imshow(tmp_green)

K = medfilt2(tmp_green,[99,99]);  %[123,123]  [120,120] [111,111]
%figure;imshow(K)

K = imgaussfilt(K,11);
%figure;imshow(shading)



row=[];
col=[];
array_row=[];
array_col=[];
canvas=zeros(size(K,1),size(K,2));
tmp=[];
for i=1:100:size(K,1)
    for j=1:100:size(K,2)
    canvas(i,j)=K(i,j);
    array_row=[array_row;K(i,j)];
    row=[row;j];
    end
    col=[col;i];
    array_col=[array_col;K(i,j)];
end


i = 1;
j = 1;
n = 30;
for k=1:n
    x=double(1:100:4032);  %
    v=double(array_row(j:40+j));
    xq = 1:1:4032;
    vq1 = interp1(x,v,xq);
    canvas(i,:)=vq1;
        
    % Use i and j
    i = i + 100;
    j = j + 41;
end


for j=1:size(K,2)
          
        x=double(1:100:3024);  %3024
        v=double(canvas(1:100:3024,j));
        xq = 1:1:3024;
        vq2 = interp1(x,v,xq);
        canvas(:,j)=vq2;

end

canvasn=uint8(canvas);
%figure;imshow(canvasn)

diff=canvasn-K;  %imresize(J,[size(K,1),size(K,2)])
%figure;imshow((diff));

I2 = histeq((diff));
%figure;imshow(I2)

%adapt = adapthisteq(diff);
%figure;imshow(adapt)

binaryImage = I2 > 234;
%figure;imshow(binaryImage)


cc = bwconncomp(binaryImage);
stats = regionprops(cc);
removeMask = [stats.Area]<13500;  %7000
binaryImage(cat(1,cc.PixelIdxList{removeMask})) = false;

figure;imshow(binaryImage)
axis('on')

Ilabel = bwlabel(binaryImage);
stat = regionprops(Ilabel,'centroid');
figure;imshow(tmp_green); hold on;axis('on')
for x = 1: numel(stat)
    plot(stat(x).Centroid(1),stat(x).Centroid(2),'LineStyle', 'none', 'Color', 'g',...
         'Marker', 'o', 'Markersize', 8, 'LineWidth', 1);   %'rX'
     plot(stat(x).Centroid(1),stat(x).Centroid(2),'r+');
     
end








