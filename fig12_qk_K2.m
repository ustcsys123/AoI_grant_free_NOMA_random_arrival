clear all;
mink2=[];
for lambdap=1:4
    simulation_AoI=[];
    analysis_AoI=[];
    sim_success_Pr=[];
    ana_success_Pr=[];
    simulation_AoI321=[];
    analysis_AoI=[];
    sim_success_Pr321=[];
    ana_success_Pr321=[];

    qarr1 = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9];
%     qarr1 = [0.01, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, ...
%          0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95];
%     qarr1=[0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29, 0.3, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39, 0.4, 0.41, 0.42, 0.43, 0.44, 0.45, 0.46, 0.47, 0.48, 0.49, 0.5, 0.51, 0.52, 0.53, 0.54, 0.55, 0.56, 0.57, 0.58, 0.59, 0.6, 0.61, 0.62, 0.63, 0.64, 0.65, 0.66, 0.67, 0.68, 0.69, 0.7, 0.71, 0.72, 0.73, 0.74, 0.75, 0.76, 0.77, 0.78, 0.79, 0.8, 0.81, 0.82, 0.83, 0.84, 0.85, 0.86, 0.87, 0.88, 0.89, 0.9, 0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99];
    % qarr1=[0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29, 0.3, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39, 0.4, 0.41, 0.42, 0.43, 0.44, 0.45, 0.46, 0.47, 0.48, 0.49, 0.5, 0.51, 0.52, 0.53, 0.54, 0.55, 0.56, 0.57, 0.58, 0.59, 0.6, 0.61, 0.62, 0.63, 0.64, 0.65, 0.66, 0.67, 0.68, 0.69, 0.7, 0.71, 0.72, 0.73, 0.74, 0.75, 0.76, 0.77, 0.78, 0.79, 0.8, 0.81, 0.82, 0.83, 0.84, 0.85, 0.86, 0.87, 0.88, 0.89, 0.9, 0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99];
