function [ output_args ] = simulate_spiderman( initialTime,finalTime,theta )

%Simulate spiderman's motion

%Declare parameter values
g=9.8; %gravity in m/s^2
m=75.75; %spiderman's mass in kilograms
k=4170;  %spring constant in N/m
l0=30; %initial length of web in m
CD=0.8; %coefficient of drag
rho=1.2; %density of air in kg/m^3
A=1; %contact area in m^2

initialX=-30; %meters
initialY=0; %meters
initialVx=0;
initialVy=0;

initialValues=[initialX,initialY,initialVx,initialVy];


%Spiderman swing flow anonymous function
spidermanswing=@(t,W) spiderman_swing_flow(t,W,m,g,k,l0,CD,rho,A);
option1 = odeset('Events',@spidey_events);
[T1,r1]=ode45(spidermanswing,[initialTime,finalTime],initialValues,option1);

%Spiderman drop flow fxn
spidermandrop=@(t,W) spiderman_drop_flow (t,W,m,g,CD,rho,A);
option2=odeset('Events',@spidey_events2);
[T2,r2]=ode45(spidermandrop,[T1(end),finalTime],r1(end,:),option2);

T=[T1;T2];
Xs=[r1(:,1);r2(:,1)];
Ys=[r1(:,2);r2(:,2)];
plot(Xs,Ys)

    function [value,isterminal,direction] = spidey_events(t,X)
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

