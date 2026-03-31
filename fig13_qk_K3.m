clear all;
for lambdap=1:2
simulation_AoI=[];
analysis_AoI=[];
sim_success_Pr=[];
ana_success_Pr=[];
simulation_AoI321=[];
analysis_AoI321=[];
sim_success_Pr321=[];
ana_success_Pr321=[];
% qarr1 = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
% qarr2 = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
% arrptx= [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];

% qarr1 = [0.01, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, ...
%          0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95];
% qarr2 = [0.01, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, ...
%          0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95];
% arrptx=[0.01, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, ...
%          0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95];

qarr1=[0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29, 0.3, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39, 0.4, 0.41, 0.42, 0.43, 0.44, 0.45, 0.46, 0.47, 0.48, 0.49, 0.5, 0.51, 0.52, 0.53, 0.54, 0.55, 0.56, 0.57, 0.58, 0.59, 0.6, 0.61, 0.62, 0.63, 0.64, 0.65, 0.66, 0.67, 0.68, 0.69, 0.7, 0.71, 0.72, 0.73, 0.74, 0.75, 0.76, 0.77, 0.78, 0.79, 0.8, 0.81, 0.82, 0.83, 0.84, 0.85, 0.86, 0.87, 0.88, 0.89, 0.9, 0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99];
qarr2=[0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29, 0.3, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39, 0.4, 0.41, 0.42, 0.43, 0.44, 0.45, 0.46, 0.47, 0.48, 0.49, 0.5, 0.51, 0.52, 0.53, 0.54, 0.55, 0.56, 0.57, 0.58, 0.59, 0.6, 0.61, 0.62, 0.63, 0.64, 0.65, 0.66, 0.67, 0.68, 0.69, 0.7, 0.71, 0.72, 0.73, 0.74, 0.75, 0.76, 0.77, 0.78, 0.79, 0.8, 0.81, 0.82, 0.83, 0.84, 0.85, 0.86, 0.87, 0.88, 0.89, 0.9, 0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99];
arrptx=[0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29, 0.3, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39, 0.4, 0.41, 0.42, 0.43, 0.44, 0.45, 0.46, 0.47, 0.48, 0.49, 0.5, 0.51, 0.52, 0.53, 0.54, 0.55, 0.56, 0.57, 0.58, 0.59, 0.6, 0.61, 0.62, 0.63, 0.64, 0.65, 0.66, 0.67, 0.68, 0.69, 0.7, 0.71, 0.72, 0.73, 0.74, 0.75, 0.76, 0.77, 0.78, 0.79, 0.8, 0.81, 0.82, 0.83, 0.84, 0.85, 0.86, 0.87, 0.88, 0.89, 0.9, 0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99];


gnrt1 = zeros(length(qarr2), length(qarr2)); % 存储g的值


ptxarr = zeros(length(qarr1),length(qarr2));        

