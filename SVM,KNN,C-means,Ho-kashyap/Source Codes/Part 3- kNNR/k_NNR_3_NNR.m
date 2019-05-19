clc;
clear all;

% Read training and testing data
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
while (k<=10000)
    if test_set(k,:)==0
        test_set(k,:)=[];
    end
    k=k+1;
end

% run knn for 3 neighbors (K = 3)
training_set=training_set(1:10000,:);
s3 = knn_calculation(training_set, test_set, 3);

part3_data3=fopen('knn-result_3_NNR.txt');
part3_set3 = cell2mat(textscan(part3_data3, '%d'));
fclose(part3_data3);

truePred3=0;
c3=1;
%q=5001;
while (c3 <=10000)
    if part3_set3(c3)==2
        truePred3=truePred3+1;
    end
    c3=c3+1;
    if part3_set3(c3)==1
        truePred3=truePred3+1;
    end
    c3=c3+1;
    if part3_set3(c3)==1
        truePred3=truePred3+1;
    end
    c3=c3+1;
    if part3_set3(c3)==2
        truePred3=truePred3+1;
    end
    c3=c3+1;
     
end

gt3 = ones(10000,1);
i=1;
while (i<=10000)
    gt3(i,:)=2;
    i=i+1;
    gt3(i,:)=1;
    i=i+1;
    gt3(i,:)=1;
    i=i+1;
    gt3(i,:)=2;
    i=i+1;
end

conf3=confusionmat(gt3,double(part3_set3));
disp(conf3);
fprintf('Correctly classified in 3 NNR :%d\n', truePred3);
accuracy3=(truePred3/10000)*100;
fprintf('Accuracy for 3 NNR: %f\n', accuracy3);
fprintf('Probability of error for 3 NNR: %f\n', 100-accuracy3);

function [op3] = knn_calculation(training, testing, n)

    gTruth = zeros(10000, 1);
    gTruth(1:5000) = 1;
    gTruth(5001:10000) = 2;
    
    % open files for writing to
    file3 = fopen('knn-result_3_NNR.txt', 'w+');

    for i = 1:10000
        dist3 = zeros(10000, 1);
        
        q1 = 0;
        q2 = 0;
         
        for j = 1:10000
            dist3(j) = norm(testing(i,:)-training(j,:)); % Eucliden distance
        end
        distances_computed = horzcat(dist3, gTruth);
        op3 = sortrows(distances_computed, 1);
            
        if n == 3
            for k = 1:3
                if op3(k,2) == 1
                    q1 = q1 + 1;
                elseif op3(k,2) == 2
                    q2 = q2 + 1;
                end
            end
            
            if q1 > q2 
                fprintf(file3, '%d\n', 1);
            elseif q2 > q1 
                fprintf(file3, '%d\n', 2);
            end  
        end
    end
    fclose(file3);
end
