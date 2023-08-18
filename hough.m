clc; clear; close all;

% 读入图像
I = imread('IMG_5167.JPG');
figure; imshow(I);
title('origin');

% 预处理图像
img = rgb2gray(I);
img = imgaussfilt(img,3);
figure; 
imshow(img);
title('image gaussian');

% 用canny算子进行边缘检测
BW = edge(img, 'canny', 0.3);
figure; 
imshow(BW);
title('canny edge detection');

% 对边缘进行霍夫变换，检测圆心
[centers, radii, metric] = imfindcircles(BW, [10 600], 'Sensitivity', 1);

% 对圆的累加值进行高斯平滑处理
smoothed_metric = imgaussfilt(metric, 2);

% 设置阈值，将符合条件的圆心点筛选出来
threshold = 0.5 * max(smoothed_metric);
centers_ = centers(smoothed_metric >= threshold, :);

% 显示检测结果
figure; imshow(I);
hold on;
viscircles(centers_, radii(smoothed_metric >= threshold), 'Color', 'b');
for i = 1:size(centers_, 1)
    % 用红色十字标记圆心点
    x = centers_(i, 1);
    y = centers_(i, 2);
    plot(x, y, 'r+');
end
title(sprintf('hough圆心检测结果，共检测到 %d 个圆心', size(centers_, 1)));