%     arrptx=[0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29, 0.3, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39, 0.4, 0.41, 0.42, 0.43, 0.44, 0.45, 0.46, 0.47, 0.48, 0.49, 0.5, 0.51, 0.52, 0.53, 0.54, 0.55, 0.56, 0.57, 0.58, 0.59, 0.6, 0.61, 0.62, 0.63, 0.64, 0.65, 0.66, 0.67, 0.68, 0.69, 0.7, 0.71, 0.72, 0.73, 0.74, 0.75, 0.76, 0.77, 0.78, 0.79, 0.8, 0.81, 0.82, 0.83, 0.84, 0.85, 0.86, 0.87, 0.88, 0.89, 0.9, 0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99];
arrptx = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
% arrptx = [0.01, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, ...
%          0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95];

    gnrt = zeros(1, length(qarr1)); % 存储g的值

    ptxarr = zeros(1,length(qarr1));

    for cir=1:length(qarr1)

        num_itr = 10;%总时隙数

        Psnr=20;
        Karr=[2 6];
        Marr=[2 8 16 32];
        T=0.5;%时隙长度
        M=Marr(lambdap);%总用户数
        R = 0.1;
        eps = 2^R-1;
        K=2;%要注意K的变换，要引起用户选择范围的概率
        transMatrix = zeros(M+1, M+1);
        lambda=0.4;

        q=[qarr1(cir) 1-qarr1(cir)];

        for cir3=1:length(arrptx)

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

            res0321=0;res321=0;res1321=0;res2321=0;res3321=0;res4321=0;res5321=0;res6321=0;res7321=0;res8321=0;res9321=0;w321=0;e=0;k1=0;k2=0;k=0;k_=0;
            for k = 0:M%从k到k_的状态转移
                for k_ = 0:M
                    k_k = (k - k_);
                    if k_ >= k
                        k_k = 0;
                    end
                    Pkk_=0;Pxi=0;Pxk=0;Pqr=0;Px0i2=0;Px2i2=0;Px1i3=0;Pl1=0;Pl2=0;Pl3=0;
                    for x = [k_k : min(k,K)];%Pxk
                        %Pxi
                        if x==K
                            min1=K+1;
                        else
                            min1=k+1;
                        end
                        for m = [x+1,x+3:min1]%求P{x|i=m-1}
                            if x==0 & (m-1) >= x & (m-1) == 0
                                Pxi = 1;
                            end
                            if x==0 & (m-1) >= x & (m-1) == 1
                                Pxi = 0;
                            end
                            if x==0 & (m-1) >= x & (m-1) >= 2
                                for u1 = 1:K
                                    for u2 = 1:u1
                                        Pqr = Pqr + q(u2);
                                    end
                                    Px0i2 = Px0i2 + (m-1)*q(u1)*(1-Pqr)^(m-1-1);
                                    Pqr = 0;
                                end
                                Pxi = 1 - Px0i2;
                                Px0i2=0;
                            end
                            if x==1 & (m-1)>=x & (m-1) == 1
                                Pxi = 1;
                            end
                            if x==1 & (m-1)>=x & (m-1) == 2
                                Pxi = 0;
                            end
                            if x==2 & (m-1)>=x & (m-1) == 2
                                for u3 =1:K
                                    Px2i2 = Px2i2 + q(u3)*(1-q(u3));
                                end
                                Pxi = Px2i2;
                                Px2i2 = 0;
                            end
                            if x==1 & (m-1)>=x & (m-1) >= 3
                                e = m-1;
                                for l=1:K
                                    for l1= 1:l
                                        Pl1 = Pl1 + q(l1);
                                    end
                                    for l2 = l+1:K
                                        for l3 = 1:l2
                                            Pl3= Pl3 + q(l3);
                                        end
                                        Pl2 = Pl2 + nchoosek(e-1, 1)*q(l2)*(1-Pl3)^(e-2);
                                        Pl3 = 0;
                                    end
                                    Px1i3 = Px1i3 + nchoosek(e,1)*q(l)*[(1-Pl1)^(e-1)-Pl2];
                                    Pl1=0; Pl2=0;
                                end
                                Pxi = Px1i3;
                                Px1i3 = 0;
                            end

                            res00=0;res11=0;res22=0;res33=0;res44=0;res55=0;res66=0;res77=0;res88=0;res99=0;
                            if x>=2 & (m-1)>=x & (m-1)>=3 & (m-1-x) ~= 1
                                e = m-1;
                                for k1 = 1:(K-x+1)
                                    for k2 = (k1+x-1):K
                                        if  x==K %注意该条件
                                            f=1*factorial(x)*nchoosek(e, x);
                                        else
                                            if (e-x)==0%因为求res3时，0*0^(-1)=Nan，所以单独列一个
                                                f=1*factorial(x)*nchoosek(e, x);
                                            else
                                                for l=1:k2%q的前k2项的和
                                                    res11= res11 + q(l);
                                                end
                                                for s=(k2+1):K
                                                    for t=1:s
                                                        res22 = res22 + q(t);
                                                    end
                                                    res33 = res33+(e-x)*q(s)*(1-res22)^(e-x-1);
                                                    res22 = 0;
                                                end
                                                f=[(1-res11)^(e-x)-res33]*factorial(x)*nchoosek(e, x);
                                                res11 = 0;res33 = 0;
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
                                                                                                                        res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8)*q(n9)*q(n10);
                                                                                                                    end
                                                                                                                else
                                                                                                                    res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8)*q(n9);
                                                                                                                end
                                                                                                            end
                                                                                                        else
                                                                                                            res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8);
                                                                                                        end
                                                                                                    end
                                                                                                else
                                                                                                    res00= res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n7);
                                                                                                end
                                                                                            end
                                                                                        else
                                                                                            res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6);
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5);
                                                                                end
                                                                            end
                                                                        else
                                                                            res00 = res00+q(n1)*q(n2)*q(n3)*q(n4);
                                                                        end
                                                                    end
                                                                else
                                                                    res00 = res00+q(n1)*q(n2)*q(n3);
                                                                end
                                                            end
                                                        else
                                                            res00 = res00+q(n1)*q(n2);
                                                        end
                                                    end
                                                else
                                                    res00 = res00+q(n1);
                                                end
                                            end
                                        else%x==2
                                            res00=1;
                                        end
                                        res44 = res44 + q(k1)*q(k2)*res00*f;%ps2关于x的累加
                                        res00=0;
                                    end
                                end
                                Pxi=res44;
                                res44=0;
                            end

                            Pxk = Pxk + (1-p)^(k-m+1)*p^(m-1)*nchoosek(k,m-1)*Pxi;
                            Pxi=0;
                        end%Pxk结束
                        Pkk_ = Pkk_ + Pxk*lambda^(k_-k+x)*(1-lambda)^(M-k_)*nchoosek(M-k+x, k_-k+x);
                        Pxk=0;
                    end
                    transMatrix(k+1, k_+1) = Pkk_;
                    Pkk_=0;
                end
            end

            P = transMatrix;% P为已知的转移概率矩阵
            A = P' - eye(M+1);% 构建线性方程组 (P^T - I)Π = 0
            A = [A; ones(1, M+1)];% 添加归一化条件
            b = [zeros(M+1, 1); 1];
            Pi = A\b;% 求解线性方程组%列向量

            for k = 0:(M-1)%Π（1,k）
                Pi_1k(k+1) = (k+1)/M * Pi(k+2);
            end
            Pi_1k=Pi_1k/sum(Pi_1k);

            %pm即ps
            ps = 0;Pxi=0;Pqr=0;Px0i2=0;Px2i2=0;Px1i3=0;Pl1=0;Pl2=0;Pl3=0;
            for k = 0: (M-1)
                for x = 1:min(k+1,K)
                    if x==K
                        min2=K;
                    else
                        min2=k+1;
                    end
                    for m=[x,x+2:min2]
                        %Pxi=P{x|i=m}
                        if x==0 & m >= x & m == 0
                            Pxi = 1;
                        end
                        if x==0 & m >= x & m == 1
                            Pxi = 0;
                        end
                        if x==0 & m >= x & m>= 2
                            for u1 = 1:K
                                for u2 = 1:u1
                                    Pqr = Pqr + q(u2);
                                end
                                Px0i2 = Px0i2 + m*q(u1)*(1-Pqr)^(m-1);
                                Pqr = 0;
                            end
                            Pxi = 1 - Px0i2;
                            Px0i2=0;
                        end
                        if x==1 & m>=x & m == 1
                            Pxi = 1;
                        end
                        if x==1 & m>=x & m == 2
                            Pxi = 0;
                        end
                        if x==2 & m>=x & m == 2
                            for u3 =1:K
                                Px2i2 = Px2i2 + q(u3)*(1-q(u3));
                            end
                            Pxi = Px2i2;
                            Px2i2 = 0;
                        end
                        if x==1 & m>=x & m >= 3
                            e = m;
                            for l=1:K
                                for l1= 1:l
                                    Pl1 = Pl1 + q(l1);
                                end
                                for l2 = l+1:K
                                    for l3 = 1:l2
                                        Pl3= Pl3 + q(l3);
                                    end
                                    Pl2 = Pl2 + nchoosek(e-1, 1)*q(l2)*(1-Pl3)^(e-2);
                                    Pl3 = 0;
                                end
                                Px1i3 = Px1i3 + q(l)*[(1-Pl1)^(e-1)-Pl2];
                                Pl1=0; Pl2=0;
                            end
                            Pxi = Px1i3;
                            Px1i3 = 0;
                        end

                        res00=0;res11=0;res22=0;res33=0;res44=0;res55=0;res66=0;res77=0;res88=0;res99=0;
                        if x>=2 & m>=x & m>=3 & (m-x) ~= 1
                            e = m;
                            for k1 = 1:(K-x+1)
                                for k2 = (k1+x-1):K
                                    if  x==K %注意该条件
                                        f=1*factorial(x)*nchoosek(e-1, x-1);
                                    else
                                        if (e-x)==0%因为求res3时，0*0^(-1)=Nan，所以单独列一个
                                            f=1*factorial(x)*nchoosek(e-1, x-1);
                                        else
                                            for l=1:k2%q的前k2项的和
                                                res11= res11 + q(l);
                                            end
                                            for s=(k2+1):K
                                                for t=1:s
                                                    res22 = res22 + q(t);
                                                end
                                                res33 = res33+(e-x)*q(s)*(1-res22)^(e-x-1);
                                                res22 = 0;
                                            end
                                            f=[(1-res11)^(e-x)-res33]*factorial(x)*nchoosek(e-1, x-1);
                                            res11 = 0;res33 = 0;
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
                                                                                                                    res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8)*q(n9)*q(n10);
                                                                                                                end
                                                                                                            else
                                                                                                                res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8)*q(n9);
                                                                                                            end
                                                                                                        end
                                                                                                    else
                                                                                                        res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8);
                                                                                                    end
                                                                                                end
                                                                                            else
                                                                                                res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n7);
                                                                                            end
                                                                                        end
                                                                                    else
                                                                                        res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6);
                                                                                    end
                                                                                end
                                                                            else
                                                                                res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5);
                                                                            end
                                                                        end
                                                                    else
                                                                        res00 = res00+q(n1)*q(n2)*q(n3)*q(n4);
                                                                    end
                                                                end
                                                            else
                                                                res00 = res00+q(n1)*q(n2)*q(n3);
                                                            end
                                                        end
                                                    else
                                                        res00 = res00+q(n1)*q(n2);
                                                    end
                                                end
                                            else
                                                res00 = res00+q(n1);
                                            end
                                        end
                                    else%x==2
                                        res00=1;
                                    end
                                    res44 = res44 + q(k1)*q(k2)*res00*f;%ps2关于x的累加
                                    res00=0;
                                end
                            end
                            Pxi=res44;
                            res44=0;
                        end%Pxi结束

                        ps = ps + (1-p)^(k-m+1)*p^m*nchoosek(k,m-1)*Pxi*Pi_1k(k+1);
                        Pxi=0;
                    end
                end
            end

            anaps=ps/p;
            %     simps=ps1/sss;

            anaS=T/(1-(1-ps)*(1-lambda));%E(S)
