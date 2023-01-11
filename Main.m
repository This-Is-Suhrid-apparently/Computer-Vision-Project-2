
clc;clear;close
%% TASK 3_1
%Loading the images 
image1 = imread('im1corrected.jpg');
image2= imread('im2corrected.jpg');

load('mocapPoints3D.mat'); %Loading the original 3D world points 

Version1 = load('Parameters_V1_1.mat'); % Loading the version1 Parameters for image 1 

[u1_dash,v1_dash,w1_dash] = task3_1(pts3D,Version1.Parameters,image1); % Performing the task 3_1 using versison 1 Parameters
PC1 = [u1_dash;v1_dash;w1_dash];
u1 = u1_dash./w1_dash;
v1 = v1_dash./w1_dash;
TwoD_Points_left= [u1;v1;ones(1,length(u1))];

Version2 = load('Parameters_V2_1.mat'); % Loading the version2 Parameters for image 2 

[u2_dash,v2_dash,w2_dash] = task3_1(pts3D,Version2.Parameters,image2); % Performing the task 3_1 using versison 2 Parameters
PC2 = [u2_dash;v2_dash;w2_dash];
u2 = u2_dash./w2_dash;
v2 = v2_dash./w2_dash;
TwoD_Points_right= [u2;v2;ones(1,length(u2))];

%% TASK 3_2
Pw = task3_2(PC1,PC2,Version1.Parameters,Version2.Parameters); % Performing task3_2- Recontructiion of 3D world co-ordinates
error = mse(Pw,pts3D);
fprintf('The reconstruction error is %d',error);

%% TASK 3_3
 [Plane,height_of_door,height_of_man,height_of_camera,World_Points_Floor] =  task3_3(image1,image2);
 if World_Points_Floor(3,:) == 0
     disp('After selecting 3 points on floor, we get Z = 0')
 end
fprintf('The Height of door is %d\n',height_of_door);
fprintf('The Height of Man is %d\n',height_of_man);
fprintf('The Height of camera is %f\n',height_of_camera);
fprintf('The equation of plane is %f x + %f y + %f z + %d = 0\n',Plane(1)/1e5,Plane(2)/1e5,Plane(3)/1e5,Plane(4)/1e5);

%% TASK 3_4
F_calculated = task3_4(Version1.Parameters,Version2.Parameters,image1,image2);

%%  TASK 3_5
F_eightpoint = task3_5(image1,image2);

%% TASK 3_6

[SED_F_Calc,SED_F_Eightpoint] = task3_6(TwoD_Points_left,TwoD_Points_right,F_calculated,F_eightpoint);
fprintf('The SED for F_Calculated is %d\n',SED_F_Calc);
fprintf('The SED for F_eightpoint is %d\n',SED_F_Eightpoint);
if SED_F_Calc < SED_F_Eightpoint
    disp('The SED of F_calculated is less than SED of F_eightpoint.')
end

%% TASK 3_7
task3_7(Version1.Parameters,image1)

%% TASK EXTRA CREDIT

task_extra_credit();
