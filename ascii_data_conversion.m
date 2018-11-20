% ascii_data_conversion
% Christopher Zahasky
% 1/3/2018
clear all
close all

%% Notes
% This is the Matlab code to convert .mat data to ascii

% data matrix written such that:
% col 1 = y (up-down looking down the axis of the core), y = 0 is top of core
% col 2 = x (left-right looking down axis of core), x = 0 is left side
% col 3 = z (parallel to the axis of the core), z = 0 is inlet
% col 4 = time (sec)
% col 5 = raw radioactivity concentration

% Spatial data is in units of cm, time is in seconds, radioactivity
% concetration is in unscaled microcurries

% The default delimiter is comma, this can be changed to space, or tab
% (just change commenting in 'Data write to file' section).

%% Input
filename = 'BSS_c1_6ml_2_3mm_vox';

% timestep length for 3 mL/min
timestep_length = 40; % [seconds]

%% End Input
load(filename)
% crop buffer voxels off each edge
PET_4D_coarse = PET_4D_coarse(2:end-1, 2:end-1, :, :);

% voxel size in mm
vox_size = [0.776383*3 0.776383*3 0.796*3];

s = size(PET_4D_coarse);
total_voxels = prod(s);

% Time vector
T = ([1:s(4)].*timestep_length)- timestep_length/2;

% voxel center locations in cm
gridX = ([1:s(1)].*vox_size(1) - vox_size(1)/2)./10;
gridY = ([1:s(2)].*vox_size(2) - vox_size(2)/2)./10;
gridZ = ([1:s(3)].*vox_size(3) - vox_size(3)/2)./10;

% data matrix written such that:
% col 1 = y (up-down looking down the axis of the core), y = 0 is top of core
% col 2 = x (left-right looking down axis of core), x = 0 is left side
% col 3 = z (parallel to the axis of the core), z = 0 is inlet
% col 4 = time
% col 5 = raw radioactivity concentration
data_matrix = zeros(total_voxels, 5);
n=1;

PET_4D_coarse(isnan(PET_4D_coarse)) = 0;

for t = 1:s(4)
    for k=1:s(3)
        for i=1:s(1)
            for j=1:s(2)
                % concentration value
                conc = PET_4D_coarse(i,j,k,t);
                
                data_matrix(n,:) = [gridY(i), gridX(j), gridZ(k), ...
                    T(t), conc];
                
                n=n+1;
            end
        end
    end
end

%% Data write to file
% write matrix to ASCII, comma delimited
dlmwrite([filename, '_ASCII.txt'], data_matrix);

% write matrix to ASCII, tab delimited
% dlmwrite([filename, '_ASCII.txt'], 'delimiter','\t', data_matrix);

%% plot to check values
% figure
% A2 = squeeze(PET_4D_coarse(:,:,2,1));
% h = imagesc(A2);
% set(h,'alphadata',A2~=0)
% hold on
% colorbar
% axis equal
% axis tight