%             simS=sum(Tj1(1:end-2))/(length(Tj1)-2);

            a=lambda;
            b=ps;
            disp(ps>0)
            En=(lambda - lambda*ps)/ps - (lambda + ps - lambda*ps - 1)/ps - (lambda - 1)/lambda + 2;
            anaD=T*[En-1];%E(D)
            %             simD=sum(yj1(2:end-1))/(length(yj1)-2);
            Roun=abs((3*(a - a*b))/b - ((a - a*b)/b - (a + b - a*b - 1)/b - (a - 1)/a + 2)^2 - (3*(a + b - a*b - 1))/b - (a - 1)/a - (2*(a - 1)*((a - a*b)/b - (a + b - a*b - 1)/b + 1/a + 1))/a - (2*((a*b - a + 1)/b - (a*(b - 1))/b)*(a + b - a*b - 1))/b + (2*((a + b - a*b)/b + ((a - 1)*(b - 1))/b)*(a - a*b))/b + 4);
            anaD2=T^2*[Roun+En^2-2*En+1];%E(D^2)
            %             yj1_squared = yj1.^ 2;
            %             simD2=sum(yj1_squared(2:end-1))/(length(yj1_squared)-2);


                poi_gs_m = anaS+anaD2/anaD/2;%%Average AoI
            analysis_AoI=[analysis_AoI poi_gs_m];
            ps=0;

        end

            [min_value, index] = min(analysis_AoI(1:length(arrptx)));
            
            ptxarr(cir)=arrptx(index);



            


        analysis_AoI=[];
    end

    for cir=1:length(qarr1)
