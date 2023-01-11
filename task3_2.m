% Coded and compiled by Suhrid Das

function world_coordinates =  task3_2(Pixel_cordinates1,Pixel_cordinates2,Parameters1,Parameters2)

R1= Parameters1.Rmat;
c1 = Parameters1.position';
K1 = Parameters1.Kmat;

R2= Parameters2.Rmat;
c2 = Parameters2.position';
K2 = Parameters2.Kmat;

Pw1 = zeros(3,39);
Pw2 = zeros(3,39);

K1 = K1^-1;
K2 = K2^-1;

for j = 1:39
    ray1 = R1'*K1*Pixel_cordinates1(:,j);
    ray2 = R2'*K2*Pixel_cordinates2(:,j);

   ray = cross(ray1,ray2);
   ray = ray/norm(ray);

   abd = inv([ray1 -ray2 ray])*(c2-c1);
   Pw1(:,j) = c1 + abd(1)*ray1;
   Pw2(:,j) = c2 + abd(2)*ray2;
end
 world_coordinates = (Pw1 + Pw2)/2;
end
