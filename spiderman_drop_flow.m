function res = spiderman_drop_flow (t, W, spiderman_mass, g,...
    drag_constant, air_density, contact_area)
    x = W(1);
    y = W(2);
    Vx = W(3);
    Vy = W(4);
    dxdt = Vx;
    dydt = Vy;
    %Drag not considered now
    dVxdt = (-0.5 * drag_constant * air_density * contact_area *...
       ((Vx^2+Vy^2)^(0.5)) * Vx) / spiderman_mass;
    %dVxdt = 0;
    dVydt = (-spiderman_mass * g-0.5 * drag_constant * air_density * contact_area *...
        ((Vx^2+Vy^2)^(0.5)) * Vy) / spiderman_mass;
    %dVydt = -g;
    
    res = [dxdt;dydt;dVxdt;dVydt];
end