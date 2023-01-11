% Coded and compiled by Suhrid Das

function F = task3_4(Parameters1,Parameters2,image1,image2)

Version1 = load('Parameters_V1_1.mat'); % Loading the version1 Parameters for image 1 
Version2 = load('Parameters_V2_1.mat'); % Loading the version1 Parameters for image 2

R1= Parameters1.Rmat;
c1 = Parameters1.position';
K1 = Parameters1.Kmat;

R2= Parameters2.Rmat;
c2 = Parameters2.position';
K2 = Parameters2.Kmat;

cord = [eye(3) -c1;0 0 0 1];

T = [R1 [0 0 0]';0 0 0 1]*cord*[c2;1];

T = T/norm(T);

S = [0 -T(3) T(2);T(3) 0 -T(1);-T(2) T(1) 0];

R_2in1 = R2*R1';

E = R_2in1*S;

F = inv(K2)'*E*inv(K1);



figure(1); imagesc(image1); axis image; drawnow;
figure(2); imagesc(image2); axis image; drawnow;


figure(1); [x1,y1] = getpts;
figure(1); imagesc(image1); axis image; hold on
for i=1:length(x1)
   h=plot(x1(i),y1(i),'*'); set(h,'Color','g','LineWidth',2);
   text(x1(i),y1(i),sprintf('%d',i));
end
hold off
drawnow;

figure(2); imagesc(image2); axis image; drawnow;
[x2,y2] = getpts;
figure(2); imagesc(image2); axis image; hold on
for i=1:length(x2)
   h=plot(x2(i),y2(i),'*'); set(h,'Color','g','LineWidth',2);
   text(x2(i),y2(i),sprintf('%d',i));
end
hold off
drawnow;


colors =  'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';
%overlay epipolar lines on im2
L = F * [x1' ; y1'; ones(size(x1'))];
[nr,nc,nb] = size(image2);
figure(2); clf; imagesc(image2); axis image;
hold on; plot(x2,y2,'*'); hold off
for i=1:length(L)
    a = L(1,i); b = L(2,i); c=L(3,i);
    if (abs(a) > (abs(b)))
       ylo=0; yhi=nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on
       h=plot([xlo; xhi],[ylo; yhi]);
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    else
       xlo=0; xhi=nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    end
end


%overlay epipolar lines on im1
L = ([x2' ; y2'; ones(size(x2'))]' * F)' ;
[nr,nc,nb] = size(image1);
figure(1); clf; imagesc(image1); axis image;
hold on; plot(x1,y1,'*'); hold off
for i=1:length(L)
    a = L(1,i); b = L(2,i); c=L(3,i);
    if (abs(a) > (abs(b)))
       ylo=0; yhi=nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    else
       xlo=0; xhi=nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    end
end


for j=1:3
    for i=1:3
        fprintf('%10g ',10000*F(j,i));
    end
    fprintf('\n');
end

end