
function [SED_F_Calc,SED_F_eightpoint] = task3_6(points_left,points_right,F_calc,F_eightpoint)

SED_F_Calc = helper_sed(F_calc,points_left, points_right, length(points_right));

SED_F_eightpoint = helper_sed(F_eightpoint,points_left, points_right, length(points_right));

end
