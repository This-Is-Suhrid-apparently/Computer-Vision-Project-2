function [sed] = helper_sed(F, points1, points2, n)
%HELPER_SED : This function computes the SED score for the given F and
%points collection

sed = 0.0;
% from cam1 -> cam2
for i=1:length(n)
    epipolar_line = F*points1(:,i);
    sed = sed + sqgd(epipolar_line, points1(:,i));
end

% from cam2 -> cam1
for i=1:length(n)
    epipolar_line = (points2(:,i)'*F)';
    sed = sed + sqgd(epipolar_line, points2(:,i));
end

end

function [res] = sqgd(line, point)
    a = line(1,1);
    b = line(2,1);
    c = line(3,1);
    res = (a*point(1,1) + b*point(2,1) + c)^2 / (a*a + b*b);
end

