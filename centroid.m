%清空变量
clear;close all
   
%读取图像文件
src = imread('IMG_5167.JPG');

%显示原始图像
figure; 
imshow(src);
title('origin');

%预处理图像
im0=rgb2gray(src);%变彩色为黑白
im1=imgaussfilt(im0,3);%高斯滤波平滑平滑图像
figure; 
imshow(im1);
title('image gaussian');

% 用ostu方法获取二值化阈值，进行二值化并进行显示
level=graythresh(im1);
bw=~im2bw(src,level);
figure; 
imshow(bw);
title('image binary');

%运用开操作消去噪点
se = strel('disk',2);%创建disk圆盘结构元素se
openbw=imopen(bw,se);
figure; 
imshow(bw);
title('image opening');

%获取连通区域，并转换成RGB模式进行显示
bw=imclearborder(bw,4);
bw=bwareaopen(bw,300);
[L,num]=bwlabel(bw,8);
RGB = label2rgb(L);
figure; 
imshow(RGB);
title('connected components rgb');

% 获取区域的'basic'属性， 'Area', 'Centroid', and 'BoundingBox'
% 'Area'图像各个区域中像素总个数;'BoundingBox' 包含相应区域的最小矩形;
% 'Centroid' 每个区域的质心（重心）;
stats = regionprops(bw, 'Area', 'Centroid', 'BoundingBox','PixelList', 'MajorAxisLength','MinorAxisLength','Eccentricity');
centroids = cat(1, stats.Centroid);

figure;
imshow(src);
title('result');
hold on
%绘制重心
plot(centroids(:,1), centroids(:,2), 'r+')
%绘制感兴趣区域ROI
for i=1:size(stats)
    if stats(i).Area<3000 && stats(i).Area>20 && stats(i).Eccentricity<0.8 
        rectangle('Position',[stats(i).BoundingBox],'LineWidth',2,'LineStyle','-','EdgeColor','b')
    end
end
title(sprintf('连通域灰度重心检测结果，共检测到 %d 个重心', size(stats, 1)));