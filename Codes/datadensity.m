%% data density

clear all
clc

% Read the CSV file
lidarData = readmatrix("fordatadensity.csv"); % Assuming x, y, z are in separate columns

% Extract x, y, and z values
x = lidarData(:, 1); % Assuming x is in the first column
y = lidarData(:, 2); % Assuming y is in the second column
z = lidarData(:, 3); % Assuming y is in the second column

% Calculate data density
numPoints = numel(x); % Total number of points
area = (max(x) - min(x)) * (max(y) - min(y)); % Calculate volume
dataDensity = numPoints / area;

% Display data density
fprintf('Data density: %.2f points per square meter\n', vpa(dataDensity,12));

%% NPS

NPS = 1/sqrt(dataDensity);
fprintf('NPS: %f \n', NPS);
