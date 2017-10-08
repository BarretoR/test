clear all
close all
clc
%%
files_path_in = {'/mnt/rogerio/Mestrado/FaceSpoofing/Datasets/OULU_NPU/Train_files/'}
files_path_out = {'/mnt/rogerio/Mestrado/FaceSpoofing/Datasets/OULU_NPU/Train_inputs/'}
%%
parpool;
for i = 1:numel(files_path_in)
    files = dir([files_path_in{i},'*.avi'])
    parfor j = 1:numel(files)
        j
        [pathstr, name, ext] = fileparts(files(j).name);
        video_file = [files_path_in{i}, name, '.avi'];
        eye_position_file = [files_path_in{i}, name, '.txt'];
        Faces = Extract_faces(video_file, eye_position_file);
            
    end
end