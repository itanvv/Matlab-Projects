function connectAndMark(sigma_x, sigma_y, tau_xy, sigma_1, sigma_2, center_x, center_y, tau_max, tau_min)
plot([sigma_1 sigma_2], [0 0]) % connects sigma_1 and sigma_2 by
% the x-values in one vector and the y-values in another vector

plot([center_x center_x],[tau_max tau_min], 'b:') % connects tau_max and tau_min

% plot(center_x, center_y, 'g*'); % marks center of the circle


text(center_x, center_y, "C(" + center_x + ", 0)", 'FontSize', 13); 
text(sigma_1, 0, "\sigma_{1}(" + sigma_1 + ",0)" , 'FontSize', 14); 
text(sigma_2, 0, "\sigma_{2}(" + sigma_2 + ",0)" , 'FontSize', 14);
text(center_x, tau_max, "\tau_{max}(" + center_x + ", " + tau_max + ")", 'FontSize', 14); 
text(center_x, tau_min, "\tau_{min}(" + center_x + ", " + tau_min + ")", 'FontSize', 14); 

% Marking point, A
text(sigma_x,tau_xy, "A(" + sigma_x + ", " + tau_xy + ")", 'FontSize', 14) ;
plot([center_x sigma_x], [0 tau_xy]);
plot([sigma_1 sigma_x], [0 tau_xy]);
plot([center_x sigma_x], [tau_min tau_xy], 'm');
hold off;
axis equal; % Makes aspect ratio = 1 to avoid showing ellipse
