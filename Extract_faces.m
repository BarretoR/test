function Faces = Extract_faces(file_vid, file_eye_pos)
    file_id = fopen(file_eye_pos);
    eye_pos = textscan(file_id, '%d %d %d %d %d', 'Delimiter', ',');
    vid = VideoReader(file_vid);

    while hasFrame(vid)
        frame = readFrame(vid);
        
    end
end