function [radius, center_x, center_y, sigma_1, sigma_2, tau_max, tau_min] = calcValues(sigma_x, sigma_y,tau_xy) 

% == Find radius and center point from input ==
radius = sqrt(((sigma_x-sigma_y)/2)^2+(tau_xy)^2);
center_x = (sigma_x+sigma_y)/2;
center_y = 0;
sigma_1 = center_x + radius;
sigma_2 = center_x - radius;
tau_max = radius;
tau_min = -radius;