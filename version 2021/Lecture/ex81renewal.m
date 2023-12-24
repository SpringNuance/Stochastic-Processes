% Lecture 8 example: Simulating a renewal process
%
% Try three types of processes:
% type=1, constant renewal time 10 minutes (like a metro)
% type=2, Exp-distributed renewal with mean 10 minutes
% type=3, randomly two times (2 and 8) with equal probabilities,
%         very roughly like waiting for eruptions of the Old Faithful.
%
function ex81renewal(type)
if nargin<1, type=1; end

n = 1000;      % simulate this many renewals
nshow = 20;    % but plot only this many

if type==1
    tau = repmat(10, 1, n);
elseif type==2
    tau = exprnd(10, 1, n);
elseif type==3
    long = rand(1,n) < 0.5;
    tau = 2 + 6*long;
end

T = cumsum(tau);

clf
subplot(2,1,1)
plot(T(1:nshow), zeros(1,nshow), 'ro', 'markerfacecolor', 'r');
hold on
for i=0:nshow
    if i==0
        Tnow = 0;
    else
        Tnow = T(i);
    end
    plot([Tnow T(i+1)], [tau(i+1) 0], 'k-', 'linewidth', 2);
    plot([Tnow Tnow], [0 tau(i+1)], 'k:');
end
legend('events', 'waiting time');

subplot(2,1,2)
% uniformly random arrival times = times to start waiting
narrivals = 100000;
M = max(T);
t = unifrnd(0,M,1,narrivals);
W = zeros(1,narrivals);
for i=1:narrivals
    nextpoint = min(T(T>t(i)));
    W(i)      = nextpoint-t(i);
end

hist(W,300);
fprintf('average waiting time = %.3g\n', mean(W));
hold on
plot(mean(W), 0, 'go', 'markerfacecolor', 'g');