for cir1=1:length(qarr1)
    
    num_itr = 10;%总时隙数

    for cir2=1:length(qarr2)
        Psnr=20;
        Karr=[2 6];
        Marr=[2 8 4 5 6];
        T=0.5;%时隙长度
        M=Marr(lambdap);%总用户数
        R = 0.1;
        eps = 2^R-1;
        K=3;%要注意K的变换，要引起用户选择范围的概率
        transMatrix = zeros(M+1, M+1);
        lambda=0.4;
        if qarr1(cir1)+qarr2(cir2)>=1
            q=[0 0 0];
        else
            q=[qarr1(cir1) qarr2(cir2) 1-qarr1(cir1)-qarr2(cir2)];
        end
        for cir3=1:length(qarr2)
            
        p=arrptx(cir3);%信源选择发送数据的概率；

        Pi_1k = zeros(1, M);

        data_arrayM = binornd(1, lambda, M, num_itr );% M个用户进行num_itr次二项分布将结果放入M个行向量中,表示数据到达
        data_arrayM_save= data_arrayM;
        sent_arrayM = binornd(1, p, M, num_itr ); % 表示是否选择发送

        t=zeros(1, K);
        t(K)=eps;%接收信噪比的设置值；
        for i= (K-1):-1:1
            t(i) = eps*(1+(M-1)*t(i+1));
        end
        snr=10^(Psnr/10);

        sump=0;
        for i=1:K
            sump=sump+p*(q(i)*exp(-t(i)/snr));
        end

        for i=1:K
            q(i)=p*q(i)*exp(-t(i)/snr)/sump;%新的q
        end


        p=sump;%新的
       

        %NRT-ana
        res0321=0;res321=0;res1321=0;res2321=0;res3321=0;res4321=0;res5321=0;res6321=0;res7321=0;res8321=0;
        for e = 3 : M %活跃用户数为e
            if e>K
                min12=K-1;
            else
                min12=e;
            end
            for x=2:min12%活跃用户中成功传输的用户数为x
                for k1 = 1:(K-x+1)
                    for k2 = (k1+x-1):K
                        if  x==K %注意该条件
                            f=1*factorial(x)*nchoosek(e-1, x-1);
                        else
                            if (e-x)==0%因为求res3时，0*0^(-1)=Nan，所以单独列一个
                                f=1*factorial(x)*nchoosek(e-1, x-1);
                            else
                                for l=1:k2%q的前k2项的和
                                    res1321= res1321 + q(l);
                                end
                                for s=(k2+1):K
                                    for t=1:s
                                        res2321 = res2321 + q(t);
                                    end
                                    res3321 = res3321+(e-x)*q(s)*(1-res2321)^(e-x-1);
                                    res2321 = 0;
                                end
                                f=((1-res1321)^(e-x)-res3321)*factorial(x)*nchoosek(e-1, x-1);
                                res1321 = 0;res3321 = 0;
                            end
                        end

                        if (x-2)>=1
                            for n1 = (k1+1):(k2-x+2)
                                if (x-2)>=2
                                    for n2 = (n1+1):(k2-x+3)
                                        if (x-2)>=3
                                            for n3 = (n2+1):(k2-x+4)
                                                if (x-2)>=4
                                                    for n4 = (n3+1):(k2-x+5)
                                                        if (x-2)>=5
                                                            for n5 = (n4+1):(k2-x+6)
                                                                if (x-2)>=6
                                                                    for n6 = (n5+1):(k2-x+7)
                                                                        if (x-2)>=7
                                                                            for n7 = (n6+1):(k2-x+8)
                                                                                if (x-2)>=8
                                                                                    for n8 = (n7+1):(k2-x+9)
                                                                                        if (x-2)>=9
                                                                                            for n9 = (n8+1):(k2-x+10)
                                                                                                if (x-2)>=10
                                                                                                    for n10 = (n9+1):(k2-x+11)
                                                                                                        res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8)*q(n9)*q(n10);
                                                                                                    end
                                                                                                else
                                                                                                    res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8)*q(n9);
                                                                                                end
                                                                                            end
                                                                                        else
                                                                                            res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8);
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n7);
                                                                                end
                                                                            end
                                                                        else
                                                                            res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6);
                                                                        end
                                                                    end
                                                                else
                                                                    res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4)*q(n5);
                                                                end
                                                            end
                                                        else
                                                            res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4);
                                                        end
                                                    end
                                                else
                                                    res0321 = res0321+q(n1)*q(n2)*q(n3);
                                                end
                                            end
                                        else
                                            res0321 = res0321+q(n1)*q(n2);
                                        end
                                    end
                                else
                                    res0321 = res0321+q(n1);
                                end
                            end
                        else%x==2
                            res0321=1;
                        end
                        if e-x==1%为了排除P{x|e=x+1}=0；
                            f=0;
                        end
                        res4321 = res4321 + q(k1)*q(k2)*res0321*f;%ps2关于x的累加
                        res0321=0;
                    end
                end
            end

            %x=1,e>=3时
            for k=1:K
                for l=1:k
                    res5321= res5321+q(l);
                end
                for s=(k+1):K
                    for t=1:s
                        res6321 = res6321+q(t);
                    end
                    res7321 = res7321 + (e-1)*q(s)*(1-res6321)^(e-2);
                    res6321=0;
                end
                res8321= res8321 + q(k)*((1-res5321)^(e-1)-res7321);%ps1
                res5321 = 0;res7321=0;
            end

            res321 = res321 + nchoosek(M-1, e-1)*(lambda*p)^e*(1-lambda*p)^(M-e)*(res8321+res4321);
            res4321=0;res8321=0;
        end

        symsum=0;%e=2时
        for r=1:K
            symsum =symsum + (lambda*p)^2*(1-lambda*p)^(M-2)*nchoosek(M-1, 1)*q(r)*(1-q(r));%ps3
        end

        ps321=lambda*p*(1-lambda*p)^(M-1) + symsum + res321;
        symsum=0;res321=0;
        Y321=T/ps321;%E(Y)
        Y2321=T^2*(2-ps321)/ps321^2;%E(Y^2)


        poi_gs_m321 = T+Y2321/Y321/2;%%Average AoI
        analysis_AoI321=[analysis_AoI321 poi_gs_m321];
        end
        if any(isnan(analysis_AoI321))
            ptxarr(cir1,cir2)= NaN;  % 如果sumarr中有NaN，将i设置为NaN
        else
            [min_value, index] = min(analysis_AoI321(1:length(qarr2))); 
            ptxarr(cir1,cir2)=arrptx(index);
        end
        analysis_AoI321=[];
