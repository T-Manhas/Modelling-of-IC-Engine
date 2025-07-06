
function F = system_eqns(varray)
    xt = varray(1); 
    yt = varray(2);  
    
    %Slope
    F(1) = (yt - 1) / xt - 2 / (1 + xt)^2;  
    
    %Curve
    F(2) = yt - 2 * xt / (1 + xt); 
end

initial_guess1 = [1, 1];  % Initial guess near the first intersection point
initial_guess2 = [-0.5, 1];  % Initial guess near the second intersection point

sol1 = fsolve(@system_eqns, initial_guess1);
sol2 = fsolve(@system_eqns, initial_guess2);

xt1 = sol1(1);  
yt1 = sol1(2);  

xt2 = sol2(1);  
yt2 = sol2(2);  


disp('Point of tangency 1 (x_t, y_t):');
disp([xt1, yt1]);

disp('Point of tangency 2 (x_t, y_t):');
disp([xt2, yt2]);

% Calculate the slope
slope1 = 2 / (1 + xt1)^2;
slope2 = 2 / (1 + xt2)^2;

disp('Slope of the tangent at point 1:');
disp(slope1);

disp('Slope of the tangent at point 2:');
disp(slope2);

% Define the tangent line equations: y = slope * (x - xt) + yt

x_values = linspace(-2, 5, 400);

y_curve = 2 * x_values ./ (1 + x_values);

y_tangent1 = slope1 * (x_values - xt1) + yt1;
y_tangent2 = slope2 * (x_values - xt2) + yt2;

figure;
hold on;
plot(x_values, y_curve, 'b', 'LineWidth', 2);  % Curve in blue
plot(x_values, y_tangent1, 'r--', 'LineWidth', 2);  % Tangent line 1 in red
plot(x_values, y_tangent2, 'g--', 'LineWidth', 2);  % Tangent line 2 in green
scatter(xt1, yt1, 100, 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g');  % Point of tangency 1
scatter(xt2, yt2, 100, 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r');  % Point of tangency 2
legend('Curve y = 2x/(1+x)', 'Tangent Line 1', 'Tangent Line 2', 'Point of Tangency 1', 'Point of Tangency 2');
title('Tangent Lines to the Curve');
xlabel('x');
ylabel('y');
grid on;
hold off;
