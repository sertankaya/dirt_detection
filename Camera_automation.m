tmp=imread('Modified_Rear_spot.jpg');
%tmp_salt = imnoise(tmp,'salt & pepper',0.1);
figure;imshow(tmp);
gray=rgb2gray(tmp);
figure;imshow(gray);
axis on;

T = adaptthresh(gray, 0.59);
figure;imshow(T)
title('Adaptive threshold')

BW = imbinarize(gray,T);
figure;imshow(BW)
U = imcomplement(BW);
figure;imshow(U)
Unew=uint8(U);
binaryImage = Unew > 250;
figure;imshow(binaryImage)

%[centers, radii, metric] = imfindcircles(U,[200 350]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%se = strel('line',11,90);
se = offsetstrel('ball',5,2);
erodedBW2 = imerode(uint8(U),se);

figure;imshow(uint8(erodedBW2))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tmp=imread('Modified_Rear_spot.jpg');
figure;imshow(tmp);
tmp_green=tmp(:,:,2); %./max(tmp(:,:,2)));
figure;imshow(uint8(tmp_green))

B = bfilter2(tmp_green,10,1);
figure;imshow(B);


J = imadjust(tmp_green,stretchlim(tmp_green));
%K = imadjust(J,[0 0.8],[]);
figure;imshow(uint8(J));

d_str=decorrstretch(tmp_green,'tol',0.1);
figure;imshow(uint8(d_str));


gray=rgb2gray(J);
figure;imshow(gray);

T = adaptthresh(tmp_green, 0.59);
figure;imshow(uint8(T))
title('Adaptive threshold')
BW = imbinarize(gray,T);
figure;imshow(BW)

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Steve's
adapt = adapthisteq(tmp_green);
figure;imshow(adapt)
[accum, circen, cirrad] = CircularHough_Grd(adapt, [200 350], 20, 13, 1)

%%%%%
level=0.56;
it=im2bw(adapt,level);
figure;imshow(it)
%---------------------
I2 = histeq(adapt);
I3 = imgaussfilt(I2, 0.2);
I4 = edge(I3,'sobel');
figure;imshow(I3)
New = imcomplement(I3);
figure;imshow(New)
binaryImage = New > 150;
figure;imshow(binaryImage)
edge = edge(binaryImage,'sobel');
figure;imshow(edge)

se3 = strel('line',100,90);
se = offsetstrel('ball',5,2);
se = strel('disk', 15)
se1 = strel('square', 66)
erodedBW2 = imerode(K,se3);
figure;imshow(erodedBW2)

K = medfilt2(New,[11,11]);
figure;imshow(K)


%---------------------------------------------------------------

Iin = im2double(imread('Modified_Rear_spot.jpg'));
shading = imgaussfilt(I3,5);
I2 = Iin.*mean2(shading)./Iin;
I3 = Iin-I2;
I4 = stdfilt(I3,ones(21,21));
I5 = imgaussfilt(I4,15);
I6 = imclose(imdilate(edge(I5,'canny'),strel('disk',3)),strel('line',55,0));
figure;imshow(I5)
%-------------------------------------------------------------

I = im2double(imread('Modified_Rear_spot.jpg'));
%figure;imshow(I)
%Kaverage = filter2(fspecial('average',9),I)/255;
K = medfilt2(I(:,:,2),[29,29]);
figure;imshow(K)

BW1 = edge(U,'sobel');

imshow(BW1);

H = histeq(K);
figure;imshow(H)

T = histeq(H);
figure;imshow(T)

edgeIm = sobel_mex(gray, 0.7);

%binaryImage = grayImage > 20;
%shading = imgaussfilt(Iin,5);
%I2 = Iin.*mean2(shading)./Iin;
I3 = Iin-I2;
%I4 = stdfilt(I3,ones(21,21));
%I5 = imgaussfilt(I4,15);
%I6 = imclose(imdilate(edge(I5,'canny'),strel('disk',3)),strel('line',55,0));
figure;imshow(Iin)




