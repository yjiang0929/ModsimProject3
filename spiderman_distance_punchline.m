Xstart = -40;
Xend = -10;
Ystart = -20;
Yend = 10;
numTimes = 30;
X = linspace(Xstart,Xend,numTimes);
Y = linspace(Ystart,Yend,numTimes);
MaxDistance = zeros(numTimes,numTimes);
for i = 1:numTimes
    for j = 1:numTimes
        MaxDistance(i,j) = spiderman_punchline(X(i),Y(j));
    end;
end;
pcolor(X,Y,MaxDistance);
shading interp;
xlabel('Initial Horizontal Position');
ylabel('Initial Verticacl Position');
title('Ideal Release Angle');
cb = colorbar;