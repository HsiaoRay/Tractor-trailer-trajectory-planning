clear
clc
close
%%
%%�����ϰ��ﶥ���λ��
global polygon_obstacle_vertex
%%
%%������ʱ���Ϲҿ����Ĳ������ϳ���λ�á������������ֵķ�λ�ǡ��ٶȼ��ٶȣ�
x0_1 = -10;         
y0_1 = -17;         
theta0_1 = 0;      
theta0_2 = 0;      
theta0_3 = 0;      
theta0_4 = 0;      
v_0 = 0;             
a_0 = 0; 
%%
%%�������ʱ�̳���ֹͣ��λ�á��ٶȡ����ٶ��Լ��Ǽ��ٶ�
x_center_tf = 12;       
y_center_tf = 0;         
v_tf = 0;                   
a_tf = 0;                    
w_tf = 0;                   
%%
%%����ͼ5-1��5-2
%%���ϰ���Ķ��㸳ֵ���������ÿ���ϰ������ĸ����㡣�������������ϰ���Ļ�������Ӧ��24��Ԫ�أ�
%polygon_obstacle_vertex = [0,2,20,2,20,20,0,20,-5,-1.8,20,-1.8,20,-30,-5,-30]; 
%%����ʼĩ״̬�ĸ�ֵ��boundary_constraints = [x0_1, y0_1, theta0_1, theta0_2, theta0_3, theta0_4, phy_0, v_0, a_0, w_0, x_center_tf, y_center_tf, v_tf, a_tf, w_tf];
%boundary_constraints = [-10,-10,pi/2,pi/2,pi/2,pi/2,0,0,0,0,8,0,0,0,0]; 

%%����ͼ5-3
%polygon_obstacle_vertex = [0,2,20,2,20,20,0,20,-5,-1.8,20,-1.8,20,-30,-5,-30];
%boundary_constraints = [-7,-10,pi/2,pi/2,pi/2,pi/2,0,0,0,0,8,0,0,0,0];

%%����ͼ5-4
%polygon_obstacle_vertex = [-20 -15 -10 -15 -5 0 -20 5 0 -20 20 -20 20 -2 -2 -2];
%boundary_constraints = [-10,-17,0,0,0,0,0,0,0,0,12,0,0,0,0];

%%����ͼ5-5
polygon_obstacle_vertex = [-12.81,4,-11.56,1.01,-15.19,-2.2,-25,4,     -9,5.12,-6,15,5,10,-3.52,1.21,    0.47,-2.18,0.38,-8,-4.47,-8,-4.38,-1.94,    -13,-3,-8,-0.5,-5,-5-8,-13,-4-8];
boundary_constraints = [-10,10,0,0,0,0,0,0,0,0,0,0,0,0,0];

%%����ͼ5-6
%polygon_obstacle_vertex = [-12.81,4,-11.56,1.01,-15.19,-2.2,-25,4,     -9,5.12,-6,15,5,10,-3.52,1.21,    0.47,-2.18,0.38,-8,-4.47,-8,-4.38,-1.94,    -13,-3,-8,-0.5,-5,-5-8,-13,-4-8];
%boundary_constraints = [5,0,pi,pi,pi,pi,0,0,0,0,-25,15,0,0,0];
%%
%%�ж�����������ϰ��ﶥ��λ�úͳ���ʼĩ״ֵ̬Ԫ�ظ����Ƿ���ȷ
if (mod(length(polygon_obstacle_vertex), 8) ~= 0)
    error obstacle vertex size wrong
end
if (length(boundary_constraints) ~= 15)
    error two-point boundary conditions wrong
end
%%
%%���ú������ֱ𴢴濪ʼ�ͽ����ĳ������ò����������ļ�
SetTwoPointBoundaryConditionsToFiles (boundary_constraints);
%%
%%����Ӧͬ��������
AdaptivelyHomotopicWarmStartingApproach;
%%
if (is_success)
    figure (101)
    plot(store_gamma);
    xlabel('Number of Cycle');
    ylabel('\gamma_a_c_h_i_e_v_e_d')
    title('Evolution of \gamma_a_c_h_i_e_v_e_d');
    
    figure (102)
    plot(store_step);
    xlabel('Number of Cycle');
    ylabel('step')
    title('Evolution of step');
    
    figure (103)
    DrawTrajectories; 
   
end
