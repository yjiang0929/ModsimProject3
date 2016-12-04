function res = spiderman_punchline(initialX,initialY)
initialTime = 0;
finalTime = 40;
initialangle = -89;
finalangle = 90;
Angle = linspace(initialangle,finalangle,finalangle-initialangle+1);
Distance = zeros(initialangle,finalangle);
j = 1;
for i = initialangle:1:finalangle
    Distance(j) = simulate_spiderman(initialTime,finalTime,i,initialX,initialY);
    j = j+1;
end;
res = Angle(find(Distance == max(Distance)));
hold on
%plot(Angle,Distance);
%xlabel('Angle(deg)');
%ylabel('Horizontal Distance(m)');
end