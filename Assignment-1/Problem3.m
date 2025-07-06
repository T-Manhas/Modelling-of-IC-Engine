% x^2 + y^2 - 4 = 0   (Circle equation)
% x^2 - y - 1 = 0      (Parabola equation)

function F = system_eqns(variable_array)
    x = variable_array(1);  
    y = variable_array(2);  
    
    F(1) = x^2 + y^2 - 4;    
    F(2) = x^2 - y - 1;      
end

initial_guess1 = [1.5, 1];  % Initial guess near the first intersection point
initial_guess2 = [-1.5, 1]; % Initial guess near the second intersection point

solution1 = fsolve(@system_eqns, initial_guess1);
solution2 = fsolve(@system_eqns, initial_guess2);

disp('Intersection points (x, y):');
disp('Solution 1:');
disp(solution1);
disp('Solution 2:');
disp(solution2);
