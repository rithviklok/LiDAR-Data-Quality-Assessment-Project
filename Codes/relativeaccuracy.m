
clear all
clc
% Flight LiDAR coordinates
% Load CSV files
data1 = csvread('relative_left.csv'); % replace with your file name
data2 = csvread('relative_right.csv'); % replace with your file name

%Extracting z values from both las files
z1 = data1(:, 3);
z2 = data2(:, 3);

%Merging Z values from both .las files
Z=[z1;z2];

%Standard deviation as a measure of relative accuracy
Standard_deviation=std(Z);
fprintf("The relative accuracy obtaines is %f meters",vpa(Standard_deviation,4))
