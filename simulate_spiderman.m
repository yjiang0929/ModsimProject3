function res = simulate_spiderman(initialTime,finalTime,theta,initialX,initialY)
%function [T,r,length0,length1] = simulate_spiderman(initialTime,finalTime,theta)

%Simulate spiderman's motion

%Declare parameter values
g=9.8; %gravity in m/s^2
m=75.75; %spiderman's mass in kilograms
CD=1.2; %coefficient of drag
rho=1.2; %density of air in kg/m^3
A=0.6; %contact area in m^2

%initialX=-30; %meters
%initialY=0; %meters
l0 = sqrt(initialX^2 + initialY^2);
k = 125e3/l0;
initialVx=0;
initialVy=0;

initialValues=[initialX,initialY,initialVx,initialVy];

%When Spiderman's building is higher than the target one, it free falls at
%first.
T0 = [];
r0 = [];
if initialY>0
    spidermandrop0 = @(t,W) spiderman_drop_flow(t,W,m,g,CD,rho,A);
    option0 = odeset('Events',@spidey_events0);
    [T0,r0] = ode45(spidermandrop0,[initialTime,finalTime],initialValues,option0);
    initialTime = T0(end);
    initialValues = r0(end,:);
end;

%Spiderman swings between the buildings.
spidermanswing=@(t,W) spiderman_swing_flow(t,W,m,g,k,l0,CD,rho,A);
option1 = odeset('Events',@spidey_events1);
[T1,r1]=ode45(spidermanswing,[initialTime,finalTime],initialValues,option1);
T1 = [T0;T1];
r1 = [r0;r1];

T2 = [];
r2 = [];
%Spiderman falls to the ground after releasing himself from the web
if T1(end)<finalTime
    spidermandrop1=@(t,W) spiderman_drop_flow (t,W,m,g,CD,rho,A);
    option2=odeset('Events',@spidey_events2);
    [T2,r2]=ode45(spidermandrop1,[T1(end),finalTime],r1(end,:),option2);
end;
T = [T1;T2];
r = [r1;r2];
Xs=r(:,1);
Ys=r(:,2);
length0 = length(T0);
length1 = length(T1);
res = Xs(end);
%spiderman_animation(T,[Xs,Ys+150]);

%plot(Xs,Ys+150);
%xlabel('Horizontal distance');
%ylabel('Vertical distance');

%plot(T,r);

%plot(T,GP,'r');
%plot(T,EP,'b');
%plot(T,KE,'g');
%title('Spiderman Swinging and Falling');
    function spiderman_animation(T,M)
        X = [M(:,1);0];
        Y = [M(:,2);150];
        minmax = [min(X),max(X),min(Y),max(Y)];
        for i = 1:length(T)
            clf;
            axis(minmax);
            hold on;
            draw_func(X(i),Y(i),0,150,initialX,initialY+150);
            drawnow;
        end
    end

    function draw_func(x1, y1, x2, y2,x3,y3)
        plot(x1, y1, 'r.', 'MarkerSize', 50);
        plot(x2, y2, 'b.', 'MarkerSize', 30);
        plot(x3, y3, 'b.', 'MarkerSize', 30);
    end

    function [value,isterminal,direction] = spidey_events0(t,X)
        value = X(1)^2+X(2)^2 - l0^2;
        isterminal = 1;
        direction = 1;
    end
    
    function [value,isterminal,direction] = spidey_events1(t,X)
        %Events fxn
       value=tand(theta)+X(1)/X(2);
       isterminal=1;
       direction=0;
    end

    function [value,isterminal,direction] = spidey_events2(t,X)
        value=X(2)+150;
        isterminal=1;
        direction=0;
    end
end

