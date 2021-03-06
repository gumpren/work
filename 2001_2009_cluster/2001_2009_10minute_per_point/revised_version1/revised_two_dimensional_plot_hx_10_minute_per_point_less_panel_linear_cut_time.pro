pro revised_two_dimensional_plot_hx_10_minute_per_point_less_panel_linear_cut_time

  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_10minute_per_point\revised_version1\'
  
  title_char='two_dimensional_plot_hx_less_panel'
  bbindex=0
  
  restore,filename=root_dir+'raw_data'+save_str+'_list_10minute_per_point.sav'
  Hx=list(length=10)
  posx=list(length=10)
  posy=list(length=10)
  event_hx=list(length=10)
  aa1=fltarr(30)
  bb1=fltarr(10)
  
  for i=0,29 do begin
    H_temp=H_re[i]
    pos_gsm_temp=pos_gsm[i]
    append_Array,H_x,reform(H_temp[*,0],(size(H_temp))[1])
    append_Array,pos_gsm_x,reform(pos_gsm_temp[*,0],(size(pos_gsm_temp))[1])
    append_Array,pos_gsm_y,reform(pos_gsm_temp[*,1],(size(pos_gsm_temp))[1])    
    if ((i+1) mod 3) eq 0  then begin
      Hx[(i+1)/3-1]=H_x
      posx[(i+1)/3-1]=pos_gsm_x
      posy[(i+1)/3-1]=pos_gsm_y
      event_hx[(i+1)/3-1]=return_vari_event(pos_gsm_x,pos_gsm_y,H_x,reverse_gap)
      bb1[(i+1)/3-1]=n_elements(H_x)
      undefine,H_x,pos_gsm_x,pos_gsm_y
  
    endif
    aa1[i]=n_elements((H_re[i])[*,0])
    print,i
  endfor
  
  
  ;cgdisplay
  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(2,5,left=0.01,right=0.88,xgap=0.03,ygap=0.04,low=0.01,high=0.8)

  factor_to_kev=1.0;1.0e6/(1000.0*11600)

  bar_title1='Density (cm!u-3!n!x)'
  bar_title2='Temperature (keV)'
  bar_title3='Pressure (nPa)'
  bar_title4='Velocity_x(km/s)'
  bar_title5='H!dX!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
  bar_title6='K!dX!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'

  zrange1=[0.05,0.5];N
  zrange2=[0.15,6.0];T
  zrange3=[0.01,0.2];P
  zrange4=[-50,50];V
  zrange5=[-0.3,0.3];H
  zrange6=[-0.001,0.001];K
 
  bar_title=[bar_title5,bar_title5]
  zrange=[[zrange5],[zrange5]]

  for i=0,9 do begin
    event_hx[i]=reform(event_hx[i],10*30*reverse_gap^2)
  endfor

  data=[[[event_hx[0]],[event_hx[1]],[event_hx[2]],[event_hx[3]],[event_hx[4]]],$
        [[event_hx[5]],[event_hx[6]],[event_hx[7]],[event_hx[8]],[event_hx[9]]]]
           
  x=linspace(-20,-10,10*reverse_gap+1)
  v=linspace(-15,15,30*reverse_gap+1)  ; connect to the return_vari function. follow the same start point
  xrange=[-10,-20]
  yrange=[15,-15]

  duration=list(length=10)
  for jj = 0, 9 do begin
     if (jj ge 0) and (jj le 4)  then duration[jj]=[jj*3*10,jj*3*10+30]
     if (jj ge 5) and (jj le 9)  then duration[jj]=[(jj-5)*3*10,(jj-5)*3*10+30]
  endfor
  
  panel_titles=['B!dz!n!x>0','B!dz!n!x<0']
  ptitle=strarr(2,5)
  for i=0,1 do begin
    if i eq 0 then panel_title=panel_titles[0]
    if i eq 1 then panel_title=panel_titles[1]
    for j=0,4 do begin
      ptitle[i,j]=panel_title+' ['+strcompress((duration[j])[0],/remove)+','+strcompress((duration[j])[1],/remove)+']'
    endfor
  endfor

  ;  ;v      change : title,not change; image, change
  ;yrange change : title, change  ;  image, change
  idx=where(data eq 0)
  data[idx]=!values.f_nan
  ;cgloadct,38;,/reverse
  ;cgloadct,72,/reverse
  ;  restore,'E:\OneDrive\IDLworks\Other\blue_white_red_256.ctl'
  ;  tvlct,r,g,b


  ;str_element,extra,'title','test',/add
  str_element,opt_plot,'charsize',0.8,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'xticks',2,/add
  str_element,opt_plot,'xrange',xrange,/add
  str_element,opt_plot,'yrange',yrange,/add

  ;str_element,opt_bar,'position',[],/add
  str_element,opt_bar,'no_color_scale',0,/add
  str_element,opt_bar,'charsize',0.8,/add
  str_element,opt_bar,'title',bar_title,/add

  restore,'E:\OneDrive\IDLworks\Work\Other\blue_white_red_256.ctl'

  tvlct,r,g,b


  for i=0,1 do begin
    str_element,opt_bar,'title',bar_title[i],/add
    for j=0,4 do begin
      ;str_element,opt_plot,'title',title0[j,i],/add

      ;      if i eq 0 then begin
      ;        bottom=0
      ;        ncolors=253
      ;        cgloadct,34,ncolors=ncolors,bottom=bottom
      ;      endif else begin
      ;        restore,'E:\OneDrive\IDLworks\Other\blue_white_red_256.ctl'
      ;        tvlct,r,g,b
      ;      endelse
      if j ne 0 then begin
        str_element,opt_plot,'ytickformat','(a1)',/add
        str_element,opt_plot,'ytitle',/delete
      endif else begin
        str_element,opt_plot,'ytickformat',/delete
        str_element,opt_plot,'ytitle','Y(Re)',/add
      endelse

      if i ne 1 then begin
        str_element,opt_plot,'xtickformat','(a1)',/add
        str_element,opt_plot,'xtitle',/delete
      endif else begin
        str_element,opt_plot,'xtickformat',/delete
        str_element,opt_plot,'xtitle','X(Re)',/add
      endelse

      if j eq 4 then str_element,opt_bar,'no_color_scale',0,/add else str_element,opt_bar,'no_color_scale',1,/add
      str_element,opt_bar,'position',[pos[i,j,2]+0.02,pos[i,j,1],pos[i,j,2]+0.05,pos[i,j,3]],/add
      d={x:x,y:reform(data[*,j,i],10*reverse_gap,30*reverse_gap),v:v}
      color_fill,pos[i,j,*],d,xrange=xrange,yrange=yrange,zrange=zrange[*,i],top=255,bottom=30,backcolor='grey',opt_plot=opt_plot,opt_bar=opt_bar
      labels_stamp,pos[i,j,*],ptitle[i,j],charsize=0.9,/left_right_center,/up_out
    endfor                                                      ;[-0.3,0.3] thermal EFD range
  endfor

  ;labels_stamp,pos[*,*,*],'  '+['(a)','(e)','(b)','(f)','(c)','(g)','(d)','(h)'],charsize=1.5,/left_in,/up_in
  ;labels_stamp,pos[1,*,*],'  '+['(e)','(f)','(g)','(h)'],charsize=1.5,/left_in,/up_in

  cgps_close

   stop


end