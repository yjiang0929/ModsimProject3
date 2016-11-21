function res = spiderman_drop_flow (t, W, spiderman_mass, g,...
    drag_constant, air_density, contact_area)
    x = W(1);
    y = W(2);
    Vx = W(3);
    Vy = W(4);
    dxdt = Vx;
    dydt = Vy;
    dVxdt = 0;
    %drag = 0.5 * drag_constant * air_density * contact_area *...
    %((x^2+y^2)^(0.5)) * y
    dVydt = - spiderman_mass * g;
    res = [dxdt;dydt;dVxdt;dVydt];
end