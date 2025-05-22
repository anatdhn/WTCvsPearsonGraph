function[rsqMed] = RSQ(A)
% Load or define the coopD1_combined matrix (971x32)
% Assuming coopD1_combined is already in the workspace
% Columns 1:16 are sub1, columns 17:32 are sub2

% Pre-check for problematic channels
fprintf('Checking for problematic channels...\n');
%for ch = 1:32
for ch = 1:24
    signal = A(:, ch);
    
    % Detailed checks for each channel
    hasNaN = any(isnan(signal));
    hasInf = any(isinf(signal));
    signalStd = std(signal);
    numUnique = length(unique(signal));
    numRows = size(signal, 1); % Should be 971 based on matrix size
    
    % Print issues if found
    if hasNaN
        fprintf('Channel %d has NaN values.\n', ch);
    end
    if hasInf
        fprintf('Channel %d has Inf values.\n', ch);
    end
    if signalStd < 1e-6
        fprintf('Channel %d has near-zero variance (std = %.2e).\n', ch, signalStd);
    end
    if numUnique == 1
        fprintf('Channel %d has constant values (std = %.2e, %d unique values).\n', ch, signalStd, numUnique);
    elseif numUnique < numRows
        fprintf('Channel %d has repeated values (%d unique values out of %d rows, std = %.2e).\n', ch, numUnique, numRows, signalStd);
    end
end

% Initialize output matrix
%rSqure = zeros(32, 32);
rSqure = zeros(24, 24);

% Loop over all channel pairs
%for i = 1:32
 %   for j = 1:32
 for i = 1:24
    for j = 1:24
        try
            % Extract signals for channel i (sub1 or sub2) and channel j (sub1 or sub2)
            signal1 = A(:, i);
            signal2 = A(:, j);
            
            % Check for valid signals
            if any(isnan(signal1)) || any(isinf(signal1)) || any(isnan(signal2)) || any(isinf(signal2))
                warning('NaN or Inf detected in signals for channels (%d, %d). Assigning NaN.', i, j);
                rSqure(i, j) = NaN;
                continue;
            end
            
            % Ensure signals are non-empty and numeric
            if isempty(signal1) || isempty(signal2) || ~isnumeric(signal1) || ~isnumeric(signal2)
                warning('Invalid or empty signals for channels (%d, %d). Assigning NaN.', i, j);
                rSqure(i, j) = NaN;
                continue;
            end
            
            % Additional check for variance
            if std(signal1) < 1e-6 || std(signal2) < 1e-6
                warning('Near-zero variance in signals for channels (%d, %d). Assigning NaN.', i, j);
                rSqure(i, j) = NaN;
                continue;
            end
            
            % Compute Wavelet Transform Coherence
            [Rsq, period] = wtc(signal1, signal2, 'mcc', 0)
            figure
            
            
            % Convert period to frequency (Hz)
            frequency = 1 ./ period;
            
            % Find indices for frequency range 0.02–0.10 Hz
            rangeFreq = find(frequency >= 0.02 & frequency <= 0.10);
            
            % Check if rangeFreq is non-empty to avoid errors
            if ~isempty(rangeFreq)
                % Average Rsq over the specified frequency range
                rSqure(i, j) = mean(Rsq(rangeFreq, :), 'all', 'omitnan');
            else
                warning('No frequencies in range 0.02–0.10 Hz for channels (%d, %d). Assigning NaN.', i, j);
                rSqure(i, j) = 0;
               % rSqure(i, j) = NaN;
            end
        catch err
            % Catch and report errors for specific channel pairs
            warning('Error computing WTC for channels (%d, %d): %s. Assigning NaN.', i, j, err.message);
            rSqure(i, j) = NaN;
        end
    end
end

%replace NAN with 0

for i = 1:24
    for j = 1:24
        if(isnan(rSqure(i, j)))
            rSqure(i, j) = 0;
        end
    end
end
% The resulting rSqure is a 32x32 matrix:
% - rSqure(1:12 1:12): intra-brain for sub1
% - rSqure(13:24, 13:24): intra-brain for sub2
% - rSqure(1:12, 13:24): inter-brain (sub1 to sub2)
% - rSqure(13:24, 1:12): inter-brain (sub2 to sub1)

out = median(median(rSqure))
for i=1:24
    for j=1:24
        if rSqure(i,j)<out
            rsqMed(i,j) =0;
        else
            rsqMed(i,j)= rSqure(i,j);

        end
    end
end

% Save and visualize results

% save('Dyad_WTC_Rsq.mat', 'rSqure');
figure;
imagesc(rSqure); 
colorbar; 
title('WTC Rsq Matrix');
xlabel('Channel'); 
ylabel('Channel');