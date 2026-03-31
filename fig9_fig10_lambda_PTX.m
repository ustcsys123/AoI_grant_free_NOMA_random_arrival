%lambda和PTX对AoI的影响，论文中的fig.9
clc
clear all;
for lambdap=1:1
simulation_AoI=[];
analysis_AoI=[];
sim_success_Pr=[];
ana_success_Pr=[];
simulation_AoI321=[];
analysis_AoI321=[];
sim_success_Pr321=[];
ana_success_Pr321=[];

% lambdaarr=[0.02 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
% Lambdap=[0.02 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
lambdaarr=[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9];
Lambdap=[0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
gnrt = zeros(length(Lambdap), length(lambdaarr)); % 存储g的值
grt = zeros(length(Lambdap), length(lambdaarr)); % 存储g的值
for cir=1:9  
    num_itr = 100;%总时隙数
    num1=1;
    num2=1;
    num3=1;
    num4=1;
    num5=1;
    num6=1;
    k=0;
    sss=0;

    for cir1=1:9
        Psnr=20;
        Karr=[2 3 4 5 6 7 8 9 10 11 12 13];
        Marr=[2 3 4 5 6 7 8];
%         N=1;% 每个数据包含N bits
        T=0.5;%时隙长度
        M=8;%总用户数
        R = 0.1;
        eps = 2^R-1;
        K=2;%要注意K的变换，要引起用户选择范围的概率
        transMatrix = zeros(M+1, M+1);
        lambda=lambdaarr(cir1);%数据到达以伯努利过程输入，对称结构；
%         lambda=0.2;
        p=Lambdap(cir);
%         p=0.2;%信源选择发送数据的概率；

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
       
%         rng(42);
%         randomNumbers = rand(1, K);%随机生成K个0-1之间的随机数
%         q = randomNumbers / sum(randomNumbers);% 归一化以确保它们的和为1
q = 1/K * ones(1, K);%qk
             
        %软件计算精度问题，会使得M增大时ps的误差增大，若将q=[0.1  0.9]，即使M增大，ps的误差也会小;q=[0.9  0.1]误差会很大；

        choice_a_user = zeros(K, num_itr);

        %NOMA
        Qj1= [0]; yj1 = [0];Tj1 = [0];Qj2= [0]; yj2 = [0];Tj2 = [0];Qj3= [0]; yj3 = [0];Tj3 = [0];
        Qj4= [0]; yj4 = [0];Tj4 = [0];Qj5= [0]; yj5 = [0];Tj5 = [0];Qj6= [0]; yj6 = [0];Tj6 = [0];
        for i = 1 : num_itr%循坏时隙数
            for j=1:M
                randomNumber = rand();
                if randomNumber <= q(1) % 用户1根据概率q1选择t1
                    choice_a_user(j,i) = 1;
                elseif sum(q(1:1)) < randomNumber && randomNumber <= sum(q(1:2))% 用户2根据概率q2选择t2
                    choice_a_user(j,i) = 2;
                elseif sum(q(1:2)) < randomNumber && randomNumber <= sum(q(1:3))
                    choice_a_user(j,i) = 3;
                elseif sum(q(1:3)) < randomNumber && randomNumber <= sum(q(1:4))
                    choice_a_user(j,i) = 4;
                elseif sum(q(1:4)) < randomNumber && randomNumber <= sum(q(1:5))
                    choice_a_user(j,i) = 5;
                elseif sum(q(1:5)) < randomNumber && randomNumber <= sum(q(1:6))
                    choice_a_user(j,i) = 6;
                elseif sum(q(1:6)) < randomNumber && randomNumber <= sum(q(1:7))
                    choice_a_user(j,i) = 7;
                elseif sum(q(1:7)) < randomNumber && randomNumber <= sum(q(1:8))
                    choice_a_user(j,i) = 8;

                elseif sum(q(1:8)) < randomNumber && randomNumber <= sum(q(1:9))
                    choice_a_user(j,i) = 9;
                elseif sum(q(1:9)) < randomNumber && randomNumber <= sum(q(1:10))
                    choice_a_user(j,i) = 10;
                elseif sum(q(1:10)) < randomNumber && randomNumber <= sum(q(1:11))
                    choice_a_user(j,i) = 11;
                elseif sum(q(1:11)) < randomNumber && randomNumber <= sum(q(1:12))
                    choice_a_user(j,i) = 12;
                elseif sum(q(1:12)) < randomNumber && randomNumber <= sum(q(1:13))
                    choice_a_user(j,i) = 13;
                end
            end
        end

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
        gnrt(cir, cir1)=poi_gs_m321;


        %RT-ana
        %分析
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
        simS=sum(Tj1(1:end-2))/(length(Tj1)-2);


        a=lambda;
        b=ps;
        En=(lambda - lambda*ps)/ps - (lambda + ps - lambda*ps - 1)/ps - (lambda - 1)/lambda + 2;
        anaD=T*[En-1];%E(D)
        simD=sum(yj1(2:end-1))/(length(yj1)-2);
        Roun=abs((3*(a - a*b))/b - ((a - a*b)/b - (a + b - a*b - 1)/b - (a - 1)/a + 2)^2 - (3*(a + b - a*b - 1))/b - (a - 1)/a - (2*(a - 1)*((a - a*b)/b - (a + b - a*b - 1)/b + 1/a + 1))/a - (2*((a*b - a + 1)/b - (a*(b - 1))/b)*(a + b - a*b - 1))/b + (2*((a + b - a*b)/b + ((a - 1)*(b - 1))/b)*(a - a*b))/b + 4);
        anaD2=T^2*[Roun+En^2-2*En+1];%E(D^2)
        yj1_squared = yj1.^ 2;
        simD2=sum(yj1_squared(2:end-1))/(length(yj1_squared)-2);

        poi_gs_m = anaS+anaD2/anaD/2;%%Average AoI
        analysis_AoI=[analysis_AoI poi_gs_m];
        ps=0;
        grt(cir, cir1)=poi_gs_m;
    end
end

[P, Lambda] = meshgrid(Lambdap, lambdaarr);

% figure;
% 
% % 定义颜色映射表，将蓝色和红色映射到不同区间
% colormap([cool(32); hot(32)]); % 蓝色渐变和红色渐变
% 
% % 对 g1 (蓝色渐变) 数据进行归一化并映射到 [1, 32]
% g1_min = min(gnrt(:));
% g1_max = max(gnrt(:));
% g1_normalized = round(31 * (gnrt - g1_min) / (g1_max - g1_min)) + 1; % 将数据映射到 [1, 32]
% 
% % 绘制 g1 曲面图
% surf1 = surf(P, Lambda, gnrt', 'EdgeColor', 'none'); % 绘制 g1 曲面
% surf1.CData = g1_normalized'; % 设置 CData 为归一化后的索引
% surf1.FaceColor = 'interp'; % 启用插值颜色
% surf1.FaceAlpha = 0.8; % 设置透明度
% 
% hold on;
% 
% % 对 g2 (红色渐变) 数据进行归一化并映射到 [33, 64]
% g2_min = min(grt(:));
% g2_max = max(grt(:));
% g2_normalized = round(31 * (grt - g2_min) / (g2_max - g2_min)) + 33; % 将数据映射到 [33, 64]
% 
% % 绘制 g2 曲面图
% surf2 = surf(P, Lambda, grt', 'EdgeColor', 'none'); % 绘制 g2 曲面
% surf2.CData = g2_normalized'; % 设置 CData 为归一化后的索引
% surf2.FaceColor = 'interp'; % 启用插值颜色
% surf2.FaceAlpha = 0.8; % 设置透明度
% 
% hold off;
% 
% % 设置坐标轴标签和标题
% xlabel('$P_{TX}$', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial', 'Rotation', 25);
% ylabel('$\lambda$',  'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial', 'Rotation', -25);
% zlabel('AoI','Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial'); % Z轴标签
% % title('3D Plot of g1 (Blue Gradient) and g2 (Red Gradient) vs p and lambda'); % 标题
% 
% % 设置颜色条并区分两个曲面
% colorbar('YLim', [1, 64], ...
%     'Ticks', [1, 32, 33, 64], ...
%     'TickLabels', {'g1 Min', 'g1 Max', 'g2 Min', 'g2 Max'});
% 
% % 设置视角
% view(3); % 设置3D视角
% 
% % 添加图例
% legend({'NOMA-NRT (Blue Gradient)', 'NOMA-RT (Red Gradient)'}, 'Location', 'northeast'); % 图例
% end
% 对 g1 (蓝色渐变) 数据进行归一化并映射到 [1, 32]
% 对 g1 数据进行归一化并映射到常规颜色

% g1_min = min(gnrt(:));
% g1_max = max(gnrt(:));
% g1_normalized = round(31 * (gnrt - g1_min) / (g1_max - g1_min)) + 1; % 将数据映射到 [1, 32]
% 
% figure(1);
% % 绘制 g1 曲面图
% surf1 = surf(P, Lambda, gnrt', 'EdgeColor', 'black'); % 绘制 g1 曲面，显示网格线
% surf1.CData = g1_normalized'; % 设置 CData 为归一化后的索引
% surf1.FaceColor = 'interp'; % 启用插值颜色
% surf1.FaceAlpha = 0.8; % 设置透明度
% 
% % 设置坐标轴标签和标题
% xlabel('$P_{TX}$', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial', 'Rotation', -25);
% ylabel('$\lambda$',  'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial', 'Rotation', 25);
% zlabel('AoI','Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial'); % Z轴标签
% % title('NOMA-NRT'); % 标题
% xlim([min(Lambdap), max(Lambdap)]);
% ylim([min(lambdaarr), max(lambdaarr)]);
% 
% xticks(Lambdap); % 设置 x 轴
% yticks(lambdaarr);  % 设置 y 轴的所有值
% 
% % 设置颜色条
% colorbar('YLim', [1, 32], ...
%     'Ticks', [1, 32], ...
%     'TickLabels', {'g1 Min', 'g1 Max'});
% 
% % 设置视角
% view(3); % 设置3D视角

g1_min = min(gnrt(:));
g1_max = max(gnrt(:));
g1_normalized = round(31 * (gnrt - g1_min) / (g1_max - g1_min)) + 1; % 将数据映射到 [1, 32]

figure(1);
% 绘制 g1 曲面图
surf1 = surf(P, Lambda, gnrt', 'EdgeColor', 'black'); % 绘制 g1 曲面，显示网格线
surf1.CData = g1_normalized'; % 设置 CData 为归一化后的索引
surf1.FaceColor = 'interp'; % 启用插值颜色
surf1.FaceAlpha = 0.8; % 设置透明度

% 设置坐标轴标签和标题
xlabel('$P_{TX}$', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial', 'Rotation', -25);
ylabel('$\lambda$',  'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial', 'Rotation', 25);
zlabel('AoI','Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial'); % Z轴标签
% title('NOMA-NRT'); % 标题
xlim([min(Lambdap), max(Lambdap)]);
ylim([min(lambdaarr), max(lambdaarr)]);

% xticks(Lambdap); % 设置 x 轴
% yticks(lambdaarr);  % 设置 y 轴的所有值


% 设置颜色条
colorbar('YLim', [1, 32], ...
    'Ticks', [1, 32], ...
    'TickLabels', {'g1 Min', 'g1 Max'});


% 设置视角
view(3); % 设置3D视角




% 对 g2 数据进行归一化并映射到常规颜色
g2_min = min(grt(:));
g2_max = max(grt(:));
g2_normalized = round(31 * (grt - g2_min) / (g2_max - g2_min)) + 1; % 将数据映射到 [1, 32]

% 绘制 g2 曲面图
figure(2);
surf2 = surf(P, Lambda, grt', 'EdgeColor', 'black'); % 绘制 g2 曲面，显示网格线
surf2.CData = g2_normalized'; % 设置 CData 为归一化后的索引
surf2.FaceColor = 'interp'; % 启用插值颜色
surf2.FaceAlpha = 0.8; % 设置透明度

% 设置坐标轴标签和标题
xlabel('$P_{TX}$', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial', 'Rotation', -25);
ylabel('$\lambda$',  'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial', 'Rotation', 25);
zlabel('AoI','Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Arial'); % Z轴标签
% title('NOMA-RT'); % 标题
xlim([min(Lambdap), max(Lambdap)]);
ylim([min(lambdaarr), max(lambdaarr)]);

% xticks(Lambdap); % 设置 x 轴
% yticks(lambdaarr);  % 设置 y 轴的所有值

% 设置颜色条
colorbar('YLim', [1, 32], ...
    'Ticks', [1, 32], ...
    'TickLabels', {'g2 Min', 'g2 Max'});



% 设置视角
view(3); % 设置3D视角

end