%         Marr=[8 16 32 64];
        M=Marr(lambdap);%总用户数
        R = 0.1;
        eps = 2^R-1;
        K=2;%要注意K的变换，要引起用户选择范围的概率
        R=0.1;
        eps = 2^R-1;
        transMatrix = zeros(M+1, M+1);
%         lambda=0.4;%数据到达以伯努利过程输入，对称结构；
        p=ptxarr(cir);
        Pi_1k = zeros(1, M);

        q=[qarr1(cir) 1-qarr1(cir)];

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

        res0321=0;res321=0;res1321=0;res2321=0;res3321=0;res4321=0;res5321=0;res6321=0;res7321=0;res8321=0;res9321=0;w321=0;e=0;k1=0;k2=0;k=0;k_=0;
        for k = 0:M%从k到k_的状态转移
            for k_ = 0:M
                k_k = (k - k_);
                if k_ >= k
                    k_k = 0;
                end
                Pkk_=0;Pxi=0;Pxk=0;Pqr=0;Px0i2=0;Px2i2=0;Px1i3=0;Pl1=0;Pl2=0;Pl3=0;
                for x = [k_k : min(k,K)];%Pxk
                    %Pxi
                    if x==K
                        min1=K+1;
                    else
                        min1=k+1;
                    end
                    for m = [x+1,x+3:min1]%求P{x|i=m-1}
                        if x==0 & (m-1) >= x & (m-1) == 0
                            Pxi = 1;
                        end
                        if x==0 & (m-1) >= x & (m-1) == 1
                            Pxi = 0;
                        end
                        if x==0 & (m-1) >= x & (m-1) >= 2
                            for u1 = 1:K
                                for u2 = 1:u1
                                    Pqr = Pqr + q(u2);
                                end
                                Px0i2 = Px0i2 + (m-1)*q(u1)*(1-Pqr)^(m-1-1);
                                Pqr = 0;
                            end
                            Pxi = 1 - Px0i2;
                            Px0i2=0;
                        end
                        if x==1 & (m-1)>=x & (m-1) == 1
                            Pxi = 1;
                        end
                        if x==1 & (m-1)>=x & (m-1) == 2
                            Pxi = 0;
                        end
                        if x==2 & (m-1)>=x & (m-1) == 2
                            for u3 =1:K
                                Px2i2 = Px2i2 + q(u3)*(1-q(u3));
                            end
                            Pxi = Px2i2;
                            Px2i2 = 0;
                        end
                        if x==1 & (m-1)>=x & (m-1) >= 3
                            e = m-1;
                            for l=1:K
                                for l1= 1:l
                                    Pl1 = Pl1 + q(l1);
                                end
                                for l2 = l+1:K
                                    for l3 = 1:l2
                                        Pl3= Pl3 + q(l3);
                                    end
                                    Pl2 = Pl2 + nchoosek(e-1, 1)*q(l2)*(1-Pl3)^(e-2);
                                    Pl3 = 0;
                                end
                                Px1i3 = Px1i3 + nchoosek(e,1)*q(l)*[(1-Pl1)^(e-1)-Pl2];
                                Pl1=0; Pl2=0;
                            end
                            Pxi = Px1i3;
                            Px1i3 = 0;
                        end

                        res00=0;res11=0;res22=0;res33=0;res44=0;res55=0;res66=0;res77=0;res88=0;res99=0;
                        if x>=2 & (m-1)>=x & (m-1)>=3 & (m-1-x) ~= 1
                            e = m-1;
                            for k1 = 1:(K-x+1)
                                for k2 = (k1+x-1):K
                                    if  x==K %注意该条件
                                        f=1*factorial(x)*nchoosek(e, x);
                                    else
                                        if (e-x)==0%因为求res3时，0*0^(-1)=Nan，所以单独列一个
                                            f=1*factorial(x)*nchoosek(e, x);
                                        else
                                            for l=1:k2%q的前k2项的和
                                                res11= res11 + q(l);
                                            end
                                            for s=(k2+1):K
                                                for t=1:s
                                                    res22 = res22 + q(t);
                                                end
                                                res33 = res33+(e-x)*q(s)*(1-res22)^(e-x-1);
                                                res22 = 0;
                                            end
                                            f=[(1-res11)^(e-x)-res33]*factorial(x)*nchoosek(e, x);
                                            res11 = 0;res33 = 0;
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
                                                                                                                    res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8)*q(n9)*q(n10);
                                                                                                                end
                                                                                                            else
                                                                                                                res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8)*q(n9);
                                                                                                            end
                                                                                                        end
                                                                                                    else
                                                                                                        res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8);
                                                                                                    end
                                                                                                end
                                                                                            else
                                                                                                res00= res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n7);
                                                                                            end
                                                                                        end
                                                                                    else
                                                                                        res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6);
                                                                                    end
                                                                                end
                                                                            else
                                                                                res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5);
                                                                            end
                                                                        end
                                                                    else
                                                                        res00 = res00+q(n1)*q(n2)*q(n3)*q(n4);
                                                                    end
                                                                end
                                                            else
                                                                res00 = res00+q(n1)*q(n2)*q(n3);
                                                            end
                                                        end
                                                    else
                                                        res00 = res00+q(n1)*q(n2);
                                                    end
                                                end
                                            else
                                                res00 = res00+q(n1);
                                            end
                                        end
                                    else%x==2
                                        res00=1;
                                    end
                                    res44 = res44 + q(k1)*q(k2)*res00*f;%ps2关于x的累加
                                    res00=0;
                                end
                            end
                            Pxi=res44;
                            res44=0;
                        end

                        Pxk = Pxk + (1-p)^(k-m+1)*p^(m-1)*nchoosek(k,m-1)*Pxi;
                        Pxi=0;
                    end%Pxk结束
                    Pkk_ = Pkk_ + Pxk*lambda^(k_-k+x)*(1-lambda)^(M-k_)*nchoosek(M-k+x, k_-k+x);
                    Pxk=0;
                end
                transMatrix(k+1, k_+1) = Pkk_;
                Pkk_=0;
            end
        end

        P = transMatrix;% P为已知的转移概率矩阵
        A = P' - eye(M+1);% 构建线性方程组 (P^T - I)Π = 0
        A = [A; ones(1, M+1)];% 添加归一化条件
        b = [zeros(M+1, 1); 1];
        Pi = A\b;% 求解线性方程组%列向量

        for k = 0:(M-1)%Π（1,k）
            Pi_1k(k+1) = (k+1)/M * Pi(k+2);
        end
        Pi_1k=Pi_1k/sum(Pi_1k);

        %pm即ps
        ps = 0;Pxi=0;Pqr=0;Px0i2=0;Px2i2=0;Px1i3=0;Pl1=0;Pl2=0;Pl3=0;
        for k = 0: (M-1)
            for x = 1:min(k+1,K)
                if x==K
                    min2=K;
                else
                    min2=k+1;
                end
                for m=[x,x+2:min2]
                    %Pxi=P{x|i=m}
                    if x==0 & m >= x & m == 0
                        Pxi = 1;
                    end
                    if x==0 & m >= x & m == 1
                        Pxi = 0;
                    end
                    if x==0 & m >= x & m>= 2
                        for u1 = 1:K
                            for u2 = 1:u1
                                Pqr = Pqr + q(u2);
                            end
                            Px0i2 = Px0i2 + m*q(u1)*(1-Pqr)^(m-1);
                            Pqr = 0;
                        end
                        Pxi = 1 - Px0i2;
                        Px0i2=0;
                    end
                    if x==1 & m>=x & m == 1
                        Pxi = 1;
                    end
                    if x==1 & m>=x & m == 2
                        Pxi = 0;
                    end
                    if x==2 & m>=x & m == 2
                        for u3 =1:K
                            Px2i2 = Px2i2 + q(u3)*(1-q(u3));
                        end
                        Pxi = Px2i2;
                        Px2i2 = 0;
                    end
                    if x==1 & m>=x & m >= 3
                        e = m;
                        for l=1:K
                            for l1= 1:l
                                Pl1 = Pl1 + q(l1);
                            end
                            for l2 = l+1:K
                                for l3 = 1:l2
                                    Pl3= Pl3 + q(l3);
                                end
                                Pl2 = Pl2 + nchoosek(e-1, 1)*q(l2)*(1-Pl3)^(e-2);
                                Pl3 = 0;
                            end
                            Px1i3 = Px1i3 + q(l)*[(1-Pl1)^(e-1)-Pl2];
                            Pl1=0; Pl2=0;
                        end
                        Pxi = Px1i3;
                        Px1i3 = 0;
                    end

                    res00=0;res11=0;res22=0;res33=0;res44=0;res55=0;res66=0;res77=0;res88=0;res99=0;
                    if x>=2 & m>=x & m>=3 & (m-x) ~= 1
                        e = m;
                        for k1 = 1:(K-x+1)
                            for k2 = (k1+x-1):K
                                if  x==K %注意该条件
                                    f=1*factorial(x)*nchoosek(e-1, x-1);
                                else
                                    if (e-x)==0%因为求res3时，0*0^(-1)=Nan，所以单独列一个
                                        f=1*factorial(x)*nchoosek(e-1, x-1);
                                    else
                                        for l=1:k2%q的前k2项的和
                                            res11= res11 + q(l);
                                        end
                                        for s=(k2+1):K
                                            for t=1:s
                                                res22 = res22 + q(t);
                                            end
                                            res33 = res33+(e-x)*q(s)*(1-res22)^(e-x-1);
                                            res22 = 0;
                                        end
                                        f=[(1-res11)^(e-x)-res33]*factorial(x)*nchoosek(e-1, x-1);
                                        res11 = 0;res33 = 0;
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
                                                                                                                res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8)*q(n9)*q(n10);
                                                                                                            end
                                                                                                        else
                                                                                                            res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8)*q(n9);
                                                                                                        end
                                                                                                    end
                                                                                                else
                                                                                                    res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n6)*q(n8);
                                                                                                end
                                                                                            end
                                                                                        else
                                                                                            res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6)*q(n7);
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5)*q(n6);
                                                                                end
                                                                            end
                                                                        else
                                                                            res00 = res00+q(n1)*q(n2)*q(n3)*q(n4)*q(n5);
                                                                        end
                                                                    end
                                                                else
                                                                    res00 = res00+q(n1)*q(n2)*q(n3)*q(n4);
                                                                end
                                                            end
                                                        else
                                                            res00 = res00+q(n1)*q(n2)*q(n3);
                                                        end
                                                    end
                                                else
                                                    res00 = res00+q(n1)*q(n2);
                                                end
                                            end
                                        else
                                            res00 = res00+q(n1);
                                        end
                                    end
                                else%x==2
                                    res00=1;
                                end
                                res44 = res44 + q(k1)*q(k2)*res00*f;%ps2关于x的累加
                                res00=0;
                            end
                        end
                        Pxi=res44;
                        res44=0;
                    end%Pxi结束

                    ps = ps + (1-p)^(k-m+1)*p^m*nchoosek(k,m-1)*Pxi*Pi_1k(k+1);
                    Pxi=0;
                end
            end
        end

        anaps=ps/p;
        %     simps=ps1/sss;

        anaS=T/(1-(1-ps)*(1-lambda));%E(S)
