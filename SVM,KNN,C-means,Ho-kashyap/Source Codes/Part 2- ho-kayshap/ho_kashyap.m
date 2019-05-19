clc;

% Read training and testing data for Ho-kashyap
train_data=fopen('train_case_1.dat');
training_set = cell2mat(textscan(train_data, '%f %f %f %f'));
fclose(train_data);

test_data=fopen('test_case_1.dat');
test_set = cell2mat(textscan(test_data, '%f %f %f %f'));
fclose(test_data);

% Filter test_case_1 data & Remove class 3 samples from test file

i=2;
 while (i<=15000)
     test_set(i,:)=0;
     i=i+6;
 end
 
 j=4;
 while (j<=15000)
     test_set(j,:)=0;
     j=j+6;
 end
k=1;

%test_set1=zeros(10000,4);
while (k<=10000)
    if test_set(k,:)==0
        test_set(k,:)=[];
    end
    k=k+1;
end


train_filtered = [ones(10000,1) training_set(1:10000,:)];
train_filtered(5001:10000,:) = -(train_filtered(5001:10000,:));

[w12] = ho_kashyap_fun(train_filtered);

train_filtered(5001:10000,:) = -(train_filtered(5001:10000,:));

%***************** HO_KASHYAP WITH TRAINING DATA : **************** 

% open file for writing to
file_op1 = fopen('ho-kayshap-training.txt', 'w');
op1 = zeros(10000,1);

for i = 1:10000
    z1 = train_filtered(i,:) * w12;
    
    if z1 > 0
        op1(i) = 1;
        fprintf(file_op1, '%d\n', 1);
    else
        op1(i) = 2;
        fprintf(file_op1, '%d\n', 2);
    end
    
end

gt1 = ones(10000,1);
gt1(1:5000,1) = 1;
gt1(5001:10000,1) = 2;

conf_ho_kashyap_train = confusionmat(gt1,op1);
fprintf('Confusion matrix for ho_kashyap training data is: \n');
disp(conf_ho_kashyap_train);

%***************** HO_KASHYAP WITH TESTING DATA : **************** 

test_set= [ones(10000,1) test_set(1:10000,:)];
file_op2 = fopen('ho-kayshap-testing.txt', 'w');
op2 = zeros(10000,1);

for i = 1:10000
    z2 = test_set(i,:) * w12;
    
    if z2 > 0
        op2(i) = 1;
        fprintf(file_op2, '%d\n', 1);
    else
        op2(i) = 2;
        fprintf(file_op2, '%d\n', 2);
    end    
end

fclose(file_op2);
test_data=fopen('ho-kayshap-testing.txt','r');
part2_set = cell2mat(textscan(test_data, '%d'));
fclose(test_data);

gt2 = ones(10000,1);
i=1;
while (i<=10000)
    gt2(i,:)=2;
    i=i+1;
    gt2(i,:)=1;
    i=i+1;
    gt2(i,:)=1;
    i=i+1;
    gt2(i,:)=2;
    i=i+1;
end

conf_ho_kashyap_test = confusionmat(gt2,op2);
fprintf('Confusion matrix for ho_kashyap testing data is: \n');
disp(conf_ho_kashyap_test);

function [w] = ho_kashyap_fun(y)

    w = ones(5,1);  % Initializing parameter w
    b = ones(10000,1); % Initializing parameter b
    iterations= 1000; % maximum steps
    rho = 0.9; % learning rate
    k = 0; % counter
    
    % Ho-Kashyap algorithm for updating parameter values
    while (k < iterations && min(y * w) < 0.01)     
        
        w = inv(y' * y) * y' * b;
        e = ((y * w) - b);
        c = (e + abs(e));
        b = b + (rho * c);
        k = k + 1;
    end
end
 

