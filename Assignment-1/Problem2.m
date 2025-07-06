syms y1;

% Define the functions y1(x) and y2(x)
y1_func = y1;  
x = (y1 - 1) / 2;  % x in terms of y1

y2_func = 2*x / (1 + 0.2*x);

integral1 = int(1 / (y1_func + y2_func), y1, 0, 15);
integral2 = int(1 / (y1_func - y2_func), y1, 0, 15);

disp('Integral 1 result:');
disp(integral1);

disp('Integral 2 result:');
disp(integral2);
