
flightLine1 = csvread('LDR080101_054502_0 - Cloud.csv'); % replace with your file name
flightLine2 = csvread('LDR080101_055738_0 - Cloud.csv'); % replace with your file name

% Create polyshape objects for flight lines
polyshape1 = polyshape(flightLine1(:,1), flightLine1(:,2));
polyshape2 = polyshape(flightLine2(:,1), flightLine2(:,2));

% Compute intersection between polyshapes
intersection_polyshape = intersect(polyshape1, polyshape2);

% Calculate overlap area
overlap_area = area(intersection_polyshape);

% Find maximum, minimum, and average overlap
max_overlap = max(overlap_area);
min_overlap = min(overlap_area);
avg_overlap = mean(overlap_area);

% Display results
fprintf('Maximum Overlap Area: %.2f\n', max_overlap);
fprintf('Minimum Overlap Area: %.2f\n', min_overlap);
fprintf('Average Overlap Area: %.2f\n', avg_overlap);

