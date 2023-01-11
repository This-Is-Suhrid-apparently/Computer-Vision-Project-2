

function [u, v, w] = task3_1(mocap_points,Parameters,Image)

K = Parameters.Kmat;
% P = Parameters.Pmat;
R = Parameters.Rmat;
c= Parameters.position;
t = -R*c';
for i = 1:39
    Pc = K*(R*mocap_points(:,i) + t);
    u(i) = Pc(1,:);
    v(i) = Pc(2,:);
    w(i)= Pc(3,:);

end
u_trans = u./w;
v_trans = v./w;

figure
imshow(Image);
hold on
plot( u_trans , v_trans,'r.','MarkerSize',7.5)
hold off


end