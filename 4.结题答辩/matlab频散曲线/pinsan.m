% 材料参数（铝板示例）
E = 7e10;    % 弹性模量 (Pa)
nu = 0.33;   % 泊松比
rho = 2700;  % 密度 (kg/m³)
h = 2e-3;    % 板厚 (m)
% ​
% 计算波速和弯曲刚度
c_L = sqrt(E*(1-nu)/((1+nu)*(1-2*nu)*rho)); % 纵波速度 (~6350 m/s)
c_S = sqrt(E/(rho*(1+nu)));                  % 横波速度 (~3130 m/s)
B = E/(1-nu^2);                              % 弯曲刚度
% ​
% 频率范围
f_min = 0.1;   % 最低频率 (kHz)
f_max = 50;    % 最高频率 (kHz)
df = 0.01;     % 频率步长 (kHz)

% 波数范围
k_min = 0;
k_max = 2*pi*c_L/(h/2); % 最大波数 (对应最高频率)
dk = 0.01;            % 波数步长
% ​
% 生成波数网格
k = k_min:dk:k_max;
omega = 2*pi*f_min:2*pi*df:2*pi*f_max;
% 初始化频散曲线矩阵
dispersion = zeros(length(omega),length(k));
% 迭代求解每个频率点
for i = 1:length(omega)
    w = omega(i);
    % 定义方程函数
    fun = @(k) ( (w^2/c_L^2 - k.^2) .* (w^2/c_S^2 - k.^2) - (w^2*rho/B)*k.^4 );
    % 使用fzero寻找根
    k_root = fzero(fun, [k(1), k(end)]);
    % 存储结果
    dispersion(i,:) = k_root;
end
% 相速
phase_vel = omega./dispersion;
% 群速度
group_vel = 1./(d(omega)./d(dispersion));
figure;
plot(phase_vel*1e3, omega/1e3, 'b', 'LineWidth', 1.5); % 转换为km/s和kHz
hold on;
plot(group_vel*1e3, omega/1e3, 'r--');
xlabel('相速度 (km/s)');
ylabel('频率 (kHz)');
legend('相速度', '群速度');
title('Lamb波频散曲线');
grid on;







