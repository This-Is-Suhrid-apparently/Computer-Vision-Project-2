% Coded and compiled by Suhrid Das

function [Plane,height_of_door,height_of_man,height_of_camera,World_Points_Floor] =  task3_3(image1,image2)


Version1 = load('Parameters_V1_1.mat'); % Loading the version1 Parameters for image 1 
Version2 = load('Parameters_V2_1.mat'); % Loading the version1 Parameters for image 2

fig1 = figure;
set(fig1,'Name','Task3_3:Floor Points Selection for Image 1 ','NumberTitle','off')
imshow(image1)
[x1_Floor, y1_Floor] = ginput(3);
Image1_Points_Floor = zeros(3,3);
Image1_Points_Floor(:,1) = [x1_Floor(1);y1_Floor(1);1];
Image1_Points_Floor(:,2) = [x1_Floor(2);y1_Floor(2);1];
Image1_Points_Floor(:,3) = [x1_Floor(3);y1_Floor(3);1];
close(fig1)

fig2 = figure;
set(fig2,'Name','Task3_3:Floor Points Selection for Image 2 ','NumberTitle','off')
imshow(image2)
[x2_Floor ,y2_Floor] = ginput(3);
Image2_Points_Floor = zeros(3,3);
Image2_Points_Floor(:,1) = [x2_Floor(1);y2_Floor(1);1];
Image2_Points_Floor(:,2) = [x2_Floor(2);y2_Floor(2);1];
Image2_Points_Floor(:,3) = [x2_Floor(3);y2_Floor(3);1];
close(fig2)

World_Points_Floor = zeros(3,3);
for k = 1:3
    World_Points_Floor(:,k) = triangulation_for_task3_3(Version1.Parameters,Version2.Parameters,Image1_Points_Floor(:,k),Image2_Points_Floor(:,k));
end
if (World_Points_Floor(3,:) < 50) | (World_Points_Floor(3,:) > -50) % Rounding to 0 due to scope of error in selecting the points 
    World_Points_Floor(3,:) = 0;
end

fig3 = figure;
set(fig3,'Name','Task3_3:Wall Points Selection for Image 1 ','NumberTitle','off')
imshow(image1)
[x1_Wall, y1_Wall] = ginput(3);
Image1_Points_Wall = zeros(3,3);
Image1_Points_Wall(:,1) = [x1_Wall(1);y1_Wall(1);1];
Image1_Points_Wall(:,2) = [x1_Wall(2);y1_Wall(2);1];
Image1_Points_Wall(:,3) = [x1_Floor(3);y1_Wall(3);1];
close(fig3)

fig4 = figure;
set(fig4,'Name','Task3_3:Wall Points Selection for Image 2','NumberTitle','off')
imshow(image2)
[x2_Wall ,y2_Wall] = ginput(3);
Image2_Points_Wall = zeros(3,3);
Image2_Points_Wall(:,1) = [x2_Wall(1);y2_Wall(1);1];
Image2_Points_Wall(:,2) = [x2_Wall(2);y2_Wall(2);1];
Image2_Points_Wall(:,3) = [x2_Wall(3);y2_Wall(3);1];
close(fig4)

World_Points_Wall = zeros(3,3);
for k = 1:3
    World_Points_Wall(:,k) = triangulation_for_task3_3(Version1.Parameters,Version2.Parameters,Image1_Points_Wall(:,k),Image2_Points_Wall(:,k));
end
[a,b,c,d]=Plane_3Points(World_Points_Wall(:,1),World_Points_Wall(:,2),World_Points_Wall(:,3));
Plane = [a b c d];
% disp("The equation of the plane is %d x + %d y + %d z + %d", a,b,c,d)

fig5 = figure;
set(fig5,'Name','Task3_3:Doorway Points Selection for Image 1','NumberTitle','off')
imshow(image1)
[x1_Door ,y1_Door] = ginput(2);
Image1_Points_Door = zeros(3,3);
Image1_Points_Door(:,1) = [x1_Door(1);y1_Door(1);1];
Image1_Points_Door(:,2) = [x1_Door(2);y1_Door(2);1];
close(fig5)

fig6 = figure;
set(fig6,'Name','Task3_3:Doorway Points Selection for Image 2','NumberTitle','off')
imshow(image2)
[x2_Door ,y2_Door] = ginput(2);
Image2_Points_Door = zeros(3,3);
Image2_Points_Door(:,1) = [x2_Door(1);y2_Door(1);1];
Image2_Points_Door(:,2) = [x2_Door(2);y2_Door(2);1];
close(fig6)

World_Points_Door = zeros(3,3);
for k = 1:2
    World_Points_Door(:,k) = triangulation_for_task3_3(Version1.Parameters,Version2.Parameters,Image1_Points_Door(:,k),Image2_Points_Door(:,k));
end

height_of_door =  sqrt((World_Points_Door(1,1) - World_Points_Door(1,2))^2 + (World_Points_Door(2,1) - World_Points_Door(2,2))^2);


fig7 = figure;
set(fig7,'Name','Task3_3:Man Points Selection for Image 1','NumberTitle','off')
imshow(image1)
[x1_man ,y1_man] = ginput(2);
Image1_Points_man = zeros(3,3);
Image1_Points_man(:,1) = [x1_man(1);y1_man(1);1];
Image1_Points_man(:,2) = [x1_man(2);y1_man(2);1];
close(fig7)

fig8 = figure;
set(fig8,'Name','Task3_3:Man Points Selection for Image 2','NumberTitle','off')
imshow(image2)
[x2_man ,y2_man] = ginput(2);
Image2_Points_man = zeros(3,3);
Image2_Points_man(:,1) = [x2_man(1);y2_man(1);1];
Image2_Points_man(:,2) = [x2_man(2);y2_man(2);1];
close(fig8)

World_Points_man = zeros(3,2);
for k = 1:2
    World_Points_man(:,k) = triangulation_for_task3_3(Version1.Parameters,Version2.Parameters,Image1_Points_man(:,k),Image2_Points_man(:,k));
end
height_of_man =  sqrt((World_Points_man(1,1) - World_Points_man(1,2))^2 + (World_Points_man(2,1) - World_Points_man(2,2))^2);


fig9 = figure;
set(fig9,'Name','Task3_3:camera way Points Selection for Image 1','NumberTitle','off')
imshow(image1)
[x1_camera ,y1_camera] = ginput(2);
Image1_Points_camera = zeros(3,3);
Image1_Points_camera(:,1) = [x1_camera(1);y1_camera(1);1];
Image1_Points_camera(:,2) = [x1_camera(2);y1_camera(2);1];
close(fig9)

fig10 = figure;
set(fig10,'Name','Task3_3:camera way Points Selection for Image 2','NumberTitle','off')
imshow(image2)
[x2_camera ,y2_camera] = ginput(2);
Image2_Points_camera = zeros(3,3);
Image2_Points_camera(:,1) = [x2_camera(1);y2_camera(1);1];
Image2_Points_camera(:,2) = [x2_camera(2);y2_camera(2);1];
close(fig10)

World_Points_camera = zeros(3,2);
for k = 1:2
    World_Points_camera(:,k) = triangulation_for_task3_3(Version1.Parameters,Version2.Parameters,Image1_Points_camera(:,k),Image2_Points_camera(:,k));
end

height_of_camera =  sqrt((World_Points_camera(1,1) - World_Points_camera(1,2))^2 + (World_Points_camera(2,1) - World_Points_camera(2,2))^2);

end