end
end

for cir1=1:length(qarr1)
            for cir2=1:length(qarr1)
            Marr=[2 8 16 32];
            M=Marr(lambdap);%总用户数
            R = 0.1;
            eps = 2^R-1;
            K=3;%要注意K的变换，要引起用户选择范围的概率
            R=0.1;
            eps = 2^R-1;
            transMatrix = zeros(M+1, M+1);
%             lambda=0.4;%数据到达以伯努利过程输入，对称结构；
            p=ptxarr(cir1,cir2);
            Pi_1k = zeros(1, M);
            
            if qarr1(cir1)+qarr2(cir2)>=1
                q=[0 0 0];
            else
             q=[qarr1(cir1) qarr2(cir2) 1-qarr1(cir1)-qarr2(cir2)];
            end
            data_arrayM = binornd(1, lambda, M, num_itr );% M个用户进行num_itr次二项分布将结果放入M个行向量中,表示数据到达
            data_arrayM_save= data_arrayM;
            sent_arrayM = binornd(1, p, M, num_itr ); % 表示是否选择发送

            t=zeros(1, K);
            t(K)=eps;%接收信噪比的设置值；
            for i= (K-1):-1:1
                t(i) = eps*(1+(M-1)*t(i+1));
            end
            snr=10^(Psnr/10);

            choice_a_user = zeros(K, num_itr);           

            sump=0;
            for i=1:K
                sump=sump+p*(q(i)*exp(-t(i)/snr));
            end

            for i=1:K
                q(i)=p*q(i)*exp(-t(i)/snr)/sump;%新的q
            end

            p=sump;%新的p

            %NRT-ana
            res0321=0;res321=0;res1321=0;res2321=0;res3321=0;res4321=0;res5321=0;res6321=0;res7321=0;res8321=0;
            for e = 3 : M %活跃用户数为e
                if e>K
                    min12=K-1;
                else
                    min12=e;
                end
                for x=2:min12%活跃用户中成功传输的用户数为x
                    for k1 = 1:(K-x+1)
                        for k2 = (k1+x-1):K
                            if x==K %注意该条件
                                f=1*factorial(x)*nchoosek(e-1, x-1);
                            else
                                if (e-x)==0%因为求res3时，0*0^(-1)=Nan，所以单独列一个
                                    f=1*factorial(x)*nchoosek(e-1, x-1);
                                else
                                    for l=1:k2%q的前k2项的和
                                        res1321= res1321 + q(l);
                                    end
                                    for s=(k2+1):K
                                        for t=1:s
                                            res2321 = res2321 + q(t);
                                        end
                                        res3321 = res3321+(e-x)*q(s)*(1-res2321)^(e-x-1);
                                        res2321 = 0;
                                    end
                                    f=[(1-res1321)^(e-x)-res3321]*factorial(x)*nchoosek(e-1, x-1);
                                    res1321 = 0;res3321 = 0;
                                end
                            end

                            if (x-2)>=1
                                for n1 = (k1+1):(k2-x+2)
                                    if (x-2)>=2
                                        for n2 = (n1+1):(k2-x+3)
                                            if (x-2)>=3
                                                for n3 = (n2+1):(k2-x+4)
                                                    if (x-2)>=4
                                                        for n4 = (n3+1):(k2-x+5)
                                                            if (x-2)>=5
                                                                for n5 = (n4+1):(k2-x+6)
                                                                    if (x-2)>=6
                                                                        for n6 = (n5+1):(k2-x+7)
                                                                            if (x-2)>=7
                                                                                for n7 = (n6+1):(k2-x+8)
                                                                                    if (x-2)>=8
                                                                                        for n8 = (n7+1):(k2-x+9)
                                                                                            if (x-2)>=9
                                                                                                for n9 = (n8+1):(k2-x+10)
                                                                                                    if (x-2)>=10
                                                                                                        for n10 = (n9+1):(k2-x+11)
                                                                                                            res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8)*q(n9)*q(n10);
                                                                                                        end
                                                                                                    else
                                                                                                        res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8)*q(n9);
                                                                                                    end
                                                                                                end
                                                                                            else
                                                                                                res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8);
                                                                                            end
                                                                                        end
                                                                                    else
                                                                                        res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n7);
                                                                                    end
                                                                                end
                                                                            else
                                                                                res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6);
                                                                            end
                                                                        end
                                                                    else
                                                                        res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4)*q(n5);
                                                                    end
                                                                end
                                                            else
                                                                res0321 = res0321+q(n1)*q(n2)*q(n3)*q(n4);
                                                            end
                                                        end
                                                    else
                                                        res0321 = res0321+q(n1)*q(n2)*q(n3);
                                                    end
                                                end
                                            else
                                                res0321 = res0321+q(n1)*q(n2);
                                            end
                                        end
                                    else
                                        res0321 = res0321+q(n1);
                                    end
                                end
                            else%x==2
                                res0321=1;
                            end
                            if e-x==1;%为了排除P{x|e=x+1}=0；
                                f=0;
                            end
                            res4321 = res4321 + q(k1)*q(k2)*res0321*f;%ps2关于x的累加
                            res0321=0;
                        end
                    end
                end

                %x=1,e>=3时
                for k=1:K
                    for l=1:k
                        res5321= res5321+q(l);
                    end
                    for s=(k+1):K
                        for t=1:s
                            res6321 = res6321+q(t);
                        end
                        res7321 = res7321 + (e-1)*q(s)*(1-res6321)^(e-2);
                        res6321=0;
                    end
                    res8321= res8321 + q(k)*((1-res5321)^(e-1)-res7321);%ps1
                    res5321 = 0;res7321=0;
                end

                res321 = res321 + nchoosek(M-1, e-1)*(lambda*p)^e*(1-lambda*p)^(M-e)*(res8321+res4321);
                res4321=0;res8321=0;
            end

            symsum=0;%e=2时
            for r=1:K
                symsum =symsum + (lambda*p)^2*(1-lambda*p)^(M-2)*nchoosek(M-1, 1)*q(r)*(1-q(r));%ps3
            end

            ps321=lambda*p*(1-lambda*p)^(M-1) + symsum + res321;
            symsum=0;res321=0;
            Y321=T/ps321;%E(Y)
            Y2321=T^2*(2-ps321)/ps321^2;%E(Y^2)


            poi_gs_m321 = T+Y2321/Y321/2;%%Average AoI
            analysis_AoI321=[analysis_AoI321 poi_gs_m321];
            if q==[0 0 0]  
                gnrt1(cir1, cir2)=NaN;            
            else
                gnrt1(cir1, cir2)=poi_gs_m321;
            end
     end
