%%将粗细管的数据合在一起

clc;clear all;close all;
% 1021数据集
filename_xi='E:\故障诊断\数据集处理\1021\数据处理结果\20240119_trend_feature\feature_xi_22.xlsx';
feature_xi=xlsread(filename_xi,1);

num_windows_xi=size(feature_xi,1);% feature_1021的行数
x1=1:num_windows_xi;
% 1022数据集
filename_cu='E:\故障诊断\数据集处理\1021\数据处理结果\20240119_trend_feature\feature_cu_22.xlsx';
feature_cu=xlsread(filename_cu,1);

num_windows_cu=size(feature_cu,1);% feature_1022的行数
x2=1:num_windows_cu;

data_set=[feature_xi;feature_cu];
filename='E:\故障诊断\数据集处理\1021\数据处理结果\20240119_trend_feature\feature_together_22.xlsx';
writematrix(data_set, filename);