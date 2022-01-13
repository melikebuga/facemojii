FDetect = vision.CascadeObjectDetector;

[filename, pathname] = uigetfile({'*.*'},'Dosya Seçici');

I = imread([pathname filename]);
J= imnoise(I, 'salt & pepper', 0.1);

r=medfilt2(J(:,:,1),[3,3]);
g=medfilt2(J(:,:,2),[3,3]);
b=medfilt2(J(:,:,3),[3,3]);
K=cat(3,r,g,b);

imagefiles = dir('image/*.png');
nfiles = length(imagefiles);    

for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   [currentimage,map,alpha] = imread(['image/' currentfilename]);
   images{ii} = currentimage;
   alphalar{ii} = alpha;
end

BB = step(FDetect,K);

figure,
image(K); hold on
for i = 1:size(BB,1)
    randomSayi = randi(nfiles);
    image([BB(i,1) BB(i,1)+BB(i,3)],[BB(i,2) BB(i,2)+BB(i,4)], images{randomSayi},'AlphaData', alphalar{randomSayi});

end
title('Facemoji');
hold off;
