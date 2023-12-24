% Lecture 9 example 1: Taxi company

S = [0 1 2 3];      % States
lambda = 2;         % Customer arrival rate, per hour
kappa  = 3;         % Cab freeing rate, per hour, for
                    % each cab that is occupied.

Q = [-lambda lambda 0 0;
    kappa -lambda-kappa lambda 0;
    0 2*kappa -lambda-2*kappa lambda;
    0 0 3*kappa -3*kappa]

% For illustration, let us start with
% all cabs free (state 0 certainly).
% Inspect state distributions at some
% points of time.

mu0 = [1 0 0 0];

figure(1)
clf

timelist = [0 1 2 1/60 1/3600];
for i=1:length(timelist)
    t = timelist(i);
    subplot(1,length(timelist),i);
    
    fprintf('\nAt t=%.4f hours:\n', t);
    Pt = expm(t*Q)
    mut = mu0*Pt
    bar(S, mut);
    set(gca,'fontsize',20);
    xlabel('cabs occupied');
    ylabel('probability');
    title(sprintf('At t=%.4f', t));
    %pause
end

% Final illustration:
% Continuous evolution of the state distribution
% over time, from t=0 to t=2 hours.
%
figure(2)
clf
npoints = 100;
timelist = linspace(0, 2, npoints);
mulist = zeros(npoints, length(S));
for i=1:npoints
    t   = timelist(i);
    Pt  = expm(t*Q);
    mut = mu0*Pt;
    mulist(i,:) = mut;
end
plot(timelist, mulist, '-', 'linewidth', 2);
set(gca,'fontsize',20);
legend(num2str(S'));
grid on
xlabel('t [hours]');
ylabel('state probability');
