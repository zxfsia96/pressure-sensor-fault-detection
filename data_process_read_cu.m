clear ;
close all;
% 读取Excel文件  
excel_file = 'E:\故障诊断\数据集处理\1021\算法\PYTHON\12\output_cu.xlsx';  
% data = readtable(excel_file);  
filename_output_cu='E:\故障诊断\feature_cu_22_m.xlsx'; 
num=22;
A = cell(num,1);
data_table=[];
for m=1:num
    Temp=xlsread(excel_file,['Sheet', num2str(m)]); % 读取每个Sheet中的数据
    A{m}=Temp;
    window_size_1 = 2000;
    data_length_1 = length(Temp);
    step=1000;
    % 计算窗口数量
    num_windows_1 =1+fix((data_length_1-window_size_1)/step);
    % 初始化一个数组，用于存储滑动窗口的数据
    windowed_data_1 = cell(window_size_1, num_windows_1);
    % 通过循环实现滑动窗口的移动
    for i = 1:num_windows_1
        start_index = (i - 1) * step + 1;
        end_index = start_index + window_size_1 - 1;
%         start_index = end_idx_1(i);
%         end_index = end_idx_1(i+1);
    %     windowed_data(:, i) = filtered_signal(start_index:end_index);
        windowed_data_1(i)  = {Temp(start_index:end_index)};
        peakToPeakValue_1(i) = peak2peak(cell2mat(windowed_data_1(i)));
        amplitude_1(i) = max(abs(cell2mat(windowed_data_1)));
        windowed_va_1(i) = var(cell2mat(windowed_data_1) );    % 方差
        windowed_rms_1(i) = rms(cell2mat(windowed_data_1) );    % 均方根：
        windowed_ku_1(i) = kurtosis(cell2mat(windowed_data_1) );   %峭度
        windowed_av_1(i) = mean(abs(cell2mat(windowed_data_1) ));    %绝对值的平均值(整流平均值)
        windowed_S_1(i) = windowed_rms_1(i)/ windowed_av_1(i);    % S = rm/av;			%波形因子
        windowed_C_1(i) = peakToPeakValue_1(i)/ windowed_rms_1(i);    % C = pk/rm;			%峰值因子
        windowed_I_1(i) = peakToPeakValue_1(i)/ windowed_av_1(i);    % I = pk/av;			%脉冲因子

        windowed_xr_1(i) = mean(sqrt(abs(cell2mat(windowed_data_1))))^2;    % xr = mean(sqrt(abs(y)))^2;
        windowed_L_1(i) = peakToPeakValue_1(i)/ windowed_xr_1(i);    % L = pk/xr;			%裕度因子
        %频谱
        Fs=20;
        X = cell2mat(windowed_data_1);
        L= length(X);
        Y = fft(X);
        P2=abs(Y/L);
        P1=P2(1:L/2+1);
        P1(2:end-1)=2*P1(2:end-1);
        f=Fs*(0:(L/2))/L;
        %% 基于频谱图提取频域特征
        %% 特征1：频域幅值平均值AF_AM，重点在能量
        FDF.AF_AM_1(i) = mean(P1);
        %% 特征2：重心频率AF_CF，重点在频率
        FDF.AF_CF_1(i)  = sum(f'.*P1)/sum(P1);
        %% 特征3：均方频率AF_MSF
        FDF.AF_MSF_1(i)  = sum((f.*f)'.*P1)/sum(P1);
        %% 特征4：均方根频率AF_RMSF
        FDF.AF_RMSF_1(i)  = sqrt(sum((f.*f)'.*P1)/sum(P1));
        %% 特征5：频率方差AF_FVAR
        FDF.AF_FVAR_1(i)  = sum(((f-FDF.AF_CF_1(i)).^2)'.*P1)/sum(P1);
        %%基于功率谱图提取频域特征.稳定性更好一些
        P1S_1=P1.*P1;
        %% 特征6：平均频率PS_MNF
        FDF.PS_MNF_1(i) = sum(f'.*P1S_1)/sum(P1S_1);
        %% 特征7：总功率PS_TP
        FDF.PS_TP_1(i)=sum(P1S_1);
        %% 特征8：平均功率PS_MNP
        FDF.PS_MNP_1(i)=mean(P1S_1);
    end
    num_1 =1:num_windows_1;
    lable_1(1:num_windows_1)=(0);
    data_table_1 = table(num_1',FDF.AF_AM_1', FDF.AF_CF_1',FDF.AF_MSF_1',FDF.AF_RMSF_1',FDF.AF_FVAR_1', FDF.PS_MNF_1',FDF.PS_TP_1',FDF.PS_MNP_1', ...
        peakToPeakValue_1',amplitude_1',windowed_va_1',windowed_rms_1',windowed_ku_1',windowed_av_1',windowed_S_1',windowed_C_1',windowed_I_1',windowed_L_1',lable_1', ...
        'VariableNames', {'序号','频域幅值平均值', '重心频率','均方频率','方差频率','频率方差','平均频率','总功率','平均功率','峰峰值','幅值','方差','均方根','峭度','绝对值的平均值(整流平均值)','波形因子','峰值因子','脉冲因子','裕度因子','标签'});
    data_table=[data_table;data_table_1];
    writetable(data_table, filename_output_cu, 'Sheet', 'Data', 'WriteRowNames', true);
    
    clearvars('-except', 'm','num','A','excel_file','filename_output_cu','data_table')
end

