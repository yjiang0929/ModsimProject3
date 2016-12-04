function spiderman_validation(initialTime,finalTime,theta)
[T,r,length0,length1] = simulate_spiderman(initialTime,finalTime,theta);
    
X = r(:,1);
Y = r(:,2);
Vx = r(:,3);
Vy = r(:,4);
GP = [];
EP = [];
KE = [];

%define variables used in the calculation of energy
spiderman_mass = 75.75;
initial_length = sqrt(30^2 + 0^2);
g = 9.8;
spring_constant = 125e3 / initial_length;
    
for i = 1 : 1 : length0
    GP(i) = abs(Y(i)+150)*spiderman_mass*g;
    EP(i) = 0;
    KE(i) = 0.5*spiderman_mass*(Vx(i)^2+Vy(i)^2);
end;
for i = max(length0,1) : 1 : length1
    GP(i) = abs(Y(i)+150)*spiderman_mass*g;
    EP(i) = 0.5*spring_constant*((X(i)^2+Y(i)^2)^(0.5)-initial_length)^2;
    KE(i) = 0.5*spiderman_mass*(Vx(i)^2+Vy(i)^2);
end;
for i = length1 : 1 : length(T)
    GP(i) = abs(Y(i)+150)*spiderman_mass*g;
    EP(i) = EP(i-1);
    KE(i) = 0.5*spiderman_mass*(Vx(i)^2+Vy(i)^2);
end;

total = GP+EP+KE;
hold on;
plot(T,GP,'r');
plot(T,EP,'b');
plot(T,KE,'g');
plot(T,total,'k');
title('Validation: Energy Conservation');
xlabel('Time(s)');
ylabel('Energy(J)');
legend('Gravitational Potentional Energy','Elastic Potentional Energy',...
    'Kinetic Energy','Total Energy');

end