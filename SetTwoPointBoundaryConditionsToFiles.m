
%%����SetTwoPointBoundaryConditionsToFiles�����Ķ���
function SetTwoPointBoundaryConditionsToFiles(vector)

warning off

 X1 = vector(1 : 10);
 X2 = vector(11 : 15);
 %%
 %%���泵���Ŀ�ʼ���õ�'Initial_config'
delete('Initial_config');
fid = fopen('Initial_config', 'w');
for ii = 1 : length(X1)
    fprintf(fid,'%g  %f \r\n', ii, X1(ii));
end
fclose(fid);
%%���泵���Ľ������õ�'Terminal_config'
delete('Terminal_config');
fid = fopen('Terminal_config', 'w');
for ii = 1 : length(X2)
    fprintf(fid,'%g  %f \r\n', ii, X2(ii));
end
fclose(fid);