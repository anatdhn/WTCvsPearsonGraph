

 function[rMed] = rpearson(A)
 

% Calculate correlation coefficient matrix
[R, P] = corrcoef(A);s

% Get the number of channels (columns) in your time series data
numChannels = size(A, 2);
%Iterate through all pairs of columns
for i = 1:numChannels
    for j = 1:numChannels

        if R(i, j) < 0.01
            % Replace R with 0
            R(i, j) = 0;
            %R(i, j) = abs(R(i,j)); %abs instead
        end
    end
end

% Display the modified correlation coefficients (R values)
disp("Modified correlation coefficients (R values):");
%disp(R);
out = median(median(R));


for i=1:22
    for j=1:22
            if R(i,j)<out
                rMed(i,j) =0;
            elseif(R(i, j) < 0)
                % Replace R with 0
                rMed(i, j) = 0;

            else
                rMed(i,j)= R(i,j);
            end


% 
%     end
% end

% save('Dyad_pearson.mat', 'R');
figure;
imagesc(R); 
colorbar; 
title('pearson Matrix');
xlabel('Channel'); 
ylabel('Channel');
disp(P);