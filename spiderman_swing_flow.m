function res = spiderman_swing_flow (t, W, spiderman_mass, g, spring_constant,...
    initial_length, drag_constant, air_density, contact_area)
    x = W(1);
    y = W(2);
    Vx = W(3);
    Vy = W(4);
    dxdt = Vx;
    dydt = Vy;
    if ((x^2+y^2)^(0.5) <= initial_length)
        spring_constant = 0;
    end;
    dVxdt =(- spring_constant * ((x^2+y^2)^(0.5)-initial_length) *...
        x/((x^2+y^2)^(0.5))-0.5 * drag_constant * air_density * contact_area *...
        ((Vx^2+Vy^2)^(0.5)) * Vx)/ spiderman_mass;
    %dVxdt = - spring_constant * ((x^2+y^2)^(0.5)-initial_length) *...
    %     x/((x^2+y^2)^(0.5))/ spiderman_mass;
    dVydt =(- spiderman_mass * g - spring_constant * ((x^2+y^2)^(0.5)-...
        initial_length) * y/((x^2+y^2)^(0.5))-0.5 * drag_constant *...
        air_density * contact_area* ((Vx^2+Vy^2)^(0.5)) * Vy)/spiderman_mass;
    %dVydt = (- spiderman_mass * g - spring_constant * ((x^2+y^2)^(0.5)-...
    %     initial_length) * y/((x^2+y^2)^(0.5)))/spiderman_mass;
    
    res = [dxdt;dydt;dVxdt;dVydt];
end