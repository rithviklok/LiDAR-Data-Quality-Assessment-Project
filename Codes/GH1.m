clear all
clc
% Load flight LiDAR dataset
flight_data = csvread('VVA_gh_flightdata.csv');

% Extract X, Y, and Z coordinates from flight LiDAR data
flight_X = flight_data(:, 1);
flight_Y = flight_data(:, 2);
flight_Z = flight_data(:, 3);

% Load GCPs data
GCP_data = csvread('VVA_gh.csv');

% Extract X, Y, and Z coordinates from GCPs data
GCP_X = GCP_data(:, 3);
GCP_Y = GCP_data(:, 2);
GCP_Z = GCP_data(:, 4);

% Create Delaunay triangulation from GCPs
DT = delaunayTriangulation(GCP_X, GCP_Y);
triangles = DT.ConnectivityList;
num_triangles = size(triangles, 1);

% Preallocate array to store perpendicular distances
distances = zeros(size(flight_data, 1), 1);

% Loop through each point in flight LiDAR data
for i = 1:size(flight_data, 1)
    % Current point coordinates
    x = flight_X(i);
    y = flight_Y(i);
    z = flight_Z(i);
    
    % Initialize minimum distance
    min_distance = Inf;
    
    % Loop through each triangle
    for j = 1:num_triangles
        % Get vertices of the current triangle
        v1 = [GCP_X(triangles(j, 1)), GCP_Y(triangles(j, 1)), GCP_Z(triangles(j, 1))];
        v2 = [GCP_X(triangles(j, 2)), GCP_Y(triangles(j, 2)), GCP_Z(triangles(j, 2))];
        v3 = [GCP_X(triangles(j, 3)), GCP_Y(triangles(j, 3)), GCP_Z(triangles(j, 3))];
        
        % Calculate plane equation coefficients (ax + by + cz + d = 0)
        [A, B, C, D] = plane_equation(v1, v2, v3);
        
        % Calculate perpendicular distance from point to plane
        distance = abs(A * x + B * y + C * z + D) / sqrt(A^2 + B^2 + C^2);
        
        % Update minimum distance
        min_distance = min(min_distance, distance);
    end
    
    % Store minimum distance for current point
    distances(i) = min_distance;
end

% Calculate Root Mean Square Error (RMSE)
RMSE = sqrt(mean(distances.^2));

% Calculate Mean Absolute Error (MAE)
MAE = mean(abs(distances));
acc = 1.96 * RMSE;
% Display the results
fprintf('RMSE: %.2f metres\n', RMSE);
fprintf('Vertical Accuracy: %.2f metres \n', acc);

% Plot the TIN
triplot(DT);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('TIN surface generated for a patch of GCPs');

% If you want to visualize the GCPs as well
hold on;
scatter3(GCP_X, GCP_Y, GCP_Z, 'filled', 'MarkerFaceColor', 'r');
hold off;

function [A, B, C, D] = plane_equation(p1, p2, p3)
    % Calculate vectors from p1 to p2 and p1 to p3
    v1 = p2 - p1;
    v2 = p3 - p1;
    
    % Calculate normal vector to the plane
    normal = cross(v1, v2);
    
    % Normalize the normal vector
    normal = normal / norm(normal);
    
    % Plane equation coefficients (ax + by + cz + d = 0)
    A = normal(1);
    B = normal(2);
    C = normal(3);
    D = -dot(normal, p1);
end


% Now, 'distances' array contains perpendicular distances for each point in flight LiDAR data
