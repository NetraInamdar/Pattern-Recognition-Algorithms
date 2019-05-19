clear
clc

% Define data size and apriori probabilities for each class
data_size = 15000;
pw1=1/3;
pw2=1/3;
pw3=1/3;

% Read training and testing data
train_data=fopen('train_case_1.dat');
training_set = cell2mat(textscan(train_data, '%f %f %f %f'));
fclose(train_data);

test_data=fopen('test_case_1.dat');
test_set = cell2mat(textscan(test_data, '%f %f %f %f'));
fclose(test_data);

% Split training data into 3 classes
w1 = training_set(1:5000,:);
w2 = training_set(5001:10000,:);
w3 = training_set(10001:15000,:);

% calculate class specific mean vectors and covariance matrices
mu_w1 = mean(w1);
sigma_w1 = cov(w1);

mu_w2 = mean(w2);
sigma_w2 = cov(w2);

mu_w3 = mean(w3);
sigma_w3 = cov(w3);

% open file for writing classification results
out_file = fopen('takehome1_case_1.txt', 'w');

% preallocate class vector
class = zeros(data_size,1);
train_labels = zeros(data_size,1);

% calculate discriminant function based on the Gaussian model
for i = 1:data_size
    x = test_set(i,:); 
    g1 = -(0.5*(x-mu_w1)*inv(sigma_w1)*(x-mu_w1)')-(0.5*log(det(sigma_w1)))+(log(pw1));
    g2 = -(0.5*(x-mu_w2)*inv(sigma_w2)*(x-mu_w2)')-(0.5*log(det(sigma_w2)))+(log(pw2));
    g3 = -(0.5*(x-mu_w3)*inv(sigma_w3)*(x-mu_w3)')-(0.5*log(det(sigma_w3)))+(log(pw3));
    
    if g1 > g2 && g1 > g3
        class(i) = 1;
    elseif g2 > g1 && g2 > g3
        class(i) = 2;
    else
        class(i) = 3;
    end
    
    % write classification of ith vector line by line
    fprintf(out_file, '%d\n',class(i));
        
end

% Check the number of samples in each class after classification
c1=0;c2=0;c3=0;
for i=1:data_size
    if class(i)==1
        c1=c1+1;
    elseif class(i)==2
        c2=c2+1;
    else
        c3=c3+1;
    end
end

fprintf('*** Case 1 test data results: ***\n');
fprintf('No. of samples in class 1: %d\t,class 2: %d\t,class 3: %d\t',c1,c2,c3);
fprintf('\nDeviation from ideal results for each class in test set:');
d1=abs((c1-(pw1*data_size))/data_size);
d2=abs((c2-(pw2*data_size))/data_size);
d3=abs((c3-(pw3*data_size))/data_size);
fprintf('\nclass 1: %0.4f\tclass 2: %0.4f\tclass 3: %0.4f\n',d1,d2,d3);

% close output file
fclose(out_file);
