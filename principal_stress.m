clc
clear
close all

X=input('enter normal stress X (Mpa)=');
Y=input('enter normal stress Y (Mpa)=');
Z=input('enter normal stress Z (Mpa)=');
XY=input('enter shear stress XY (Mpa)=');
YZ=input('enter shear stress YZ (Mpa)=');
XZ=input('enter shear stress XZ (Mpa)=');
Sy=input('enter Sy =');
St=input('enter St (tension)=');
Sc=input('enter Sc (compression)=');
if XY~=0
    TETAp_XY=(1/2)*atan((2*XY)/(X-Y));
    Xprime0=((X+Y)/2)+(((X-Y)/2)*cos(2*TETAp_XY))+(XY*sin(2*TETAp_XY));
    Yprime0=((X+Y)/2)-(((X-Y)/2)*cos(2*TETAp_XY))-(XY*sin(2*TETAp_XY));
    X=Xprime0;
    Y=Yprime0;
end

if YZ~=0
    TETAp_YZ=(1/2)*atan((2*YZ)/(Y-Z));
    Yprime1=((Y+Z)/2)+(((Y-Z)/2)*cos(2*TETAp_YZ))+(YZ*sin(2*TETAp_YZ));
    Zprime1=((Y+Z)/2)-(((Y-Z)/2)*cos(2*TETAp_YZ))-(YZ*sin(2*TETAp_YZ));
    Y=Yprime1;
    Z=Zprime1;
end
if XZ~=0
    TETAp_XZ=(1/2)*atan((2*XZ)/(Z-X));
    Zprime2=((Z+X)/2)+(((Z-X)/2)*cos(2*TETAp_XZ))+(XZ*sin(2*TETAp_XZ));
    Xprime2=((Z+X)/2)-(((Z-X)/2)*cos(2*TETAp_XZ))-(XZ*sin(2*TETAp_XZ));
    Z=Zprime2;
    X=Xprime2;
end

vector=[X Y Z];
a=min(vector);
b=max(vector);
MSS=(b-a)/2;
mss=num2str(MSS);
Table= table([X ; Y;Z],'VariableNames',{'PRINCIPAL_STRESS'});
disp(Table)
disp(['maximum Shear Stress =' mss])

n0=Sy/(2*MSS); %teresca or MSS (maximum shear stress (for ductile))
vonMisesStress=(((X-Y)^2+(X-Z)^2+(Y-Z)^2)/2)^(1/2);
n1=Sy/vonMisesStress; %vonMises or DE (distortion energy (for ductile))
n2=1/( (b/St)-(a/Sc) ); %Coulomb-Mohr or DCM (for ductile)
Table1= table(['MSS';'DE_';'DCM'],[n0;n1;n2],'VariableNames',{'method','factor_of_safety_n'});
disp(Table1)