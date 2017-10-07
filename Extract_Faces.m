function Faces=Extract_Faces_video(file_vid,file_pos)
fileID = fopen(file_pos);
face_pos=textscan(fileID,'%d %d %d %d %d','Delimiter',',');
vid = VideoReader(file_vid);  
Frames=read(vid,[1 Inf]);
Indices=face_pos{1};
Indices =Indices(size(Indices,1));
base_points=[16 24; 48 24];
cpt=0;
for j=1:size(Indices,1)  
      ind=Indices(j);
      if ((face_pos{2}(j)~=0)&&(face_pos{3}(j)~=0)&&(face_pos{4}(j)~=0)&&(face_pos{5}(j)~=0))
          cframe = Frames(:,:,:,ind+1);
          input_points(1,1)=face_pos{2}(j);
          input_points(1,2)=face_pos{3}(j);
          input_points(2,1)=face_pos{4}(j);
          input_points(2,2)=face_pos{5}(j); 
          t = cp2tform(double(input_points),base_points,'linear conformal');
          Faces.data{j}=imtransform(cframe,t,'XData',[1 64], 'YData',[1 64]);
          Faces.exist(j)=1;   
          cpt =cpt+1;
          if cpt==75
              break;
          end
      end
end
fclose(fileID);