clc;
clear;
clear all;

%%Do�ru i�aret ve �l��m tan�m�:
%Sistem De�i�kenleri Tan�m�

N = 1000;                 % ��lemin nerede bitece�inin tan�m�
dt = 0.001;               % �rneklerin hangi aral�kta al�naca��n�n tan�m�
t = dt * (1:N);           % Zaman vekt�r�
F = [1, dt; 0, 1];        % Durum matrisi tan�m�
G = [-1/2*dt^2 ; -dt];   % Girdi matrisi tan�m�
H = [1 0];                % G�zlem matrisi tan�m�
Q = zeros(2);             % S�re� g�r�lt�s� kovaryans�
u = 9.80665;              % Girdi tan�m�, yer �ekimi ivmesi
I = [ 1 , 0 ; 0 , 1];     % Birim Matris

%Ba�lang�� konumu ve h�z� hesaplamas�

y0 = 100;
v0 = 0;

%Do�ru durum i�in durum vekt�r� belirlenmesi

xt = zeros(2, N);        % Do�ru durum vekt�r�
xt(:,1) = [y0;v0];       % Do�ru ba�lang�� durumu;

%Durumun hesab� i�in d�ng�
for k = 2:N
    %Durumun tahmin denklemi �zerindeki da��l�m�
    xt(:, k) = F * xt(:, k-1) + G*u;
end
% Do�ru durum �zerinden g�r�lt�l� �l��m �retimi
R = 4;                   % m^2/s^2
v = sqrt(R)*randn(1, N); % �l��m g�r�lt�s�
z = H*xt + v;            % G�r�lt�l� �l��m
%%Kalman Tahmininin belirlenmesi
% Tahmin edilen durumu belirle
x = zeros(2,N);          % Tahmin durum vekt�r�
x(:, 1) = [105; 0];      % Ba�lang�� durumu tahmini
% Kovaryans matrisi belirlenmesi
P = [10, 0; 0, 0.01]; % Ba�lang�� durum hatas� kovaryans�
% Tekrarl� Kalman Filtre d�ng�s� tan�m�
for k = 2:N
 % Durum vekt�r tahmini
 x(:, k) = F*x(:, k-1) + G*u;
 % Kovaryans tahmini
 P = F*P*F' + Q;
 % Kalman Kazan� matrisi hesab�
 K = P*H'/(H*P*H' + R);
 % Durum vekt�r� g�ncellemesi
 x(:,k) = x(:,k) + K*(z(k) - H*x(:,k));
 % Kovaryans g�ncellemesi
 P = (I - K*H)*P;
end
%% Sonu�lar�n g�sterimi
% Durumlar�n g�sterimi
figure(1);
subplot(2,1,1);
plot(t, z, 'g-', t, x(1,:), 'b--', 'LineWidth', 2);
hold on; plot(t, xt(1,:), 'r:', 'LineWidth', 1.5)
xlabel('t (s)'); ylabel('x_1 = h (m)'); grid on;
legend('�l��len','Tahmin Edilen','Do�ru');
subplot(2,1,2);
plot(t, x(2,:), 'b--', 'LineWidth', 2);
hold on; plot(t, xt(2,:), 'r:', 'LineWidth', 1.5)
xlabel('t (s)'); ylabel('x_2 = v (m/s)'); grid on;
legend('Tahmin Edilen','Do�ru');

% Tahmin edilen hata g�sterimi
figure(2);
subplot(2,1,1);
plot(t, x(1,:)-xt(1,:), 'm', 'LineWidth', 2)
xlabel ('t (s)'); ylabel('\Deltax_1 (m)'); grid on;
subplot(2,1,2);
plot(t, x(2,:)-xt(2,:), 'm', 'LineWidth', 2)
xlabel ('t (s)'); ylabel('\Deltax_2 (m/s)'); grid on;







