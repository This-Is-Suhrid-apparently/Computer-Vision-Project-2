function world_points = triangulation_for_task3_3(Parameters1,Parameters2,Pixel_cordinates1,Pixel_cordinates2)

R1= Parameters1.Rmat;
c1 = Parameters1.position';
K1 = Parameters1.Kmat;

R2= Parameters2.Rmat;
c2 = Parameters2.position';
K2 = Parameters2.Kmat;

K1 = K1^-1;
K2 = K2^-1;

ray1 = R1'*K1*Pixel_cordinates1;
ray2 = R2'*K2*Pixel_cordinates2;

ray = cross(ray1,ray2);
ray = ray/norm(ray);

abd = inv([ray1 -ray2 ray])*(c2-c1);
Pw1 = c1 + abd(1)*ray1;
Pw2 = c2 + abd(2)*ray2;

world_points = (Pw1 + Pw2)/2;

end