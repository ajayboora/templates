clear all
close all
clc
%%
I = imread('orig.png');
I = imresize(I, [256, 256]);
I = I-min(min(min(I)));
I = I./max(max(max(I)));

Ir = double(squeeze(I(:,:,1)));
Ig = double(squeeze(I(:,:,2)));
Ib = double(squeeze(I(:,:,3)));

h = daubcqf(2);
WIr = mdwt(Ir,h);
WIg = mdwt(Ig,h);
WIb = mdwt(Ib,h);

% Find first-level decompositions
WIr1 = zeros(size(WIr));
WIr1(1:2,1:2) = WIr(1:2,1:2);
Ir1 = midwt(WIr1,h);

WIg1 = zeros(size(WIg));
WIg1(1:2,1:2) = WIg(1:2,1:2);
Ig1 = midwt(WIg1,h);

WIb1 = zeros(size(WIb));
WIb1(1:2,1:2) = WIb(1:2,1:2);
Ib1 = midwt(WIb1,h);

I1 = zeros(256, 256, 3);
I1(:,:,1) = Ir1; I1(:,:,2) = Ig1; I1(:,:,3) = Ib1;
mn = min(min(min(I1)));
I1 = (I1-mn);
mx = max(max(max(I1)));
I1 = I1./mx;

image(I1);
%%
close all
% Find second-level decompositions
ll = 7;

WIr2 = zeros(size(WIr));
WIr2(1:2^(ll),2^(ll-1)+1:2^(ll)) = WIr(1:2^(ll),2^(ll-1)+1:2^(ll));
WIr2(2^(ll-1)+1:2^(ll),1:2^(ll)) = WIr(2^(ll-1)+1:2^(ll),1:2^(ll));
Ir2 = midwt(WIr2,h);

WIg2 = zeros(size(WIg));
WIg2(1:2^(ll),2^(ll-1)+1:2^(ll)) = WIg(1:2^(ll),2^(ll-1)+1:2^(ll));
WIg2(2^(ll-1)+1:2^(ll),1:2^(ll)) = WIg(2^(ll-1)+1:2^(ll),1:2^(ll));
Ig2 = midwt(WIg2,h);

WIb2 = zeros(size(WIb));
WIb2(1:2^(ll),2^(ll-1)+1:2^(ll)) = WIb(1:2^(ll),2^(ll-1)+1:2^(ll));
WIb2(2^(ll-1)+1:2^(ll),1:2^(ll)) = WIb(2^(ll-1)+1:2^(ll),1:2^(ll));
Ib2 = midwt(WIb2,h);


I2 = zeros(256, 256, 3);
I2(:,:,1) = Ir2; I2(:,:,2) = Ig2; I2(:,:,3) = Ib2;
mn = min(min(min(I2)));
I2 = (I2-mn);
mx = max(max(max(I2)));
I2 = I2./mx;

image(I2);
%%
break
%%
clear all
close all

h = daubcqf(2);
% test levels

ww = zeros(128,128);
ww(4,4) = 1;
ii = midwt(ww,h);
imagesc(ii); colormap gray

%%
clear all
close all
h = daubcqf(2);

WW = zeros(128,128);

ll = 3;
WWn = zeros(size(WW));

WWn(1:2^(ll),2^(ll-1)+1:2^(ll)) = 1;
WWn(2^(ll-1)+1:2^(ll),1:2^(ll)) = 1;

WWn(1:10,1:10)