#NE��ɢ���Ĳ�����С��NC�Ϲҿ������ϳ����ҳ����ܸ�����NO�ϰ���ĸ���
param NE == 80; 		
param NC == 4; 			
param NO; 				

#����tfΪ����ʱ�䣻hiÿ����ɢ���ֵ�ʱ��
var tf >= 1; 			
var hi = tf / NE; 

#����I;V;O		
set I := {1..NE};		
set V := {1..NC};
set O := {1..NO};

#PPPΪ�ϰ���Ķ���λ�ã�CenterPPPΪ�ϰ���ļ������ģ�AREAΪ�ϰ�������
param PPP{i in O, j in {1..4}, k in {1..2}}; 	
param CenterPP{i in O, k in {1..2}}; 			
param AREA{i in O}; 							

#initial_configΪ�����ĳ�ʼλ�ã�terminal_configΪ�����Ľ���λ��
param initial_config {i in {1..(7+NC-1)}}; 		
param terminal_config {i in {1..5}}; 			

#�������ٶȡ��ٶȡ��Ǽ��ٶȡ���λ�ǵ��������
param amax == 0.25;
param vmax == 2.0;
param wmax == 0.5;
param phymax == 0.7;

#�ϳ��͹ҳ��Ĵ�С����
param TN == 0.25;
param TL == 1.5;
param TM == 0.25;
param TB == 1;
param L2 == 3;
param TT1 == 1;
param TT2 == 1;

#������������������λ�ã�ת��ǣ��ٶȣ����ٶȣ���λ�ǣ��Ǽ��ٶ�
var x{i in I, k in V};
var y{i in I, k in V};
var theta{i in I, k in V};
var v{i in I};
var a{i in I};
var phy{i in I};
var w{i in I};

#����ÿ�������ĸ��ǵ�x����ֵ
var AX{i in I, k in V};
var BX{i in I, k in V};
var CX{i in I, k in V};
var DX{i in I, k in V};

#����ÿ�������ĸ��ǵ�y����ֵ
var AY{i in I, k in V};
var BY{i in I, k in V};
var CY{i in I, k in V};
var DY{i in I, k in V};

#��С��Ŀ�����������
minimize objective_:
(x[NE,1] - terminal_config[1])^2 + (y[NE,1] - terminal_config[2])^2;

s.t. time_constraint:
tf <= NE * 0.5;

#����һ����ʾ���������ɢ���ϳ�΢�ַ���

s.t. DIFF_dx1dt {i in {2..NE}}:
x[i,1] - x[i-1,1] = hi * v[i-1] * cos(theta[i-1,1]);

s.t. DIFF_dy1dt {i in {2..NE}}:
y[i,1] - y[i-1,1] = hi * v[i-1] * sin(theta[i-1,1]);

s.t. DIFF_dvdt {i in {2..NE}}:
v[i] - v[i-1] = hi * a[i-1];

s.t. DIFF_dthetadt {i in {2..NE}}:
theta[i,1] - theta[i-1,1] = hi * (tan(phy[i-1])) * v[i-1] / TL;

s.t. DIFF_dphydt {i in {2..NE}}:
phy[i] - phy[i-1] = hi * w[i-1];


#����һ����ʾ���������ɢ�Ĺҳ�΢�ַ���

s.t. DIFF_dtheta2dt {i in {2..NE}}:
theta[i,2] - theta[i-1,2] = hi * (sin(theta[i-1,1] - theta[i-1,2])) * v[i-1] / L2;

s.t. DIFF_dtheta3toNCdt {i in {2..NE}, n in {3..NC}}:
theta[i,n] - theta[i-1,n] = hi * (prod{pp in {1..(n-2)}}(cos(theta[i-1,pp] - theta[i-1,(pp+1)]))) * v[i-1] * sin(theta[i-1,n-1] - theta[i-1,n]) / L2;


#����ϵͳ��΢�ַ���

s.t. Geometric_x_general {pp in {1..(NC-1)}, i in I}:
x[i,pp+1] = x[i,1] - sum{ii in {1..pp}}(L2 * cos(theta[i,ii+1]));

s.t. Geometric_y_general {pp in {1..(NC-1)}, i in I}:
y[i,pp+1] = y[i,1] - sum{ii in {1..pp}}(L2 * sin(theta[i,ii+1]));


