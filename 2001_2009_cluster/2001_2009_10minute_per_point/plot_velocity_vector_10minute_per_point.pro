pro plot_velocity_vector_10minute_per_point

  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_10minute_per_point\'
    
  title_char='full_velocity_vector_IMFBZ_north_10minute_per_point';
  panel_title='B!dz!n!x>0'
  bbindex=0

  restore,filename=root_dir+'full_event_data'+save_str+'_list_10minute_per_point.sav'
   
  ;cgdisplay
  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0;,/ENCAPSULATED
  pos=set_plot_position(3,5,left=0.05,right=0.72,xgap=0.02,ygap=0.02,low=0.01,high=0.95)


  bar_title0='Velocity (cm!u-3!n!x)'
;  bar_title1='K (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
;  bar_title2='H (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
;  bar_title=[bar_title0,bar_title1,bar_title2]
  
  
  for i=0,14 do begin
    event_vx[i]=reform(event_vx[i+bbindex],10*30*reverse_gap^2)
    event_vy[i]=reform(event_vy[i+bbindex],10*30*reverse_gap^2)
  endfor

  
  a=findgen(30)
  duration=list(a,/ex)
  for jj = 0, 29 do begin
    if (jj ge 0) and (jj le 14)  then duration[jj]=[jj*10,jj*10+10]
    if (jj ge 15) and (jj le 29)  then duration[jj]=[(jj-30)*10,(jj-30)*5]
  endfor
  
  ptitle=strarr(3,5)
  for i=0,2 do begin
    for j=0,4 do begin
      ptitle[i,j]=panel_title+' ['+strcompress((duration[j+i*5])[0],/remove)+','+strcompress((duration[j+i*5])[1],/remove)+']'
    endfor
  endfor
 
; 
;  v_ge_100_index_per=dblarr(30)
;  for i=0,29 do begin
;    vv=sqrt((event_vx[i+30])^2+(event_vy[i+30])^2)
;    v_ge_100_index=where(vv gt 100)
;    v_ge_100_index_per[i]=n_elements(v_ge_100_index)/float(n_elements(event_vx[i]))
;  endfor
  ;  vx1=reform(event_vx1,10*30*reverse_gap^2) & vx2=reform(event_vx2,10*30*reverse_gap^2) & vx3=reform(event_vx3,10*30*reverse_gap^2) & vx4=reform(event_vx4,10*30*reverse_gap^2)
  ;  vy1=reform(event_vy1,10*30*reverse_gap^2) & vy2=reform(event_vy2,10*30*reverse_gap^2) & vy3=reform(event_vy3,10*30*reverse_gap^2) & vy4=reform(event_vy4,10*30*reverse_gap^2)
  ;  qkx1=reform(K_Re_x1,10*30*reverse_gap^2)  & qkx2=reform(K_Re_x2,10*30*reverse_gap^2)  & qkx3=reform(K_Re_x3,10*30*reverse_gap^2)  & qkx4=reform(K_Re_x4,10*30*reverse_gap^2)
  ;  qky1=reform(K_Re_y1,10*30*reverse_gap^2)  & qky2=reform(K_Re_y2,10*30*reverse_gap^2)  & qky3=reform(K_Re_y3,10*30*reverse_gap^2)  & qky4=reform(K_Re_y4,10*30*reverse_gap^2)
  ;  qhx1=reform(H_Re_x1,10*30*reverse_gap^2)  & qhx2=reform(H_Re_x2,10*30*reverse_gap^2)  & qhx3=reform(H_Re_x3,10*30*reverse_gap^2)  & qhx4=reform(H_Re_x4,10*30*reverse_gap^2)
  ;  qhy1=reform(H_Re_y1,10*30*reverse_gap^2)  & qhy2=reform(H_Re_y2,10*30*reverse_gap^2)  & qhy3=reform(H_Re_y3,10*30*reverse_gap^2) & qhy4=reform(H_Re_y4,10*30*reverse_gap^2)
  

  event_x=[[[event_vx[0]],[event_vx[1]],[event_vx[2]],[event_vx[3]],[event_vx[4]]],$
           [[event_vx[5]],[event_vx[6]],[event_vx[7]],[event_vx[8]],[event_vx[9]]],$
           [[event_vx[10]],[event_vx[11]],[event_vx[12]],[event_vx[13]],[event_vx[14]]]]                                                                                             
  event_y=[[[event_vy[0]],[event_vy[1]],[event_vy[2]],[event_vy[3]],[event_vy[4]]],$
           [[event_vy[5]],[event_vy[6]],[event_vy[7]],[event_vy[8]],[event_vy[9]]],$
           [[event_vy[10]],[event_vy[11]],[event_vy[12]],[event_vy[13]],[event_vy[14]]]]
  x=linspace(-20,-10,10*reverse_gap+1)
  y=linspace(-15,15,30*reverse_gap+1)
  ;  xrange=minmax(x)
  ;  yrange=minmax(y)

  xrange=[-10,-20]
  yrange=[15,-15]
   

