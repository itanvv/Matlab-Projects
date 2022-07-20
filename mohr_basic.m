[sigma_x, sigma_y, tau_xy] = takeInput(); %First take input from user

[radius, center_x, center_y, sigma_1, sigma_2, tau_max, tau_min] = calcValues(sigma_x, sigma_y, tau_xy); %Finds necessary values

plotCircle(center_x,center_y, radius); % Plots the circle and adds title, labels

connectAndMark(sigma_x, sigma_y, tau_xy, sigma_1, sigma_2, center_x, center_y, tau_max, tau_min);
% Connects necessary points and marks them





