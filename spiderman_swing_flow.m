function res = spiderman_swing_flow (t, W, spiderman_mass, g, spring_constant,...
    initial_length, drag_constant, air_density, contact_area)
    x = W(1);
    y = W(2);
    Vx = W(3);
    Vy = W(4);
    dxdt = Vx;
    dydt = Vy;
    dVxdt = - spring_constant * ((x^2+y^2)^(0.5)-initial_length) * x/((x^2+y^2)^(0.5));
    %drag = 0.5 * drag_constant * air_density * contact_area *...
    %((x^2+y^2)^(0.5)) * y
    dVydt = - spiderman_mass * g - spring_constant * ((x^2+y^2)^(0.5)-...
        initial_length) * y/((x^2+y^2)^(0.5));
    res = [dxdt;dydt;dVxdt;dVydt];
end