;  title0=['B!dz!n!x>0 [5,30]','B!dz!n!x>0 [30,90]','B!dz!n!x>0 [90,]',$
;    'B!dz!n!x<0 [5,30]','B!dz!n!x<0 [30,90]','B!dz!n!x<0 [90,]']
  str_element,opt_plot,'charsize',0.6,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'XMINOR',2,/add
  str_element,opt_plot,'xrange',xrange,/add
  str_element,opt_plot,'yrange',yrange,/add

  str_element,opt_bar,'charsize',0.9,/add

  ;missing=[80,0.3,0.001]
  
  missing=100
  length=2.0
  ; overplot=dblarr(3,4)
  ; REPLICATE_INPLACE,overplot,1
  for i=0,2 do begin
    str_element,opt_bar,'title',bar_title0,/add
    for j=0,4 do begin
      if j ne 0 then begin
        str_element,opt_plot,'ytickformat','(a1)',/add
        str_element,opt_plot,'ytitle',/delete
      endif else begin
        str_element,opt_plot,'ytickformat',/delete
        str_element,opt_plot,'ytitle','Y(Re)',/add
      endelse

      if i ne 2 then begin
        str_element,opt_plot,'xtickformat','(a1)',/add
        str_element,opt_plot,'xtitle',/delete
      endif else begin
        str_element,opt_plot,'xtickformat',/delete
        str_element,opt_plot,'xtitle','X(Re)',/add
      endelse

      cgplot,reform(event_x[*,j,i],10*reverse_gap,30*reverse_gap),reform(event_y[*,j,i],10*reverse_gap,30*reverse_gap),position=pos[i,j,*],$;xlog=xlog,ylog=ylog,
        /normal,/nodata,/noerase,_extra=opt_plot
      print,i
    endfor
  endfor

  for i=0,2 do begin
    for j=0,4 do begin
      ;str_element,opt_bar,'title',bar_title[i],/add
      ;cgDrawVectors,reform(event_x[*,j,i],12,36),reform(event_y[*,j,i],12,36),X[0:n_elements(x)-2],Y[0:n_elements(y)-2]
      ;cgArrow,

      VELOVECT,reform(event_x[*,j,i],10*reverse_gap,30*reverse_gap),reform(event_y[*,j,i],10*reverse_gap,30*reverse_gap),X[0:n_elements(X)-2],Y[0:n_elements(Y)-2] $
        ,COLOR=5,MISSING=missing,LENGTH=length,position=pos[i,j,*],/noerase,/DOTS,$;,/OVERPLOT,LENGTH=value,/nodata,
         xstyle=4+1,ystyle=4+1,xrange=xrange,yrange=[15,-15],thick=1.5;,_extra=opt_plot ;,/nodata,background=240
      ;        ,xticks=5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],$
      ;        yticks=6,ytickv=[15,10,5,0,-5,-10,-15],yminor=5,yticklen=0.05,yrange=[15,-15],$;
      ;        xtitle='X!DGSM!N(R!DE!N)',$;
      ;        ytitle='Y!DGSM!N(R!DE!N)',charsize=0.8
      print,i
      labels_stamp,pos[i,j,*],ptitle[i,j],charsize=0.5,/left_right_center,/up_out
    endfor
  endfor
;  labels_stamp,pos[0,*,*],ptitle[*,0],charsize=0.8,/left_right_center,/up_out

  ;  labels_stamp,pos[*,3,*],bar_title0[*,0],charsize=0.8,/up_down_center,/right_out
  arrow_length=((pos[0,0,*])[2]-(pos[0,0,*])[0])/(10*reverse_gap)*length
  cgArrow, 0.74, 0.925, 0.74+arrow_length, 0.925, /Normal, Color='black', /Solid, thick=1.5, hsize=!D.X_SIZE/128.0
  xyouts,0.77,0.92,'V ('+strcompress(missing)+'km/s)',color=-1,alignment=0,charsize=0.5,font=0,/normal
;  xyouts,0.99,0.5,'H (1.0 (10!u16!n!xergs!u-1!n!xRe!u2!n!x))',color=0,alignment=-0.2,charsize=0.6,font=0,/normal
;  xyouts,0.99,0.2,'K (0.003(10!u16!n!xergs!u-1!n!xRe!u2!n!x))',color=0,alignment=-0.2,charsize=0.6,font=0,/normal
  cgps_close
  
  stop

end