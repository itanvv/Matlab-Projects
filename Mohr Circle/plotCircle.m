function plotCircle(center_x,center_y, radius)

% == Plotting a circle
theta = 0:0.01:2*pi;

% Using parametric equation of circle
x = center_x + radius*cos(theta); 
y = center_y + radius*sin(theta);
plot(x,y);
hold on;
grid on;
% Adding title and labels
title("\color{red}Mohr's Circle", 'FontSize', 20)
xlabel("\color{blue}Normal Stress, \sigma",'FontSize', 18);
ylabel("\color{blue}Shear Stress, \tau", 'FontSize', 18);