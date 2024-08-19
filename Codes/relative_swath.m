
clear all
clc
% Flight LiDAR coordinates
% Load CSV files
data1 = csvread('nonoverlap_relative_left.csv'); % replace with your file name

z1 = data1(:, 3);

%Standard deviation as a measure of relative accuracy
Standard_deviation=std(z1);
fprintf("The relative accuracy obtaines is %f meters",vpa(Standard_deviation,4))