s.t. RELATIONSHIP_AX1 {i in I}:
AX[i,1] = x[i,1] + (TL + TN) * cos(theta[i,1]) - TB * sin(theta[i,1]);

s.t. RELATIONSHIP_BX1 {i in I}:
BX[i,1] = x[i,1] + (TL + TN) * cos(theta[i,1]) + TB * sin(theta[i,1]);

s.t. RELATIONSHIP_CX1 {i in I}:
CX[i,1] = x[i,1] - TM * cos(theta[i,1]) + TB * sin(theta[i,1]);

s.t. RELATIONSHIP_DX1 {i in I}:
DX[i,1] = x[i,1] - TM * cos(theta[i,1]) - TB * sin(theta[i,1]);

s.t. RELATIONSHIP_AY1 {i in I}:
AY[i,1] = y[i,1] + (TL + TN) * sin(theta[i,1]) + TB * cos(theta[i,1]);

s.t. RELATIONSHIP_BY1 {i in I}:
BY[i,1] = y[i,1] + (TL + TN) * sin(theta[i,1]) - TB * cos(theta[i,1]);

s.t. RELATIONSHIP_CY1 {i in I}:
CY[i,1] = y[i,1] - TM * sin(theta[i,1]) - TB * cos(theta[i,1]);

s.t. RELATIONSHIP_DY1 {i in I}:
DY[i,1] = y[i,1] - TM * sin(theta[i,1]) + TB * cos(theta[i,1]);


s.t. RELATIONSHIP_AX2toN {pp in {2..NC},i in I}:
AX[i,pp] = x[i,pp] + (TT1) * cos(theta[i,pp]) - TB * sin(theta[i,pp]);

s.t. RELATIONSHIP_BX2toN {pp in {2..NC},i in I}:
BX[i,pp] = x[i,pp] + (TT1) * cos(theta[i,pp]) + TB * sin(theta[i,pp]);

s.t. RELATIONSHIP_CX2toN {pp in {2..NC},i in I}:
CX[i,pp] = x[i,pp] - TT2 * cos(theta[i,pp]) + TB * sin(theta[i,pp]);

s.t. RELATIONSHIP_DX2toN {pp in {2..NC},i in I}:
DX[i,pp] = x[i,pp] - TT2 * cos(theta[i,pp]) - TB * sin(theta[i,pp]);

s.t. RELATIONSHIP_AY2toN {pp in {2..NC},i in I}:
AY[i,pp] = y[i,pp] + TT1 * sin(theta[i,pp]) + TB * cos(theta[i,pp]);

s.t. RELATIONSHIP_BY2toN {pp in {2..NC},i in I}:
BY[i,pp] = y[i,pp] + TT1 * sin(theta[i,pp]) - TB * cos(theta[i,pp]);

s.t. RELATIONSHIP_CY2toN {pp in {2..NC},i in I}:
CY[i,pp] = y[i,pp] - TT2 * sin(theta[i,pp]) - TB * cos(theta[i,pp]);

s.t. RELATIONSHIP_DY2toN {pp in {2..NC},i in I}:
DY[i,pp] = y[i,pp] - TT2 * sin(theta[i,pp]) + TB * cos(theta[i,pp]);


############# Two-point boundary conditions #################### 
s.t. EQ_starting_x :
x[1,1] = initial_config[1];

s.t. EQ_starting_y :
y[1,1] = initial_config[2];

s.t. EQ_starting_theta1 :
theta[1,1] = initial_config[3];

s.t. EQ_starting_theta2 :
theta[1,2] = initial_config[4];

s.t. EQ_starting_theta3 :
theta[1,3] = initial_config[5];

s.t. EQ_starting_theta4 :
theta[1,4] = initial_config[6];

############## Bounded constraints #################### 

s.t. Bonds_v {i in I}:
v[i]^2 <= vmax^2;

s.t. Bonds_phy {i in I}:
phy[i]^2 <= phymax^2;


data;
param NO:= include Number_obstacle;
param: PPP := include Current_vertex;
param: CenterPP := include Center;
param AREA := include Area;
param initial_config := include Initial_config;
param terminal_config :=  include Terminal_config;