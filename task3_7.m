% CODE ADAPTED FROM ROBERT COLLINS's CMPEN 454 SAMPLE MATLAB CODES

function task3_7(Parameters1,image1)

R1 = Parameters1.Rmat;
c1 = Parameters1.position';
K1 = Parameters1.Kmat;
%read source image

source = image1;
% source = image2;

[nr,nc,nb] = size(source);

dest = zeros(nr,nc,nb); 

fig1 = figure;
set(fig1,'Name','Task3_7: Floor Points Selection for Image 1 ','NumberTitle','off')
imshow(source)
[x1_Floor, y1_Floor] = ginput(4);
Image1_Points_Floor = [x1_Floor'; y1_Floor'; ones(1,4)];
close(fig1)

% initialize variables 
K1_inv = K1^-1;
Points = zeros(3, 4);
lambdas = zeros(1, 4);
xprimes = zeros(1, 4);
yprimes = zeros(1, 4);
for i=1:4
    % compute 3D viewing ray for the given 2D points
    % P_w = (3D location of camera) + lambda * (unit vector pointing out from camera to the world)
    Points(:,i) = R1'*K1_inv*Image1_Points_Floor(:,i);
    Points(:,i) = Points(:,i)/norm(Points(:,i));
    % We know the floor points lie on the plane with z = 0; i.e, P_w_z = 0;  
    % So we can solve for lambda manually.
    % P_w_z = C_z + lambda * V_z ;
    % lambda = -C_z/V_z
    lambdas(1,i) = -c1(3)/Points(3,i);

    % compute P_w_x and P_w_y
    xprimes(1,i) = c1(1) + lambdas(1,i)*Points(1,i);
    yprimes(1,i) = c1(2) + lambdas(1,i)*Points(2,i);
end

% normalize
xprimes = xprimes' - min(xprimes');
yprimes = yprimes' - min(yprimes');



%compute homography (from im2 to im1 coord system)
p1 = x1_Floor; p2 = y1_Floor;
p3 = xprimes; p4 = yprimes;
vec1 = ones(size(p1,1),1);
vec0 = zeros(size(p1,1),1);
Amat = [p3 p4 vec1 vec0 vec0 vec0 -p1.*p3 -p1.*p4; vec0 vec0 vec0 p3 p4 vec1 -p2.*p3 -p2.*p4];
bvec = [p1; p2];
h = Amat \ bvec;
fprintf(1,'Homography:');
fprintf(1,' %.2f',h); fprintf(1,'\n');

%warp im1 forward into im2 coord system 
[xx,yy] = meshgrid(1:size(dest,2), 1:size(dest,1));
denom = h(7)*xx + h(8)*yy + 1;
hxintrp = (h(1)*xx + h(2)*yy + h(3)) ./ denom;
hyintrp = (h(4)*xx + h(5)*yy + h(6)) ./ denom;
for b = 1:nb
 dest(:,:,b) = interp2(double(source(:,:,b)),hxintrp,hyintrp,'linear')/255.0;
end

%display result
imagesc(dest);



end