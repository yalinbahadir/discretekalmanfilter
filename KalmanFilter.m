clc;
clear;
clear all;

%%Doðru iþaret ve ölçüm tanýmý:
%Sistem Deðiþkenleri Tanýmý

N = 1000;                 % Ýþlemin nerede biteceðinin tanýmý
dt = 0.001;               % Örneklerin hangi aralýkta alýnacaðýnýn tanýmý
t = dt * (1:N);           % Zaman vektörü
F = [1, dt; 0, 1];        % Durum matrisi tanýmý
G = [-1/2*dt^2 ; -dt];   % Girdi matrisi tanýmý
H = [1 0];                % Gözlem matrisi tanýmý
Q = zeros(2);             % Süreç gürültüsü kovaryansý
u = 9.80665;              % Girdi tanýmý, yer çekimi ivmesi
I = [ 1 , 0 ; 0 , 1];     % Birim Matris

%Baþlangýç konumu ve hýzý hesaplamasý

y0 = 100;
v0 = 0;

%Doðru durum için durum vektörü belirlenmesi

xt = zeros(2, N);        % Doðru durum vektörü
xt(:,1) = [y0;v0];       % Doðru baþlangýç durumu;

%Durumun hesabý için döngü
for k = 2:N
    %Durumun tahmin denklemi üzerindeki daðýlýmý
    xt(:, k) = F * xt(:, k-1) + G*u;
end
% Doðru durum üzerinden gürültülü ölçüm üretimi
R = 4;                   % m^2/s^2
v = sqrt(R)*randn(1, N); % Ölçüm gürültüsü
z = H*xt + v;            % Gürültülü ölçüm
%%Kalman Tahmininin belirlenmesi
% Tahmin edilen durumu belirle
x = zeros(2,N);          % Tahmin durum vektörü
x(:, 1) = [105; 0];      % Baþlangýç durumu tahmini
% Kovaryans matrisi belirlenmesi
P = [10, 0; 0, 0.01]; % Baþlangýç durum hatasý kovaryansý
% Tekrarlý Kalman Filtre döngüsü tanýmý
for k = 2:N
 % Durum vektör tahmini
 x(:, k) = F*x(:, k-1) + G*u;
 % Kovaryans tahmini
 P = F*P*F' + Q;
 % Kalman Kazanç matrisi hesabý
 K = P*H'/(H*P*H' + R);
 % Durum vektörü güncellemesi
 x(:,k) = x(:,k) + K*(z(k) - H*x(:,k));
 % Kovaryans güncellemesi
 P = (I - K*H)*P;
end
%% Sonuçlarýn gösterimi
% Durumlarýn gösterimi
figure(1);
subplot(2,1,1);
plot(t, z, 'g-', t, x(1,:), 'b--', 'LineWidth', 2);
hold on; plot(t, xt(1,:), 'r:', 'LineWidth', 1.5)
xlabel('t (s)'); ylabel('x_1 = h (m)'); grid on;
legend('Ölçülen','Tahmin Edilen','Doðru');
subplot(2,1,2);
plot(t, x(2,:), 'b--', 'LineWidth', 2);
hold on; plot(t, xt(2,:), 'r:', 'LineWidth', 1.5)
xlabel('t (s)'); ylabel('x_2 = v (m/s)'); grid on;
legend('Tahmin Edilen','Doðru');

% Tahmin edilen hata gösterimi
figure(2);
subplot(2,1,1);
plot(t, x(1,:)-xt(1,:), 'm', 'LineWidth', 2)
xlabel ('t (s)'); ylabel('\Deltax_1 (m)'); grid on;
subplot(2,1,2);
plot(t, x(2,:)-xt(2,:), 'm', 'LineWidth', 2)
xlabel ('t (s)'); ylabel('\Deltax_2 (m/s)'); grid on;







