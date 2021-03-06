%%auto pick using MODIFIED ENERGY RATIO

function event = auto_pick2(event)

ne = 200;
sr = 10; %seek range in seconds

for i = 1:event.number_of_sac
    
    bl = round((event.sac(i).first_break - sr) / event.sac(i).dt);% boundary low
    bh = round((event.sac(i).first_break + sr) / event.sac(i).dt);% boundary high
    
    er = zeros(1,bh);

    for j = bl:bh
        a = event.sac(i).data((j - ne):j);
        b = event.sac(i).data(j:(j + ne));
        er(j) = (a * a') / (b * b');
        er3(j) = (abs(event.sac(i).data(j)) * er(j))^3;
    end;
    maxxcor = maxxc(er3((bl+2):(bh-2))) + bl + 1;
    event.sac(i).first_break = maxxcor * event.sac(i).dt;
end

event = event;

return;
    
