pro revised_two_dimensional_plot_hx

  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_10minute_per_point\revised_version1\'
  
  
  restore,filename=root_dir+'event_data'+save_str+'_list_10minute_per_point.sav'
  
  for i=0,29 do begin    
    event_hx_temp=reform(event_hx[i],10*30*reverse_gap^2)
    id=where(event_hx_temp lt 0)
    event_hx_temp[id]=0
    event_hx[i]=reform(event_hx_temp,10*reverse_gap,30*reverse_gap)
                  
  endfor
      
  title_char='66logHx_Bz_northward_two_dimensional_plot'
  panel_title='B!dz!n!x>0'
  bbindex=0
  zrange5=[0.01,0.25]
  ylog=0
  zlog=0
  bottom_color=50
  save,zrange5,ylog,zlog,bottom_color,filename=output_Dir+title_char+'main_parameters.sav'
    
  
  ;cgdisplay
  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(3,5,left=0.01,right=0.72,xgap=0.02,ygap=0.02,low=0.01,high=0.95)

  factor_to_kev=1.0;1.0e6/(1000.0*11600)

  bar_title1='Density (cm!u-3!n!x)'
  bar_title2='Temperature (keV)'
  bar_title3='Pressure (nPa)'
  bar_title4='Velocity_x(km/s)'
  bar_title5='H!dX!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
  bar_title6='K!dX!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
  bar_title7='Times'
  
  zrange1=[0.05,0.5];N
  zrange2=[0.15,6.0];T
  zrange3=[0.01,0.2];P
  zrange4=[-50,50];V
  ;zrange5=[-0.0,0.4];H
  zrange6=[-0.001,0.001];K
  zrange7=[0.1,4000]  ;number
 
  bar_title=[bar_title5,bar_title5,bar_title5]
  zrange=[[zrange5],[zrange5],[zrange5]]

  for i=0,14 do begin
    eventimes[i]=reform(eventimes[i+bbindex],10*30*reverse_gap^2)
    event_n[i]=reform(event_n[i+bbindex],10*30*reverse_gap^2)
    event_t[i]=reform(event_t[i+bbindex],10*30*reverse_gap^2*factor_to_kev)
    event_p[i]=reform(event_p[i+bbindex],10*30*reverse_gap^2)
    event_vx[i]=reform(event_vx[i+bbindex],10*30*reverse_gap^2)
    event_hx[i]=reform(event_hx[i+bbindex],10*30*reverse_gap^2)
    event_kx[i]=reform(event_kx[i+bbindex],10*30*reverse_gap^2)
    event_h_k_x[i]=reform(event_h_k_x[i+bbindex],10*30*reverse_gap^2)
  endfor

  data=[[[event_hx[0]],[event_hx[1]],[event_hx[2]],[event_hx[3]],[event_hx[4]]],$
        [[event_hx[5]],[event_hx[6]],[event_hx[7]],[event_hx[8]],[event_hx[9]]],$
        [[event_hx[10]],[event_hx[11]],[event_hx[12]],[event_hx[13]],[event_hx[14]]]]
           
  x=linspace(-20,-10,10*reverse_gap+1)
  v=linspace(-15,15,30*reverse_gap+1)  ; connect to the return_vari function. follow the same start point
  xrange=[-10,-20]
  yrange=[15,-15]

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

  ;  ;v      change : title,not change; image, change
  ;yrange change : title, change  ;  image, change
  idx=where(data eq 0)
  data[idx]=!values.f_nan
  ;cgloadct,38;,/reverse
  ;cgloadct,72,/reverse
  ;  restore,'E:\OneDrive\IDLworks\Other\blue_white_red_256.ctl'
  ;  tvlct,r,g,b


  ;str_element,extra,'title','test',/add
  str_element,opt_plot,'charsize',0.6,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'xticks',2,/add
  str_element,opt_plot,'xrange',xrange,/add
  str_element,opt_plot,'yrange',yrange,/add
    
  ;str_element,opt_bar,'position',[],/add
  str_element,opt_bar,'no_color_scale',0,/add
  str_element,opt_bar,'charsize',0.6,/add
  str_element,opt_bar,'title',bar_title,/add
  str_element,opt_bar,'ylog',ylog,/add


  
  restore,'E:\OneDrive\IDLworks\Work\Other\blue_white_red_256.ctl'

  tvlct,r,g,b
 ; cgloadct,39
 ; cgloadct,39,clip=[20, 253]
  
  for i=0,2 do begin
    
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

      if i ne 2 then begin
        str_element,opt_plot,'xtickformat','(a1)',/add
        str_element,opt_plot,'xtitle',/delete
      endif else begin
        str_element,opt_plot,'xtickformat',/delete
        str_element,opt_plot,'xtitle','X(Re)',/add
      endelse

      if j eq 4 then str_element,opt_bar,'no_color_scale',0,/add else str_element,opt_bar,'no_color_scale',1,/add
      str_element,opt_bar,'position',[pos[i,j,2]+0.02,pos[i,j,1],pos[i,j,2]+0.05,pos[i,j,3]],/add
      d={x:x,y:reform(data[*,j,i],10*reverse_gap,30*reverse_gap),v:v}
      color_fill,pos[i,j,*],d,xrange=xrange,yrange=yrange,zrange=zrange[*,i],zlog=zlog,top=254,bottom=bottom_color,backcolor='grey',opt_plot=opt_plot,opt_bar=opt_bar
      labels_stamp,pos[i,j,*],ptitle[i,j],charsize=0.6,/left_right_center,/up_out
    endfor                                                      ;[-0.3,0.3] thermal EFD range
  endfor

  ;labels_stamp,pos[*,*,*],'  '+['(a)','(e)','(b)','(f)','(c)','(g)','(d)','(h)'],charsize=1.5,/left_in,/up_in
  ;labels_stamp,pos[1,*,*],'  '+['(e)','(f)','(g)','(h)'],charsize=1.5,/left_in,/up_in

  cgps_close




end