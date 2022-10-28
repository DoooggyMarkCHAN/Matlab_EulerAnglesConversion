function OutPutEulerAngle = EulerAngleConversion(Eul_input,Seq_in,Seq_out)
%Eul_input is the Array of input Euler Angles
%Such as [Angle_X, Angle_Y, Angle_Z]
%Seq_in is the sequence of rotation of the input Euler Angles, can be:
%"XYZ", "XZY", "YXZ", "YZX", "ZXY" and "ZYX"
%Seq_out is the sequence of rotation of the out Euler Angles, can be:
%"XYZ", "XZY", "YXZ", "YZX", "ZXY" and "ZYX"

Eul_input=Eul_input/180*pi;

theta_x = Eul_input(1);
theta_y = Eul_input(2);
theta_z = Eul_input(3);

R_X = [1,0,0;0,cos(theta_x),-sin(theta_x);0,sin(theta_x),cos(theta_x)];
R_Y = [cos(theta_y),0,sin(theta_y);0,1,0;-sin(theta_y),0,cos(theta_y)];
R_Z = [cos(theta_z),-sin(theta_z),0;sin(theta_z),cos(theta_z),0;0,0,1];

syms A B C
R_x = [1,0,0;0,cos(A),-sin(A);0,sin(A),cos(A)];
R_y = [cos(B),0,sin(B);0,1,0;-sin(B),0,cos(B)];
R_z = [cos(C),-sin(C),0;sin(C),cos(C),0;0,0,1];
R_XYZ = R_x*R_y*R_z;
R_XZY = R_x*R_z*R_y;
R_YXZ = R_y*R_x*R_z;
R_YZX = R_y*R_z*R_x;
R_ZXY = R_z*R_x*R_y;
R_ZYX = R_z*R_y*R_x;

switch Seq_in
    case "XYZ"
        R_mat = R_X*R_Y*R_Z;
    case "XZY"
        R_mat = R_X*R_Z*R_Y;
    case "YXZ"
        R_mat = R_Y*R_X*R_Z;
    case "YZX"
        R_mat = R_Y*R_Z*R_X;
    case "ZXY"
        R_mat = R_Z*R_X*R_Y;
    case "ZYX"
        R_mat = R_Z*R_Y*R_X;
end

switch Seq_out
    case "XYZ"
        [a,b,c]=vpasolve([R_XYZ(1,2)==R_mat(1,2),R_XYZ(1,3)==R_mat(1,3),R_XYZ(2,3)==R_mat(2,3)],[A,B,C],Eul_input);
    case "XZY"
        [a,b,c]=vpasolve([R_XZY(1,1)==R_mat(1,1),R_XZY(1,2)==R_mat(1,2),R_XZY(2,2)==R_mat(2,2)],[A,B,C],Eul_input);
    case "YXZ"
        [a,b,c]=vpasolve([R_YXZ(2,2)==R_mat(2,2),R_YXZ(2,3)==R_mat(2,3),R_YXZ(3,3)==R_mat(3,3)],[A,B,C],Eul_input);
    case "YZX"
        [a,b,c]=vpasolve([R_YZX(1,1)==R_mat(1,1),R_YZX(2,1)==R_mat(2,1),R_YZX(2,2)==R_mat(2,2)],[A,B,C],Eul_input);
    case "ZXY"
        [a,b,c]=vpasolve([R_ZXY(2,2)==R_mat(2,2),R_ZXY(3,2)==R_mat(3,2),R_ZXY(3,3)==R_mat(3,3)],[A,B,C],Eul_input);
    case "ZYX"
        [a,b,c]=vpasolve([R_ZYX(2,1)==R_mat(2,1),R_ZYX(3,1)==R_mat(3,1),R_ZYX(3,2)==R_mat(3,2)],[A,B,C],Eul_input);
end

a=eval(mod(a,2*pi));
b=eval(mod(b,2*pi));
c=eval(mod(c,2*pi));
if a>pi
    a = a-2*pi;
end
if b>pi
    b = b-2*pi;
end
if c>pi
    c = c-2*pi;
end
Eul_Output=[a,b,c];
Eul_Output_deg=Eul_Output*180/pi;
OutPutEulerAngle=Eul_Output_deg;

end