%         simS=sum(Tj1(1:end-2))/(length(Tj1)-2);


        a=lambda;
        b=ps;
        En=(lambda - lambda*ps)/ps - (lambda + ps - lambda*ps - 1)/ps - (lambda - 1)/lambda + 2;
        anaD=T*[En-1];%E(D)
%         simD=sum(yj1(2:end-1))/(length(yj1)-2);
        Roun=abs((3*(a - a*b))/b - ((a - a*b)/b - (a + b - a*b - 1)/b - (a - 1)/a + 2)^2 - (3*(a + b - a*b - 1))/b - (a - 1)/a - (2*(a - 1)*((a - a*b)/b - (a + b - a*b - 1)/b + 1/a + 1))/a - (2*((a*b - a + 1)/b - (a*(b - 1))/b)*(a + b - a*b - 1))/b + (2*((a + b - a*b)/b + ((a - 1)*(b - 1))/b)*(a - a*b))/b + 4);
        anaD2=T^2*[Roun+En^2-2*En+1];%E(D^2)
%         yj1_squared = yj1.^ 2;
%         simD2=sum(yj1_squared(2:end-1))/(length(yj1_squared)-2);

        poi_gs_m = anaS+anaD2/anaD/2;%%Average AoI
        analysis_AoI=[analysis_AoI poi_gs_m];
        ps=0;

        gnrt(cir)=poi_gs_m;

    end  


    lineStyles2 = {'b-','k-', 'r-', 'g-' };
    plot(qarr1, analysis_AoI(1:length(qarr1)), lineStyles2{lambdap}, 'LineWidth', 1.5, 'MarkerSize', 14);%NOMART0.3
    hold on;

    [min_value, min_index] = min(analysis_AoI(1:length(qarr1)));
    mink2=[mink2 qarr1(min_index)];

    h=legend('$M=2$',...
        '$M=8$',...
        '$M=16$',...
        '$M=32$');

    %设置LaTeX解释器
    set(h, 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial');

    xt=xlabel('$q_1$');
    set(xt,'FontSize', 14,'FontName', 'Arial', 'Interpreter', 'latex');
    yt=ylabel('AoI')
    set(yt,'FontSize', 14, 'FontName', 'Arial', 'Interpreter', 'latex');
    xlim([min(qarr1), max(qarr1)]);
end