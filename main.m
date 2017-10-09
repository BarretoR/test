clear all
close all
clc
%%
files_path_in = {'../datasets/OULU_NPU/Test_files/'}
files_path_out = {'../datasets/OULU_NPU/Test_inputs/'}
%%

for i = 1:numel(files_path_in)
    files = dir([files_path_in{i},'*.avi'])
    for j = 1:numel(files)
        j
        [pathstr, name, ext] = fileparts(files(j).name);
        name
        video_file = [files_path_in{i}, name, '.avi'];
        eye_position_file = [files_path_in{i}, name, '.txt'];
        if ~exist(strcat(files_path_out{i},name),'dir')
            Faces = Extract_faces(video_file, eye_position_file);
            if Faces.flag >= 35
                mkdir(strcat(files_path_out{i},name))
                for a = 1:size(Faces.data,2)
                    if Faces.exist{a} == 1
                        imwrite(Faces.data{a},strcat(files_path_out{i},name,'/',num2str(a),'.jpg'));
                    end
                end
            end
        end
    end
end