end

[q1, q2] = meshgrid(qarr1, qarr2);

figure(lambdap)
% 绘制 g1 曲面图
surf1 = surf(q2, q1, gnrt1', 'EdgeColor', 'black'); % 绘制 g1 曲面，显示网格线
surf1.FaceColor = 'interp'; % 启用插值颜色
surf1.FaceAlpha = 0.8; % 设置透明度

% 设置坐标轴标签和标题
xlabel('$q_2$', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial', 'Rotation', 25);
ylabel('$q_1$', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial', 'Rotation', -25);
zlabel('AoI', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial'); % Z轴标签
% title('NOMA-NRT'); % 标题

% 
% % 设置完整的刻度值
% xticks(0.01:0.1:0.91); % 设置 x 轴刻度为 qarr1 的所有值
% yticks(0.01:0.1:0.91);  % 设置 y 轴刻度为 qarr2 的所有值

% 确保每个轴都有合适的范围
xlim([min(qarr1), max(qarr1)]);  % 设置 x 轴范围
ylim([min(qarr2), max(qarr2)]);  % 设置 y 轴范围


% 设置颜色条
colorbar;

% 设置视角
view(3); % 设置3D视角
% 
% [min_val, min_idx] = min(gnrt1(:));  % 获取最小值及其索引
% [min_q1_idx, min_q2_idx] = ind2sub(size(gnrt1), min_idx);  % 将索引转换为矩阵坐标

% % 获取实际的 q1 和 q2 坐标
% min_q1 = qarr1(min_q1_idx);  % 使用 min_q1_idx 获取对应的 q1 值
% min_q2 = qarr2(min_q2_idx);  % 使用 min_q2_idx 获取对应的 q2 值
% 
% % % 在最小点处添加白色的标记（更显眼）
% hold on;
% plot3(min_q2, min_q1, min_val, 'wo', 'MarkerSize', 10, 'MarkerFaceColor', 'w'); % 使用白色圆点
% hold off;

[min_val, min_idx] = min(gnrt1(:));  % 获取最小值及其索引
[min_q1_idx, min_q2_idx] = ind2sub(size(gnrt1), min_idx);  % 将索引转换为矩阵坐标

% 获取实际的 q1 和 q2 坐标
min_q1 = qarr1(min_q1_idx)  % 使用 min_q1_idx 获取对应的 q1 值
min_q2 = qarr2(min_q2_idx) % 使用 min_q2_idx 获取对应的 q2 值


end