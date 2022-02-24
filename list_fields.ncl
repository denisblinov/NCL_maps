;------------------------------------------------------------------
; Library of input files/fields for reading model data.
; It is analogue of ctl-file from GrADS.
; Authors: Denis Blinov, denisblinov@ya.ru. 2017 - ...
; This list need for preparing list of fields from certain files.
;------------------------------------------------------------------

undef("get_grib_metadata")
function get_grib_metadata( loadfile )
begin;;

    ; print(loadfile)
    ; print(getfilepath(loadfile))
    ftype = "grib1"
    if( str_get_cols(getfilepath (loadfile),-3,-1) .eq. ".nc" )then ; netcdf
        ftype = "netcdf"
    end if
    print(str_join(getfilevarnames(loadfile),", "))
    if(  isStrSubset(str_join(getfilevarnames(loadfile),", "), "g10_lon" ) )then;;
        print( "cosmo grid, grib1" )
        ftype@numberGrid = "GDS10"

    else if(  isStrSubset(str_join(getfilevarnames(loadfile),", "), "g0_lon" ))then;;
        print( "geografical grid" )
        ftype@numberGrid = "GDS0"

    else if(isStrSubset(str_join(getfilevarnames(loadfile),", "), "gridlon_0") )then;; ;.and. gridrot_0
        print( "grib2" )
        ftype = "grib2"
        ftype@numberGrid = "GRLL0"
        ; numberGrid = "GRLL1" ; for U-staggered
        ; numberGrid = "GRLL2" ; for V-staggered
        
    else if(isStrSubset(str_join(getfilevarnames(loadfile),", "), "lon_0") )then;;
        ftype = "grib2"
        ftype@numberGrid = "GLL0"
        ; numberGrid = "GLL1" ; for U and V in belarus WRF data


    else if(isStrSubset(str_join(getfilevarnames(loadfile),", "), "clon") )then;;
        ftype@numberGrid = "original_triang"

    else
        print( "geographical grid" )
        ftype@numberGrid = "GRD"

    end if;;
    end if;;
    end if;;
    end if;;
    end if;;

    return (ftype)

end;;

undef("fields_cm_dbz")
function fields_cm_dbz( files_dbz, fieldname, sufTime )
local loadfile
begin;;

    print( files_dbz )
    print( "fieldname: " + fieldname )
    if ( strlen(sufTime) .lt. 1 .or. sufTime .eq. False )then
        setfileoption ("grb", "TimePeriodSuffix",False)
        sufTime = ""
    end if
    loadfiles = addfiles(files_dbz,"r")
    ; setfileoption (loadfiles, "TimePeriodSuffix",False)
    ListSetType (loadfiles, "join")
    ; print (loadfiles)
    ; printVarSummary (loadfiles)
    ; print (loadfiles(0))

    f1 = addfile(files_dbz(0),"r")
    ftype = get_grib_metadata( f1 )
    ; ftype = get_grib_metadata( loadfiles(0) )
    numberGrid = ftype@numberGrid

    if( str_get_cols(str_sub_str(fieldname,"_",""),0,5) .eq. "LPIMAX" )then

        ; field0min  = loadfiles->LTNG_P8_L1_GRLL0
        ; name = "LTNG_P8_L1_GRLL0_max10min"
        name = "LTNG_P8_L1_" + numberGrid + "_max"
        field  = loadfiles[:]->$name$
        ; field  = dim_max_n(fields,0)
        field@name = "LPI_MAX"
        field@long_name = "Maximum of Ligtning Potential Index for " \
                          + str_get_cols(str_sub_str(fieldname,"_",""),6,-1)
        field@units = "J/m^2"

    else if( str_get_cols(str_sub_str(fieldname,"_",""),0,7)  .eq. "DBZCMAX"  )then
        name = "BREF_P0_2L1_8_" + numberGrid
        field  = loadfiles[:]->$name$
        field@name = "Zmax"
        field@long_name = "maximum of radar reflectivity in column "
        field@units = "dbz"

    else if( str_get_cols(str_sub_str(fieldname,"_",""),0,7)  .eq. "DBZCTMAX"  )then
        name = "BREF_P8_2L1_8_" + numberGrid+"_max"
        field  = loadfiles[:]->$name$
        field@name = "ZTmax"
        field@long_name = "maximum of radar reflectivity in column for " \
                          + str_get_cols(str_sub_str(fieldname,"_",""),8,-1)
        field@units = "dbz"

    else if( fieldname .eq. "DBZ"  )then
        name   = "BREF_P0_2L150_" + numberGrid
        field  = loadfiles[:]->$name$
        field@name = "Z"
        field@long_name = "radar reflectivity"
        field@units = "dbz"

    end if
    end if
    end if
    end if

    if( str_get_cols(str_sub_str(fieldname,"_",""),0,7) .eq. "DHAILAVE" )then;;
        name   = "VAR_0_1_238_P8_L1_" + numberGrid + "_avg" + sufTime
        field  = loadfiles[:]->$name$
        ; field@name = "DHAILAVE"
        field@long_name = "average hail diameter"
        field@units = "mm"

    else if( str_get_cols(str_sub_str(fieldname,"_",""),0,7) .eq. "DHAILMAX" )then
        name   = "VAR_0_1_238_P8_L1_" + numberGrid + "_max" + sufTime
        field  = loadfiles[:]->$name$
        field@long_name = "maximum hail diameter"
        field@units = "mm"

    else if( str_get_cols(str_sub_str(fieldname,"_",""),0,7) .eq. "DHAILSTD" )then
        name  = "VAR_0_1_238_P8_L1_" + numberGrid + "_std" + sufTime
        field  = loadfiles[:]->$name$
        field@long_name = "standard deviation of hail diameter"
        field@units = "mm"

    end if
    end if
    end if;;

    ; field@forecast_time = LTNG_P8_L1_GRLL0_max10min
    ; field@forecast_time_units = loadfiles[-1]->LTNG_P8_L1_GRLL0_max10min
    ; filevarattdef( f1, "gw", field )

    if( numberGrid .eq. "GDS10" )then;;
        field@lon2d = loadfiles[0]->g10_lon_1(:,:)
        field@lat2d = loadfiles[0]->g10_lat_0(:,:)

    else if( numberGrid .eq. "GRLL0" )then;;
        field@lon2d = loadfiles[0]->gridlon_0(:,:)
        field@lat2d = loadfiles[0]->gridlat_0(:,:)

    end if;;
    end if;;

    ; printVarSummary (field)

    return field

end;;

undef("coordinate2d")
function coordinate2d( field, lat2d, lon2d )
begin;;
    ; geo-reference data
    field@lat2d = lat2d
    field@lon2d = lon2d

    return field
end;;

undef("radar_field")
function radar_field( file_radar, name )
local loadfile
begin;;
    if( str_get_cols(file_radar,-3,-1) .eq. ".h5" )then
        ; print( file_radar )
        loadfile = addfile(file_radar,"r")
        ; prefix = "om_" ; Observation map
        ; print( loadfile )

        if( str_get_cols(file_radar,-20,-17) .eq. "ZMAX" )then
            ; print( "ZMAX" )
            ; field = loadfile->ZMAX(nlat-1:0,:)
            ; field = loadfile->ZMAX(:,419:0)
            ; field = loadfile->ZMAX(470-1:0,0:419)
            field = loadfile->ZMAX(450-1:0,0:469)
            field@name = "Zmax"
            field@long_name = "maximum of radar reflectivity in columns"
            field@units = "dbz"
        end if
        if( str_get_cols(file_radar,-17,-17) .eq. "R" )then
            ; field = loadfile->R(nlat-1:0,:)
            field = loadfile->R(470-1:0,0:419)
            field@name = "R"
            field@long_name = "Precipitation rate for 10 minutes"
            field@units = "mm/h"

        end if
        field@_FillValue = -2000000
        ; prec = where(prec .eq. -1000000, 0, prec)
        ; prec = where(prec .lt. 0, 0, prec)

        ; geo-reference data ; need adaptate
        ; field@lat2d = lat2d
        ; field@lon2d = lon2d

        field@incr_time = 10
        field@incr_time_unit = "minute"
        field@typeData = "Observation"

        ; get attributes (for correct plot title)
        ; field = field_attributes( "ZMAX", field )

        ; printVarSummary( field )
        printMinMax( field,0 )
        ; print (dimsizes(field(:,0)))
        ; print (dimsizes(field(0,:)))
        ; print (dimsizes(field(:,:)))

        ; close file
        delete(loadfile)

    else if( str_get_cols(file_radar,-6,-1) .eq. ".grib1" )then
        if( name .eq. "RR" )then
            loadfile = addfile(file_radar,"r")
            fname = "A_PCP_GDS10_SFC"
            field = loadfile->$fname$
            field@name = "RR"
            field@long_name = "Precipitation rate for 10 minutes"
            field@units = "mm/h"

        end if
    end if
    end if

    return field

end;;

undef("radar_fields")
function radar_fields( files_radar, name )
local loadfile
begin;;
    print( files_radar )
    loadfile = addfiles(files_radar,"r")
    ListSetType (loadfile, "join")
    ; print( loadfile )

  if( str_get_cols(files_radar(0),-3,-1) .eq. ".h5" )then;;
    
    if( str_get_cols(files_radar(0),-20,-17) .eq. "ZMAX" )then
        ; print( "ZMAX" )
        field = loadfile[:]->ZMAX
        field@name = "Zmax"
        field@long_name = "maximum of radar reflectivity in columns"
        field@units = "dbz"
    end if
    if( str_get_cols(files_radar(0),-17,-17) .eq. "R" )then
        field = loadfile[:]->R
        print( dimsizes(field) )
        field@name = "R"
        field@long_name = "Precipitation rate for 10 minutes"
        field@units = "mm/h"

    end if
    field@_FillValue = -2000000
    ; prec = where(prec .eq. -1000000, 0, prec)
    ; prec = where(prec .lt. 0, 0, prec)

    nlat = dimsizes(field(0,:,0))
    nlon = dimsizes(field(0,0,:))

    field = field(:,nlat-1:0,0:nlon-1) ; to shift radar data from North to South

    field@incr_time = 10
    field@incr_time_unit = "minute"
    field@typeData = "Observation"

    ; get attributes (for correct plot title)
    ; field = field_attributes( "ZMAX", field )
    
  else if( str_get_cols(files_radar(0),-6,-1) .eq. ".grib1" )then
      if( name .eq. "RR" )then
          ; loadfile = addfiles(files_radar,"r")
          fname = "A_PCP_GDS10_SFC"
          field = loadfile[:]->$fname$
          field@name = "RR"
          field@long_name = "Precipitation rate for 10 minutes"
          field@units = "mm/h"
      end if
  end if
  end if;;
  
    printVarSummary( field )
    printMinMax( field,0 )
    ; print (dimsizes(field(:,0)))
    ; print (dimsizes(field(0,:)))
    ; print (dimsizes(field(:,:)))
  
  return field

end;;


undef("field_rgd_s")
function field_rgd_s( loadfile, fieldname, ftime )
begin;;

    ; print (loadfile)
    ; print ("data for field_rgd_s")
    print (fieldname + " " + ftime)
    ; print (getfilevarnames(loadfile))
    ; qq = getfilevarnames(loadfile)
    ; print (qq[:-1] )
    
    ; if( isvar("file_cm_sfield") )then
    ; loadfile = addfile(file_cm_sfield+ftype,"r")
    
    print( "NCL_GRIB_PTABLE_PATH: " + getenv("NCL_GRIB_PTABLE_PATH") )

    ftype = get_grib_metadata( loadfile )
    numberGrid = ftype@numberGrid

    fieldname_lc = str_lower(fieldname)
    
    if(str_get_cols(fieldname,-2,-1) .eq. "1h" .or. \
       str_get_cols(fieldname,-2,-1) .eq. "3h" .or. \
       str_get_cols(fieldname,-2,-1) .eq. "6h"  )then
        ; print(str_get_cols(fieldname,-2,-2))
        accTimeHour = stringtointeger( str_get_cols(fieldname,-2,-2) )
        ; print(accTimeHour)
    else if ( str_get_cols(fieldname,-3,-1) .eq. "12h" .or. \
              str_get_cols(fieldname,-3,-1) .eq. "24h" ) then

        accTimeHour = stringtointeger( str_get_cols(fieldname,-3,-2) )
        ; print(accTimeHour)
    end if
    end if
    ; print(accTimeHour)


    ga = 9.80665   ; gravity acceleration

    ;-------------------- surface fields ---------------------
    if(      fieldname .eq. "PMSL" .or. fieldname .eq. "QNH" )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "PRMSL_" + numberGrid + "_MSL"
            else
                fname = "PMSL_" + numberGrid + "_MSL"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "PRMSL_P0_L101_" + numberGrid
        else if( ftype .eq. "netcdf"  )then
            fname  = "pres_msl"
        end if
        end if
        end if
        field = loadfile->$fname$
        ; printVarSummary(field)

    else if( fieldname .eq. "PS" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "PRES_" + numberGrid + "_SFC"
            else
                fname = "P_" + numberGrid + "_SFC"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "PRES_P0_L1_" + numberGrid
        end if
        end if
        field = loadfile->$fname$
        field = field * 0.01
        field@units = "gPa"

    else if( fieldname .eq. "QNH" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "P_" + numberGrid + "_SFC"
            else
                fname = "PS_" + numberGrid + "_SFC"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "PRES_P0_L1_" + numberGrid
        else if( ftype .eq. "netcdf"  )then
            fname  = "ps"
        end if
        end if
        end if

        field = loadfile->$fname$
        field = field * 0.01
        field@units = "gPa"
        ; printVarSummary(field)

    else if( fieldname .eq. "T_2M" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            ; print(getenv("NCL_GRIB_PTABLE_PATH"))
            ; print(ismissing(getenv("NCL_GRIB_PTABLE_PATH")))
            if ( .not. ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "T_" + numberGrid + "_HTGL"
            else
                fname = "TMP_" + numberGrid + "_HTGL"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "TMP_P0_L103_" + numberGrid
        else if( ftype .eq. "netcdf"  )then
            fname  = "t_2m"
        end if
        end if
        end if
        field = loadfile->$fname$
        field = field - 273.15
        field@long_name = "temperature at 2m"
        field@units = "C"

    else if( fieldname .eq. "TD_2M" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            ; fname = "DPT_" + numberGrid + "_HTGL"
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "DPT_"  + numberGrid + "_HTGL"
            else
                fname = "TD_"  + numberGrid + "_HTGL"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "DPT_P0_L103_" + numberGrid
        end if
        end if
        field = loadfile->$fname$
        field = field - 273.15
        field@long_name = "Dew Point at 2m"
        field@units = "C"

    else if( fieldname .eq. "RELHUM2M" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "R_H_"+ numberGrid +"_HTGL"
            else
                fname = "RELHUM_"+ numberGrid +"_HTGL"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "RH_P0_L103_"+ numberGrid
        end if
        end if
        field = loadfile->$fname$

    else if( fieldname .eq. "QV_S" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname = "QVS_"+ numberGrid +"_SFC"
        else
            fname = "SPFH_P0_L1_"+ numberGrid
        end if
        field = loadfile->$fname$

    else if( fieldname .eq. "VMAX10M" .or. str_get_cols(fieldname_lc,0,6) .eq. "vmax10m" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname = "GUST_" + numberGrid + "_SFC" 
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "LTNG_" + numberGrid + "_HTGL"
            else
                fname = "VMAX_" + numberGrid + "_HTGL"
            end if
        else if( ftype .eq. "grib2" )then
            ; setfileoption ("grb", "TimePeriodSuffix",False)
            ; setfileoption (loadfile, "TimePeriodSuffix",False)
            print("str_get_cols(fieldname,7,7): " + str_get_cols(fieldname,7,7) + " " + strlen(str_get_cols(fieldname,7,7)))
            print(get_grib_metadata( loadfile ))
            ; if( ismissing(str_get_cols(fieldname,7,7)) )then
            if( strlen(str_get_cols(fieldname,7,7)) .eq. 0 )then
                print("case with no period for gust")
                setfileoption (loadfile, "TimePeriodSuffix", False) ; not work
                fname = "GUST_P8_L103_" + numberGrid + "_max"
            else if( ftime .le. stringtointeger(str_get_cols(fieldname,7,7)) )then ; 3 for 6km and 1 for 2.2km ; ftime .le. 1  .or. 
                fname = "GUST_P8_L103_" + numberGrid + "_max"
            else
                ; fname = "GUST_P8_L103_" + numberGrid + "_max1h"
                fname = "GUST_P8_L103_" + numberGrid + "_max" + str_get_cols(fieldname_lc,7,8)
            end if
            end if
        else if( ftype .eq. "netcdf"  )then
            fname  = "gust10"
        end if
        end if
        end if
        field = loadfile->$fname$
        ; field@units = "m/s"
        ; if( fieldname_lc .eq. "vmax10m1h" )then
            ; field@at = 1
        ; else if( fieldname_lc .eq. "vmax10m3h" )then
            ; field@at = 3
        ; end if
        ; end if
        field@long_name = "maximum 10m wind gust"

    else if( fieldname .eq. "VABSMX10M" .or. str_get_cols(fieldname_lc,0,8) .eq. "vabsmx10m" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname = "_" + numberGrid + "_SFC" 
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "TTRAD_" + numberGrid + "_HTGL"
            else
                fname = "VABSMX_10M_" + numberGrid + "_HTGL"
            end if
        else if(  ftype .eq. "grib2" )then
            if( ftime .le. 1 )then
                fname = "WIND_P8_L103_" + numberGrid + "_max"
            else
                fname = "WIND_P8_L103_" + numberGrid + "_max1h"
            end if
        else if( ftype .eq. "netcdf"  )then
            fname  = "wind10"
        end if
        end if
        end if
        field = loadfile->$fname$
        ; field@units = "m/s"

        field@long_name = "maximum of wind at 10m"

    else if( fieldname .eq. "CLCT" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( .not. ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname =  "CLCT_" + numberGrid + "_SFC"
            else
                fname =  "T_CDC_" + numberGrid + "_SFC" ;"_EATM"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "TCDC_P0_L1_" + numberGrid
        end if
        end if
        field = loadfile->$fname$

    else if( fieldname .eq. "CLCH" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( .not. ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname =  "CLCH_" + numberGrid + "_SFC"
            else
                fname =  "H_CDC_" + numberGrid + "_SFC" ;"_HCY"
            end if
            field = loadfile->$fname$(:,:)
        else if(  ftype .eq. "grib2" )then
            fname = "CDCC_P0_2L100_" + numberGrid
            field = loadfile->$fname$(0,:,:)
        else if( ftype .eq. "netcdf"  )then
            fname  = "clch"
            field = loadfile->$fname$
        end if
        end if
        end if
        ; field = loadfile->$fname$(0,:,:)
        field@long_name = "high cloud cover"

    else if( fieldname .eq. "CLCM" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( .not. ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname =  "CLCM_" + numberGrid + "_SFC"
            else
                fname =  "M_CDC_" + numberGrid + "_SFC" ;"_MCY"
            end if
            field = loadfile->$fname$(:,:)
        else if(  ftype .eq. "grib2" )then
            fname = "CDCC_P0_2L100_" + numberGrid
            field = loadfile->$fname$(1,:,:)
        else if( ftype .eq. "netcdf"  )then
            fname  = "clcm"
            field = loadfile->$fname$
        end if
        end if
        end if
        field@long_name = "medium cloud cover"

    else if( fieldname .eq. "CLCL" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            ; if ( getenv("NCL_GRIB_PTABLE_PATH") .ne. "missing" )then
            if ( .not. ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname =  "CLCL_" + numberGrid + "_SFC"
            else
                fname =  "L_CDC_" + numberGrid + "_SFC" ;"_LCY"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "CDCC_P0_2L100_1_" + numberGrid
        else if( ftype .eq. "netcdf"  )then
            fname  = "clcl"
        end if
        end if
        end if
        field = loadfile->$fname$
        field@long_name = "low cloud cover"

    else if( str_lower(fieldname) .eq. "u_10m" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "U_GRD_" + numberGrid + "_HTGL"
            else
                fname = "U_" + numberGrid + "_HTGL"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "UGRD_P0_L103_" + numberGrid
        else if( ftype .eq. "netcdf"  )then
            fname  = "u_10m"
        end if
        end if
        end if
        field = loadfile->$fname$

    else if( str_lower(fieldname) .eq. "v_10m" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "V_GRD_" + numberGrid + "_HTGL"
            else
                fname = "V_" + numberGrid + "_HTGL"
            end if
            ; fname = "V_" + numberGrid + "_HTGL"
        else if(  ftype .eq. "grib2" )then
            fname = "VGRD_P0_L103_" + numberGrid
        else if( ftype .eq. "netcdf"  )then
            fname  = "v_10m"
        end if
        end if
        end if
        field = loadfile->$fname$

    else if( (str_get_cols(fieldname,0,3) .eq. "Prec" .and. \
             (str_get_cols(fieldname,6,6) .eq. "h" ) .or. (str_get_cols(fieldname,6,6) .eq. "m" ) ) \
             .or. fieldname .eq. "TOT_PREC" \
             .or. fieldname .eq. "accumPrecip" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            ; if ( getenv("NCL_GRIB_PTABLE_PATH") .ne. "missing" )then
            if ( .not. ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname1 = "TOT_PREC_"
                suf1  = ""
            else
                fname1 = "A_PCP_"
                suf1  = ""
                ; suf1  = "_1" ; for tot_snow
            end if
            if( str_get_cols(fieldname,6,6) .eq. "m" )then
                tunit = "m"
            else 
                tunit = "h"
            end if
            if( ftime .eq. 0 )then
                fname = fname1 + numberGrid +"_SFC" + suf1
            else
                fname = fname1 + numberGrid +"_SFC_acc" + ftime + tunit + suf1
            end if
        else if( ftype .eq. "grib2" )then
            if( ftime .eq. 0 )then
                fname = "TPRATE_P8_L1_"+ numberGrid +"_acc"
            else
                fname = "TPRATE_P8_L1_"+ numberGrid +"_acc"
            end if
        else if( ftype .eq. "netcdf"  )then
            fname  = "tot_prec"
        end if
        end if
        end if
        field = loadfile->$fname$
        field@long_name = "total precipitation amount"
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            field@type_of_statistical_processing = "Accumulation"
        end if
        ; field@units = "kg/m2"

   else if( str_get_cols(fieldname,0,6) .eq. "GRAUPEL" .and. str_get_cols(fieldname,9,9) .eq. "h" )then
        if( ftime .eq. 0 )then
            fname = "GRAU_GSP_GDS10_SFC"
        else
            fname = "GRAU_GSP_GDS10_SFC_acc" + ftime + "h"
        ; else if( ftype .eq. "grib2" )then
            ; GPRATE_P8_L1_GRLL0_acc
            
        end if
        field = loadfile->$fname$(:,:)

    ; else if( fieldname .eq. "fSnow6h" )then
        ; field = loadfile->SNO_D_GDS10_SFC_ave6h(:,:,:)

    ; else
        ; varname = fieldname + "_GDS0_SFC"
        ; field = loadfile->$varname$

    else if( fieldname .eq. "RAIN_GSP" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( .not. ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname1 = "RAIN_GSP_"
                suf1  = ""
            else
                fname1 = "WVHGT_"
                suf1  = ""
            end if
            tunit = "h"
            if( ftime .eq. 0 )then
                fname = fname1 + numberGrid +"_SFC" + suf1
            else
                fname = fname1 + numberGrid +"_SFC_acc" + ftime + tunit + suf1
            end if
        else if( ftype .eq. "grib2" )then
            fname = "LSRATE_P8_L1_" + numberGrid + "_acc"
        else if( ftype .eq. "netcdf"  )then
            fname  = "rain_gsp"
        end if
        end if
        end if
        field = loadfile->$fname$
        field@long_name = "large scale rain"
        field@units = "kg/m2"
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            field@type_of_statistical_processing = "Accumulation"
        end if

    else if( fieldname .eq. "RAIN_CON" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( .not. ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname1 = "RAIN_CON_"
                suf1  = ""
            else
                fname1 = "NSWRT_"
                suf1  = ""
            end if
            tunit = "h"
            if( ftime .eq. 0 )then
                fname = fname1 + numberGrid +"_SFC" + suf1
            else
                fname = fname1 + numberGrid +"_SFC_acc" + ftime + tunit + suf1
            end if
        else if( ftype .eq. "grib2" )then
            fname = "CRRATE_P8_L1_" + numberGrid + "_acc"
        else if( ftype .eq. "netcdf"  )then
            fname  = "rain_con"
        end if
        end if
        end if
        field = loadfile->$fname$
        field@long_name = "convective rain"
        field@units = "kg/m2"
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            field@type_of_statistical_processing = "Accumulation"
        end if

    else if( fieldname .eq. "HSnow" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname =  "SNO_D_" + numberGrid + "_SFC"
            else
                fname =  "H_SNOW_" + numberGrid + "_SFC"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "SNOD_P0_L1_" + numberGrid
        end if
        end if
        field = loadfile->$fname$
        field = field*100
        field@units = "cm"

    else if( fieldname .eq. "WSnowE" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname =  "WEASD_" + numberGrid + "_SFC"
            else
                fname =  "W_SNOW_" + numberGrid + "_SFC"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "SDWE_P0_L1_" + numberGrid
        end if
        end if
        field = loadfile->$fname$
        ; field = field*1000
        ; field@units = "mm"


    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if;;


    if( fieldname .eq. "TOT_RAIN" )then;;

        rain_gsp = field_rgd_s( loadfile, "RAIN_GSP", ftime )
        rain_con = field_rgd_s( loadfile, "RAIN_CON", ftime )
        field = rain_gsp + rain_con
        copy_VarMeta( rain_gsp, field )
        field@long_name = "total rain"

    else if( str_get_cols(fieldname,0,3) .eq. "Rain" .and.  \
             ((str_get_cols(fieldname,-1,-1) .eq. "h" ) .or. \
             (str_get_cols(fieldname,-1,-1) .eq. "m" ) )  )then

        rain_gsp = field_rgd_s( loadfile, "RAIN_GSP", ftime )
        rain_con = field_rgd_s( loadfile, "RAIN_CON", ftime )
        field = rain_gsp + rain_con
        copy_VarMeta( rain_gsp, field )
        field@long_name = "total rain"

    end if
    end if;;

    if( fieldname .eq. "TOT_SNOW" )then;;

        tot_precip = field_rgd_s( loadfile, "TOT_PREC", ftime )
        field = tot_precip - field_rgd_s( loadfile, "TOT_RAIN", ftime )
        copy_VarMeta( tot_precip, field )
        field@long_name = "total snowfall"

    end if;;

    ; if( (str_get_cols(fieldname,0,7) .eq. "rainfall" .and.  \
             ; (str_get_cols(fieldname,-1,-1) .eq. "h" ) .or. \
             ; (str_get_cols(fieldname,-1,-1) .eq. "m" ) )  )then

        ; if( str_get_cols(fieldname,-1,-1) .eq. "m" )then
            ; tunit = "m"
        ; else 
            ; tunit = "h"
        ; end if                                                               

        ; field = field_rgd_s( loadfile, "TOT_RAIN", ftime ) - \
                ; field_rgd_s( loadfile, "TOT_RAIN", ftime - accTimeHour )


    ; end if

    if( fieldname .eq. "HSURF" )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            ; if( isdefined(getenv("NCL_GRIB_PTABLE_PATH")) )then
            if ( getenv("NCL_GRIB_PTABLE_PATH") .ne. "missing" ) then
                print("user(cosmo) list variable")
                ; field   = loadfile->HH_GDS10_SFC 
                ; field   = loadfile->HGT_GDS0_SFC
                fname = "HH_" + numberGrid + "_SFC"
                ; hhl    = loadfile->HH_GDS10_HYBL
            else
                print("default list variable")
                ; field   = loadfile->DIST_GDS10_SFC
                fname = "HGT_" + numberGrid + "_SFC"
            end if
       else if( ftype .eq. "grib2" )then
            fname =  "GP_P0_L1_" + numberGrid
       end if
       end if
       field   = loadfile->$fname$

    else if( fieldname .eq. "FIS" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname = "FI_" + numberGrid + "_SFC"
        else if( ftype .eq. "grib2" )then
            fname =  "GP_P0_L1_" + numberGrid
        end if
        end if

        field   = loadfile->$fname$
        field = field / ga
        field@long_name = "Height of surface"
        field@units = "m"

    else if( fieldname .eq. "FRLAND" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            ; if( isdefined(getenv("NCL_GRIB_PTABLE_PATH")) )then
            if ( getenv("NCL_GRIB_PTABLE_PATH") .ne. "missing" ) then
                print("user(cosmo) list variable")
                fname = "FR_LAND_" + numberGrid + "_SFC"
            else
                print("default list variable")
                ; field = loadfile->LAND_GDS0_SFC
                fname = "LAND_" + numberGrid + "_SFC"
            end if
       else if( ftype .eq. "grib2" )then
            fname =  "LAND_P0_L1_" + numberGrid
       end if
       end if
       field   = loadfile->$fname$

    end if
    end if
    end if;;

    ; field@coordinates = "g0_lat_0 g0_lon_1"
    ; print( field&g0_lat_0@units )
    ; print( field&g0_lat_0(::-1) )
    ; field&g0_lat_0 = field&g0_lat_0(::-1)  ; need for bugfix in Belarus grib dataset
    ; printMinMax( field,0 )
    ; printVarSummary(field)

    if( fieldname .eq. "ZMAX" .or. fieldname .eq. "DBZ_CMAX" .or. str_get_cols(str_sub_str(fieldname,"_",""),0,7)  .eq. "DBZCMAX"  )then;;
        ; Z    = loadfile->DBZ_CMAX
        ; if( str_get_cols(loadfile,-3,-1) .eq. ".nc" )then ; netcdf
        if( False )then ; netcdf
            field  = loadfile->DBZ_CMAX(0,:,:)
        else ; grib
            field  = loadfile->BREF_P0_2L1_8_GRLL0
            ; name = "BREF_P0_2L1_8_"+numberGrid
            ; field  = loadfile->BREF_P0_L1_GRLL0 ; DBZ_850. It was bug to 01.07.2019
            if( isdefined(getenv("NCL_GRIB_PTABLE_PATH")) )then
                print("user(cosmo) list variable")
            end if
        end if
        field@name = "Zmax"
        field@long_name = "maximum of radar reflectivity in column"
        field@units = "dbz"

    else if( fieldname .eq. "DBZ_CTMAX" .or. fieldname .eq. "DBZCTMAX"  )then
        if( ftime .le. 10 )then
            fname = "BREF_P8_2L1_8_"+ numberGrid+"_max"
        else
            fname = "BREF_P8_2L1_8_"+ numberGrid+"_max10min"
        end if
        field  = loadfile->$fname$
        field@name = "ZTmax"
        field@long_name = "maximum of radar reflectivity in column for 10 minutes"
        field@units = "dbz"

    else if( fieldname .eq. "DBZ"  )then
        field  = loadfile->BREF_P0_2L150_GRLL0
        field@name = "Z"
        field@long_name = "radar reflectivity"
        field@units = "dbz"

    else if( fieldname .eq. "LPI_MAX"  )then
        ; field  = loadfile->VAR_0_17_1_P8_L1_GRLL0_max ; for 0 and 1 step
        ; field  = loadfile->VAR_0_17_1_P8_L1_GRLL0_max10min
        ; field  = loadfile->LTNG_P8_L1_GRLL0_max ; - for 0 and 10 mins
        ; field  = loadfile->VAR_196_GDS10_SFC ;; grib1
        field  = loadfile->LTNG_P8_L1_GRLL0_max10min
        field@name = "LPI_MAX"
        field@long_name = "Maximum of Ligtning Potential Index at 10 minutes"
        field@units = "J/m^2"

    else if( fieldname .eq. "LPI"  )then
        field  = loadfile->VAR_0_17_1_P0_L1_GRLL0
        field@name = "LPI"
        field@long_name = "radar reflectivity"
        field@units = "J/m^2"

    ; else if( name .eq. "R" )then
        ; if( str_get_cols(file_cm_radarfield,-3,-1) .eq. ".nc" )then ; netcdf
            ; field  = loadfile->TOT_PREC(0,:,:)
        ; field = where(field .lt. 0.00001, -2000000, field)
        ; field = where(field .eq. 0.0,     -2000000, field)
        ; else ; grib
            ; field  = loadfile->TPRATE_P8_L1_GRLL0_acc(:,:)   ; grib2
        ; end if
        ; field@name = "Total precipitation"
        ; field@long_name = "Total precipitation"

    end if
    end if
    end if
    end if
    end if;;

    if( fieldname .eq. "TQV" )then;;
        field  = loadfile->TCIWV_P0_L1_GRLL0
        ; field@name = "TQV"
        ; field@long_name = ""
        ; field@units = ""
    else if( fieldname .eq. "TQC" )then
        field  = loadfile->TCOLW_P0_L1_GRLL0

    else if( fieldname .eq. "TQI" )then
        field  = loadfile->TCOLI_P0_L1_GRLL0

    else if( fieldname .eq. "TWATER" )then
        field  = loadfile->TCOLWA_P0_L1_GRLL0

    end if
    end if
    end if
    end if;;

    if( fieldname .eq. "DHAILAVE" )then;;
        field  = loadfile->VAR_0_1_238_P8_L1_GRLL0_avg10min
        ; field@name = "DHAILAVE"
        field@long_name = "average hail diameter"
        field@units = "mm"

    else if( fieldname .eq. "DHAILMAX" )then
        field  = loadfile->VAR_0_1_238_P8_L1_GRLL0_max10min
        field@long_name = "maximum hail diameter"
        field@units = "mm"

    else if( fieldname .eq. "DHAILSTD" )then
        field  = loadfile->VAR_0_1_238_P8_L1_GRLL0_std10min
        field@long_name = "standard deviation of hail diameter"
        field@units = "mm"

    end if
    end if
    end if;;

    if( numberGrid .eq. "GDS10" )then;;
        field@lon2d = loadfile->g10_lon_1(:,:)
        field@lat2d = loadfile->g10_lat_0(:,:)

    else if( numberGrid .eq. "GRLL0" )then;;
        field@lon2d = loadfile->gridlon_0(:,:)
        field@lat2d = loadfile->gridlat_0(:,:)

    else if( numberGrid .eq. "original_triang" )then
        field@lon2d = loadfile->clon
        field@lat2d = loadfile->clat

    end if
    end if;;
    end if;;


    if( ftype .eq. "netcdf" )then
        ; print("dimsizes(dimsizes(field)): " + dimsizes(dimsizes(field)) +" " + dimsizes(field(:,0,0)))
        if( dimsizes(dimsizes(field)) .eq. 3 .and. dimsizes(field(:,0,0)) .eq. 1 )then
            ; field := loadfile->$fname$(0,:,:)
            field := field(0,:,:)
        else if( dimsizes(dimsizes(field)) .eq. 4 .and. dimsizes(field(:,0,0,0)) .eq. 1 \
                  .and. dimsizes(field(0,:,0,0)) .eq. 1 )then
            ; field := loadfile->$fname$(0,0,:,:)
            field := field(0,0,:,:)
        end if
        end if
        ; field&lon = loadfile->lon
        ; field&lat = loadfile->lat
        time = loadfile->time
        field@initial_time = time@units
        field@forecast_time = stringtoint(time)
        ; field@forecast_time_units = time@units
        ; printVarSummary(field)
    end if
    
    ; printVarSummary(field)
    return(field)

end;;



function field_nc_triang( loadfile, fieldname, ftime, typeGrid )
begin;;
    print("typeGrid: "+typeGrid)

    ftype = ".grb"
    if ( str_get_cols(getfilepath (loadfile),-3,-1) .eq. ".nc") then
        ftype = "netcdf"
    end if

    if( fieldname .eq. "FRLAND" )then;;
        print( " load frland " )
        ; print( loadfile )
        ; print( getfilepath (loadfile) )
        if ( getenv("NCL_GRIB_PTABLE_PATH") .ne. "missing" .and. ftype .eq. ".grb" ) then
            print("user(cosmo) list variable")
            field = loadfile->FR_LAND_GDS10_SFC
        else if (ftype .eq. ".grb" )
            print("default list variable")
            field = loadfile->LAND_GDS10_SFC
        else if (ftype .eq. "netcdf" )
            field = loadfile->FR_LAND
        end if
        end if
        end if

    else if( fieldname .eq. "HSURF" )then;;
        print( " load frland " )
        ; print( loadfile )
        ; print( getfilepath (loadfile) )
        if ( getenv("NCL_GRIB_PTABLE_PATH") .ne. "missing" .and. ftype .eq. ".grb" ) then
            print("user(cosmo) list variable")
            field = loadfile->HH_GDS10_SFC
        else if (ftype .eq. ".grb" )
            print("default list variable")
            field = loadfile->DIST_GDS10_SFC
        else if (ftype .eq. "netcdf" )
            field = loadfile->topography_c
        end if
        end if
        end if

    else if( fieldname .eq. "CLON" )then;;

        if ( .not. ismissing(getenv("NCL_GRIB_PTABLE_PATH")) .and. ftype .eq. ".grb" ) then
            print("user(cosmo) list variable")
            field = loadfile->CLON
        else if (ftype .eq. ".grb" )
            print("default list variable")
            field = loadfile->CLON
        else if (ftype .eq. "netcdf" )
            field = loadfile->clon
        end if
        end if
        end if

        field@units = "degrees"
        field = field * 180/ 3.1415

    else if( fieldname .eq. "CLAT" )then;;

        if ( .not. ismissing(getenv("NCL_GRIB_PTABLE_PATH")) .and. ftype .eq. ".grb" ) then
            print("user(cosmo) list variable")
            field = loadfile->CLAT
        else if (ftype .eq. ".grb" )
            print("default list variable")
            field = loadfile->CLAT
        else if (ftype .eq. "netcdf" )
            field = loadfile->clat
        end if
        end if
        end if

        field@units = "degrees"
        field = field * 180/ 3.1415

   else if( fieldname .eq. "clon_vertices" )then;;

        ; if ( getenv("NCL_GRIB_PTABLE_PATH") .ne. "missing" .and. ftype .eq. ".grb" ) then
        if ( .not. ismissing(getenv("NCL_GRIB_PTABLE_PATH")) .and. ftype .eq. ".grb" ) then
            print("user(cosmo) list variable")
            field = loadfile->clon_vertices
        else if (ftype .eq. ".grb" )
            print("default list variable")
            field = loadfile->clon_vertices
        else if ( ftype .eq. "netcdf" )
            field = loadfile->clon_vertices
        end if
        end if
        end if

        field@units = "degrees"
        field = field * 180/ 3.1415

        ; printVarSummary(clon_vertices)
        ; printMinMax(clon_vertices,0)
        ; printMinMax(clat_vertices,0)
        ; field@sfXCellBounds = clon_vertices ;* 180/ 3.1415
        ; field@sfYCellBounds = clat_vertices ;* 180/ 3.1415

   else if( fieldname .eq. "clat_vertices" )then;;

        if ( .not. ismissing(getenv("NCL_GRIB_PTABLE_PATH")) .ne. "missing" .and. ftype .eq. ".grb" ) then
            print("user(cosmo) list variable")
            field = loadfile->clat_vertices
        else if (ftype .eq. ".grb" )
            print("default list variable")
            field = loadfile->clat_vertices
        else if (ftype .eq. "netcdf" )
            field = loadfile->clat_vertices
        end if
        end if
        end if

        field@units = "degrees"
        field = field * 180/ 3.1415

    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;

    if( typeGrid .eq. "original_triang" )then
        field@sfXArray = loadfile->clon* 180/ 3.1415
        field@sfYArray = loadfile->clat* 180/ 3.1415
        ; field@lon2d = loadfile->clon* 180/ 3.1415
        ; field@lat2d = loadfile->clat* 180/ 3.1415
        
    else
        field@lon2d = loadfile->gridlon_0
        field@lat2d = loadfile->gridlat_0
    end if

    ; printVarSummary(field)

    return(field)

end;;

undef("field_cm_severeWeather")
function field_cm_severeWeather( loadfile, fieldname, ftime )
begin;;

    ; print (loadfile)
    ; print (fieldname)
    print( "NCL_GRIB_PTABLE_PATH: " + getenv("NCL_GRIB_PTABLE_PATH") )

    ftype = get_grib_metadata( loadfile )
    numberGrid = ftype@numberGrid

    fieldname_lc = str_lower(fieldname)
    FIELDNAME = str_sub_str(fieldname,"_","")

    if(      FIELDNAME .eq. "CAPECON" )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "LRGHR_" + numberGrid + "_SFC"
            else
                fname = "CAPE_CON_" + numberGrid + "_SFC"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "CAPE_P0_L1_" + numberGrid
        end if
        end if
        field = loadfile->$fname$(:,:)
        field@units = "J/kg"
        field@long_name = "convective CAPE"

    else if( fieldname .eq. "CAPE_MU" .or. fieldname .eq. "CAPEMU" )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "CSNOW_" + numberGrid + "_SFC"
            else
                fname = "CAPE_MU_" + numberGrid + "_SFC"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "CAPE_P0_L193_" + numberGrid
        end if
        end if
        field = loadfile->$fname$(:,:)
        field@units = "J/kg"
        field@long_name = "CAPE of most unstable parcel"

; definitions.edzw-2.12.5-2/grib2/tables/10/4.5.table:
;   192 - mixed layer related to atmosphere
;   193 - mostly unstable related to atmosphere
    else if( fieldname .eq. "CAPE_ML" .or. fieldname .eq. "CAPEML" )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "PEVPR_" + numberGrid + "_SFC"
            else
                fname = "CAPE_ML_" + numberGrid + "_SFC"
            end if
        else if( ftype .eq. "grib2" )then
            fname = "CAPE_P0_L192_" + numberGrid
        end if
        end if
        field = loadfile->$fname$(:,:)
        field@units = "J/kg"
        field@long_name = "CAPE of mean surface layer parcel"
        
    else if( str_sub_str(fieldname,"_","") .eq. "CAPEBS"  )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "CSNOW_" + numberGrid + "_SFC_1"
            else
                fname = "CAPE_MU_" + numberGrid + "_SFC"
            end if
        else if( ftype .eq. "grib2" )then
            fname = "CAPE_P0_L193_" + numberGrid
        end if
        end if
        field = loadfile->$fname$(:,:)
        field@units = "J/kg"
        field@long_name = "surface based CAPE"

    else if( fieldname .eq. "CIN_ML" .or. fieldname .eq. "CINML" )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname = "CIN_ML_"+ numberGrid + "_SFC"
        else if( ftype .eq. "grib2" )then
            fname = "CIN_P0_L192_"+ numberGrid
        end if
        end if
        field = loadfile->$fname$(:,:)

    else if( fieldname .eq. "LCL_ML" )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname = "MCONV_"+ numberGrid + "_SFC"
        else if( ftype .eq. "grib2" )then
            fname = "DIST_P0_2L5_192_" + numberGrid
        end if
        end if
        field = loadfile->$fname$(:,:)

    else if( fieldname .eq. "SLI" )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname = "U_GWD_" + numberGrid + "_SFC"
        else if(  ftype .eq. "grib2" )then
            fname = "LFTX_P0_L10_" + numberGrid
        end if
        end if
        field = loadfile->$fname$(:,:)

    else if( fieldname .eq. "SI" )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname = "PV_" + numberGrid + "_SFC"
        else if(  ftype .eq. "grib2" )then
            fname = "SHWINX_P0_L1_" + numberGrid
        end if
        end if
        field = loadfile->$fname$(:,:)
        field = where(field .le. -900.0, field@_FillValue, field)

    else if( fieldname .eq. "BRN" )then;;
        field = loadfile->GFLUX_GDS10_HYBY

    else if( fieldname .eq. "HPBL" )then;;
        field = loadfile->CIN_GDS10_SFC

    else if( fieldname .eq. "SDI_1" )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            ; fname = "CFRZR_" + numberGrid + "_SFC"
            fname = "SDI_1_" + numberGrid + "_SFC"
        else if(  ftype .eq. "grib2" )then
            fname = "LFTX_P0_L1_" + numberGrid
        end if
        end if
        field = loadfile->$fname$

    else if( fieldname .eq. "SDI_2" )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "CICEPL_" + numberGrid + "_SFC"
            else
                fname = "SDI_2_" + numberGrid + "_SFC"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "4LFTX_P0_L1_" + numberGrid
        end if
        end if
        field = loadfile->$fname$

    else if( fieldname .eq. "TCONDMAX" )then;;
        ; field = loadfile->SP_C_GDS10_EATM 
        field = loadfile->VAR_48_GDS10_EATM

    else if( fieldname .eq. "TCOND10MX" )then;;
        field = loadfile->VAR_49_GDS10_EATM

    else if( fieldname .eq. "UHMAX" )then;;
        field = loadfile->STRM_GDS10_GPMY

    else if( fieldname .eq. "VORWCTMAX" )then;;
        field = loadfile->V_POT_GDS10_GPMY

    else if( fieldname .eq. "WCTMAX" )then;;
        field = loadfile->MNTSF_GDS10_GPMY

    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;
    end if;;

    if( numberGrid .eq. "GDS10" )then;;
        field@lon2d = loadfile->g10_lon_1(:,:)
        field@lat2d = loadfile->g10_lat_0(:,:)

    else if( numberGrid .eq. "GRLL0" )then;;
        field@lon2d = loadfile->gridlon_0(:,:)
        field@lat2d = loadfile->gridlat_0(:,:)

    end if;;
    end if;;

    return(field)

end;;

undef("fields_cm_sw")
function fields_cm_sw( files_sw, fieldname, sufTime )
local loadfile
begin;;

    print( files_sw )
    print( "fieldname: " + fieldname )
    loadfiles = addfiles(files_sw,"r")
    ListSetType (loadfiles, "join")
    ; print (loadfiles)
    ; printVarSummary (loadfiles)
    ; print (loadfiles(0))

    f1 = addfile(files_sw(0),"r")
    ftype = get_grib_metadata( f1 )
    numberGrid = ftype@numberGrid


    if( str_get_cols(str_sub_str(fieldname,"_",""),0,3) .eq. "SDI2" )then;;

        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "CICEPL_" + numberGrid + "_SFC"
            else
                fname = "SDI_2_" + numberGrid + "_SFC"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "4LFTX_P0_L1_" + numberGrid
        end if
        end if
        field = loadfiles[:]->$fname$
        ; field@long_name = ""
        ; field@units = ""

    else if( str_get_cols(str_sub_str(fieldname,"_",""),0,5) .eq. "CAPEML" )then

        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "PEVPR_" + numberGrid + "_SFC"
            else
                fname = "CAPE_ML_" + numberGrid + "_SFC"
            end if
        else if( ftype .eq. "grib2" )then
            fname = "CAPE_P0_L192_" + numberGrid
        end if
        end if

        field = loadfiles[:]->$fname$
        ; field@long_name = ""
        ; field@units = ""

    else if( str_get_cols(str_sub_str(fieldname,"_",""),0,6) .eq. "CAPECON" )then

        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "LRGHR_" + numberGrid + "_SFC"
            else
                fname = "CAPE_CON_" + numberGrid + "_SFC"
            end if
        else if(  ftype .eq. "grib2" )then
            fname = "CAPE_P0_L1_" + numberGrid
        end if
        end if

        field = loadfiles[:]->$fname$
        ; field@long_name = ""
        ; field@units = ""

    end if
    end if
    end if;;


    if( numberGrid .eq. "GDS10" )then;;
        field@lon2d = loadfiles[0]->g10_lon_1(:,:)
        field@lat2d = loadfiles[0]->g10_lat_0(:,:)

    else if( numberGrid .eq. "GRLL0" )then;;
        field@lon2d = loadfiles[0]->gridlon_0(:,:)
        field@lat2d = loadfiles[0]->gridlat_0(:,:)

    end if;;
    end if;;

    ; printVarSummary (field)

    return field

end;;


undef("fields_cm_xyt")
function fields_cm_xyt( loadfile, fieldname, ftime )
begin;;
    ;-------------------- fields ---------------------
    if( fieldname .eq. "fSnow6h" .or. fieldname .eq. "fSnow24h" )then
        dh = str_sub_str(str_sub_str( fieldname, "fSnow", "" ),"h","")
        fname = str_sub_str( fieldname, "fSnow", "SNO_D_GDS10_SFC_ave" )
        field = loadfile->$fname$({ftime},:,:)
        ; print(dh)
        ; exit
        ; if( fieldname .eq. "fSnow6h")then
            ; field = loadfile->SNO_D_GDS10_SFC_ave6h({ftime},:,:)
        ; else if( fieldname .eq. "fSnow6h")then
            ; field = loadfile->SNO_D_GDS10_SFC_ave24h({ftime},:,:)
        ; end if
        ; end if
        field = field * 100
        field@units = "cm"
        field@long_name = "Height of fresh snow for "+ dh +" hours"
        ; leadtime = loadfile->forecast_time0({ftime})
        leadtime = loadfile->forecast_time0(:)
        ; print(leadtime + " " + leadtime({ftime}))
        ; exit
        if ( isatt(field,"forecast_time0") .and. .not. isatt(field,"forecast_time") )then
            field@forecast_time = field@forecast_time0
            field@forecast_time_units = leadtime@units
        end if
    end if

    field@lon2d = loadfile->g10_lon_2(:,:)
    field@lat2d = loadfile->g10_lat_1(:,:)

    return(field)

end;;

; undef("fields_cm_s")
; function fields_cm_s( loadfile, fieldname, ftime )
; begin;;
    ;;-------------------- surface fields ---------------------
    ; if( isvar("file_cm_sfield") )then
        ; loadfile = addfile(file_cm_sfield+ftype,"r")
        ; tk   = loadfile->TMP_GDS10_SFC
        ; u10m = loadfile->U_GRD_GDS10_HTGL
        ; v10m = loadfile->V_GRD_GDS10_HTGL
        ; pmsl = loadfile->PRMSL_GDS10_MSL
        ;;pmsl = loadfile->PMSL_GDS10_MSL
        ; ps   = loadfile->PRES_GDS10_SFC
        ; totprec = loadfile->A_PCP_GDS10_SFC_acc1h
        ;;pmsl = lfile->$field$
        ; if( isdefined(getenv("NCL_GRIB_PTABLE_PATH")) )then
          ;;  totprec = loadfile->TOT_PREC_GDS10_SFC_acc1h
        ; end if
        ; delete(loadfile)
    ; end if
; end;;

undef("fields_cm_s")
function fields_cm_s( files_s, fieldname, sufTime )
local loadfile
begin;;

    print( files_s )
    print( "fieldname: " + fieldname )
    setfileoption ("grb", "TimePeriodSuffix",False)
    loadfiles = addfiles(files_s,"r")
    ListSetType (loadfiles, "join")
    ; print (loadfiles)
    ; printVarSummary (loadfiles)
    ; print (loadfiles(0))

    f1 = addfile(files_s(0),"r")
    ftype = get_grib_metadata( f1 )
    numberGrid = ftype@numberGrid

    if( str_get_cols(str_sub_str(fieldname,"_",""),0,6) .eq. "VMAX10M" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname = "GUST_" + numberGrid + "_SFC" 
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "LTNG_" + numberGrid + "_HTGL"
            else
                fname = "VMAX_" + numberGrid + "_HTGL"
            end if
        else if( ftype .eq. "grib2" )then
            fname = "GUST_P8_L103_" + numberGrid + "_max"

        else if( ftype .eq. "netcdf"  )then
            fname  = "gust10"
        end if
        end if
        end if
        field = loadfiles[:]->$fname$
        ; field@long_name = "maximum 10m wind gust"

    end if

    if( numberGrid .eq. "GDS10" )then;;
        field@lon2d = loadfiles[0]->g10_lon_1(:,:)
        field@lat2d = loadfiles[0]->g10_lat_0(:,:)

    else if( numberGrid .eq. "GRLL0" )then;;
        field@lon2d = loadfiles[0]->gridlon_0(:,:)
        field@lat2d = loadfiles[0]->gridlat_0(:,:)

    end if;;
    end if;;

    ; printVarSummary (field)

    return field


end;;

;-------------------- pressure fields ---------------------
undef("field_cm_p")
function field_cm_p( loadfile, fieldname, ftime )
begin;;
    ; print( str_get_cols(fieldname,0,0) + "_" + str_get_cols(fieldname,1,4) )
    ftype = get_grib_metadata( loadfile )
    numberGrid = ftype@numberGrid

    ga = 9.80665 ; gravity acceleration
    ; print(loadfile)
    if(      fieldname .eq. "H500" )then;;
        ; field    = loadfile->FI_GDS10_ISBL(lv_ISBL0 | 500,:,:)/9.81
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname    = "GP_" + numberGrid + "_ISBL"
            else
                fname    = "FI_" + numberGrid + "_ISBL"
            end if
            vlevel = 500
        else if(  ftype .eq. "grib2" )then
            fname    = "GP_P0_L100_" + numberGrid
            vlevel = 50000
        else if( ftype .eq. "netcdf"  )then
            fname  = "geopot"
            vlevel = 50000
        end if
        end if
        end if
        ; print( fname )
        if( ftype .ne. "netcdf"  )then
            field = loadfile->$fname$({vlevel},:,:)
        else
            field = loadfile->$fname$(0,{vlevel},:,:)
        end if
        field = field/ga/10
        
        field@units = "gpdm"
        field@long_name = "H500"

    else if(      fieldname .eq. "H50" )then
        ; field    = loadfile->FI_GDS10_ISBL(lv_ISBL0 | 500,:,:)/9.81
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname    = "FI_" + numberGrid + "_ISBL"
            vlevel = 50
        else if(  ftype .eq. "grib2" )then
            fname    = "GP_P0_L100_" + numberGrid
            vlevel = 5000
        else if( ftype .eq. "netcdf"  )then
            fname  = "geopot"
            vlevel = 5000
        end if
        end if
        end if
        ; print( fname )
        if( ftype .ne. "netcdf"  )then
            field = loadfile->$fname$({vlevel},:,:)
        else
            field = loadfile->$fname$(0,{vlevel},:,:)
        end if
        field = field/ga/10

        field@units = "gpdm"
        field@long_name = "H50"

    else if( fieldname .eq. "H700" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname    = "FI_" + numberGrid + "_ISBL"
            vlevel = 700
        else if(  ftype .eq. "grib2" )then
            fname    = "GP_P0_L100_" + numberGrid
            vlevel = 70000
        end if
        end if
        ; print( fname )
        field = loadfile->$fname$({vlevel},:,:)
        field = field/ga/10
        
        field@units = "gpdm"
        field@long_name = "H700"

    else if( fieldname .eq. "H850" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname    = "FI_" + numberGrid + "_ISBL"
            vlevel = 850
        else if(  ftype .eq. "grib2" )then
            fname    = "GP_P0_L100_" + numberGrid
            vlevel = 85000
        end if
        end if
        field = loadfile->$fname$({vlevel},:,:)
        field = field/ga/10

        field@units = "gpdm"
        field@long_name = "H850"

    else if( fieldname .eq. "H925" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname    = "GP_" + numberGrid + "_ISBL"
            else
                fname    = "FI_" + numberGrid + "_ISBL"
            end if
            vlevel = 925
        else if(  ftype .eq. "grib2" )then
            fname    = "GP_P0_L100_" + numberGrid
            vlevel = 92500
        end if
        end if
        field = loadfile->$fname$({vlevel},:,:)
        field = field/ga/10

        field@units = "gpdm"
        field@long_name = "H925"

    else if( fieldname .eq. "FIplev" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname    = "FI_" + numberGrid + "_ISBL"
        else if(  ftype .eq. "grib2" )then
            fname    = "GP_P0_L100_" + numberGrid
        else if( ftype .eq. "netcdf"  )then
            fname  = "geopot"
        end if
        end if
        end if
        if( ftype .ne. "netcdf"  )then
            field = loadfile->$fname$(:,:,:)
        else
            field = loadfile->$fname$(0,:,:,:)
        end if
        ; field = field/ga/10
        ; field@units = "gpdm"
        ; field@long_name = "FIplev"

    else if( fieldname .eq. "u500" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            ; fname    = "U_" + numberGrid + "_ISBL"
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "U_GRD_" + numberGrid + "_ISBL"
            else
                fname = "U_" + numberGrid + "_ISBL"
            end if
            vlevel = 500
        else if(  ftype .eq. "grib2" )then
            fname    = "UGRD_P0_L100_" + numberGrid
            vlevel = 50000
        end if
        end if
        field = loadfile->$fname$({vlevel},:,:)

    else if( fieldname .eq. "v500" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname    = "V_" + numberGrid + "_ISBL"
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "V_GRD_" + numberGrid + "_ISBL"
            else
                fname = "V_" + numberGrid + "_ISBL"
            end if
            vlevel = 500
        else if(  ftype .eq. "grib2" )then
            fname    = "VGRD_P0_L100_" + numberGrid
            vlevel = 50000
        end if
        end if
        field = loadfile->$fname$({vlevel},:,:)

    else if( fieldname .eq. "u925" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "U_GRD_" + numberGrid + "_ISBL"
            else
                fname = "U_" + numberGrid + "_ISBL"
            end if
            ; fname    = "U_" + numberGrid + "_ISBL"
            vlevel = 925
        else if(  ftype .eq. "grib2" )then
            fname    = "UGRD_P0_L100_" + numberGrid
            vlevel = 92500
        end if
        end if
        field = loadfile->$fname$({vlevel},:,:)

    else if( fieldname .eq. "v925" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "V_GRD_" + numberGrid + "_ISBL"
            else
                fname = "V_" + numberGrid + "_ISBL"
            end if
            ; fname    = "V_" + numberGrid + "_ISBL"
            vlevel = 925
        else if(  ftype .eq. "grib2" )then
            fname    = "VGRD_P0_L100_" + numberGrid
            vlevel = 92500
        end if
        end if
        field = loadfile->$fname$({vlevel},:,:)

    else if( fieldname .eq. "Uplev" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname    = "U_" + numberGrid + "_ISBL"
        else if(  ftype .eq. "grib2" )then
            fname    = "UGRD_P0_L100_" + numberGrid
        end if
        end if
        field = loadfile->$fname$(:,:,:)

    else if( fieldname .eq. "Vplev" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname    = "V_" + numberGrid + "_ISBL"
        else if(  ftype .eq. "grib2" )then
            fname    = "VGRD_P0_L100_" + numberGrid
        end if
        end if
        field = loadfile->$fname$(:,:,:)

    ; else if( fieldname .eq. "T500" )then "T850" "T925"
    else if( str_get_cols(fieldname,0,0) .eq. "T" .and. is_string_numeric(str_get_cols(fieldname,1,4)) )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname    = "TMP_" + numberGrid + "_ISBL"
            else
                fname    = "T_" + numberGrid + "_ISBL"
            end if
            vlevel = toint(str_get_cols(fieldname,1,4))
        else if(  ftype .eq. "grib2" )then
            fname    = "TMP_P0_L100_" + numberGrid
            vlevel = toint(str_get_cols(fieldname,1,4))*100
        end if
        end if
        field = loadfile->$fname$({vlevel},:,:)
        field = field - 273.15
        field@units = "C"
        ; field@long_name = "T500"
        field@long_name = fieldname
        ; file_atts = getvaratts(field)
        ; print( getvaratts(field) )
        ; print( getfilevaratts(loadfile,fname) )

    else if( fieldname .eq. "Tplev" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname    = "T_" + numberGrid + "_ISBL"
        else if(  ftype .eq. "grib2" )then
            fname    = "TMP_P0_L100_" + numberGrid
        end if
        end if
        field = loadfile->$fname$(:,:,:)
        field = field - 273.15
        field@units = "C"
        ; field@long_name = fieldname

    else if( fieldname .eq. "RH850" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname    = "RELHUM_" + numberGrid + "_ISBL"
            vlevel = 850
        else if(  ftype .eq. "grib2" )then
            fname    = "RH_P0_L100_" + numberGrid
            vlevel = 85000
        end if
        end if
        field = loadfile->$fname$({vlevel},:,:)
        ; field@units = "%"
        field@long_name = field@long_name + " at 850gPa"
        
    ; else if( fieldname .eq. "RH925" )then
    else if( str_get_cols(fieldname,0,1) .eq. "RH" .and. is_string_numeric(str_get_cols(fieldname,2,5)) )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname    = "RELHUM_" + numberGrid + "_ISBL"
            vlevel = toint(str_get_cols(fieldname,2,5))
        else if(  ftype .eq. "grib2" )then
            fname    = "RH_P0_L100_" + numberGrid
            vlevel = toint(str_get_cols(fieldname,2,5))*100
        end if
        end if
        field = loadfile->$fname$({vlevel},:,:)
        field@long_name = field@long_name + " at 925gPa"

    else if( fieldname .eq. "RHplev" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname    = "RELHUM_" + numberGrid + "_ISBL"
        else if(  ftype .eq. "grib2" )then
            fname    = "RH_P0_L100_" + numberGrid
        end if
        end if
        field = loadfile->$fname$(:,:,:)
        ; field@units = "%"

    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if;;
    

    if( str_get_cols(fieldname,0,1) .eq. "Tz" .and. \
        (is_string_numeric(str_get_cols(fieldname,2,4)) .or. is_string_numeric(str_get_cols(fieldname,2,5)) ) .and. \
        str_get_cols(fieldname,-1,-1) .eq. "m"    )then
        if( is_string_numeric(str_get_cols(fieldname,2,5)))then
            vlevel = toint(str_get_cols(fieldname,2,5))
        else
            vlevel = toint(str_get_cols(fieldname,2,4))
        end if
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname    = "TMP_" + numberGrid + "_GPML"
            else
                fname    = "T_" + numberGrid + "_GPML"
            end if
            
        else if(  ftype .eq. "grib2" )then
            fname    = "TMP_P0_L102_" + numberGrid
        end if
        end if
        field = loadfile->$fname$({vlevel},:,:)
        field = field - 273.15
        field@units = "C"
        field@long_name = fieldname
        ; file_atts = getvaratts(field)
        ; print( getvaratts(field) )
        ; print( getfilevaratts(loadfile,fname) )

    else if( str_get_cols(fieldname,0,1) .eq. "Uz" .and. \
        (is_string_numeric(str_get_cols(fieldname,2,4)) .or. is_string_numeric(str_get_cols(fieldname,2,5)) ) .and. \
        str_get_cols(fieldname,-1,-1) .eq. "m"    )then
        if( is_string_numeric(str_get_cols(fieldname,2,5)))then
            vlevel = toint(str_get_cols(fieldname,2,5))
        else
            vlevel = toint(str_get_cols(fieldname,2,4))
        end if
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname    = "U_GRD_" + numberGrid + "_GPML"
            else
                fname    = "U_" + numberGrid + "_GPML"
            end if
            
        else if(  ftype .eq. "grib2" )then
            fname    = "UGRD_P0_L102_" + numberGrid
        end if
        end if
        field = loadfile->$fname$({vlevel},:,:)

    else if( str_get_cols(fieldname,0,1) .eq. "Vz" .and. \
        (is_string_numeric(str_get_cols(fieldname,2,4)) .or. is_string_numeric(str_get_cols(fieldname,2,5)) ) .and. \
        str_get_cols(fieldname,-1,-1) .eq. "m"  )then
        if( is_string_numeric(str_get_cols(fieldname,2,5)))then
            vlevel = toint(str_get_cols(fieldname,2,5))
        else
            vlevel = toint(str_get_cols(fieldname,2,4))
        end if
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname    = "V_GRD_" + numberGrid + "_GPML"
            else
                fname    = "V_" + numberGrid + "_GPML"
            end if
            
        else if(  ftype .eq. "grib2" )then
            fname    = "VGRD_P0_L102_" + numberGrid
        end if
        end if
        field = loadfile->$fname$({vlevel},:,:)

    end if
    end if
    end if

    ;-------------------- fields on pressure levels ---------------------
    ; file_atts  = getfilevaratts(loadfile, "FI_GDS10_ISBL")
    ; print(file_atts)
    ; p    = loadfile->lv_ISBL0(:)
    ; if ( getenv("NCL_GRIB_PTABLE_PATH") .eq. "missing" ) then
      ; tk   = loadfile->TMP_GDS10_ISBL(:,:,:)
      ; z    = loadfile->GP_GDS10_ISBL(:,:,:)/9.81
      ; rh   = loadfile->R_H_GDS10_ISBL(:,:,:)
      ; u    = loadfile->U_GRD_GDS10_ISBL(:,:,:)
      ; v    = loadfile->V_GRD_GDS10_ISBL(:,:,:)
      ; w    = loadfile->OMEGA_GDS10_ISBL(:,:,:) ; sometimes no exists
    ; else
      ; tk   = loadfile->T_GDS10_ISBL(:,:,:)
      ; z    = loadfile->FI_GDS10_ISBL(:,:,:)/9.81
      ; rh   = loadfile->RELHUM_GDS10_ISBL(:,:,:)
      ; u    = loadfile->U_GDS10_ISBL(:,:,:)
      ; v    = loadfile->V_GDS10_ISBL(:,:,:)
      ; w    = loadfile->OMEGA_GDS10_ISBL(:,:,:) ; sometimes no exists
    ; end if
    ; z@units = "m"
    ; z@long_name = "height"
    ; nlev = dimsizes(tk(:,0,0))

    if( ftype .eq. "netcdf" )then
        if( dimsizes(dimsizes(field)) .eq. 3 .and. dimsizes(field(:,0,0)) .eq. 1 )then
            field := field(0,:,:)
        else if( dimsizes(dimsizes(field)) .eq. 4 .and. dimsizes(field(:,0,0,0)) .eq. 1 \
                  .and. dimsizes(field(0,:,0,0)) .eq. 1 )then
            field := field(0,0,:,:)
        end if
        end if
        ; field&lon = loadfile->lon
        ; field&lat = loadfile->lat
        time = loadfile->time
        ; printVarSummary(time)
        field@initial_time = time@units
        field@forecast_time = stringtoint(time)
        ; printVarSummary(field)
    end if

    if( numberGrid .eq. "GDS10" )then;;
        field@lon2d = loadfile->g10_lon_2(:,:)
        field@lat2d = loadfile->g10_lat_1(:,:)

    else if( numberGrid .eq. "GRLL0" )then;;
        field@lon2d = loadfile->gridlon_0(:,:)
        field@lat2d = loadfile->gridlat_0(:,:)

    end if;;
    end if;;
    ; printVarSummary(field)

    return(field)

end;;


;-------------------- model fields ---------------------
undef("field_cm_m")
function field_cm_m( loadfile, fieldname, ftime )
begin;;

    ; print(loadfile)
    ftype = get_grib_metadata( loadfile )
    numberGrid = ftype@numberGrid

    ; print( "NCL_GRIB_PTABLE_PATH: " + getenv("NCL_GRIB_PTABLE_PATH") )
    ; print( "ftype: " + ftype )

    if( fieldname .eq. "Umlev" )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname    = "U_" + numberGrid + "_HYBY"
        else if(  ftype .eq. "grib2" )then
            fname    = "UGRD_P0_2L150_GRLL1"
        end if
        end if
    
        field    = loadfile->$fname$(:,:,:)

    else if( fieldname .eq. "Vmlev" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            fname    = "V_" + numberGrid + "_HYBY"
        else if(  ftype .eq. "grib2" )then
            fname    = "VGRD_P0_2L150_GRLL2"
        end if
        end if
        field    = loadfile->$fname$(:,:,:)

    end if
    end if;;

    if( fieldname .eq. "WSO2" )then;;
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "NCIP_"+ numberGrid +"_DBLL"
            else
                fname = "W_SO_"+ numberGrid +"_DBLL"
            end if
        end if
        field  = loadfile->$fname$(1,:,:)
    end if;;
    
    if( fieldname .eq. "HICE" )then
        if( ftype .eq. ".grb" .or. ftype .eq. "grib1" )then
            if ( ismissing(getenv("NCL_GRIB_PTABLE_PATH")) )then
                fname = "ICETK_"+ numberGrid +"_SFC"
            end if
        else if( ftype .eq. "grib2" )then
            fname = "ICETK_P0_L1_"+ numberGrid 

        end if
        end if
        field  = loadfile->$fname$

    end if
    
    if( numberGrid .eq. "GDS10" )then;;
        field@lon2d = loadfile->g10_lon_2(:,:)
        field@lat2d = loadfile->g10_lat_1(:,:)

    else if( numberGrid .eq. "GRLL0" )then;;
        field@lon2d = loadfile->gridlon_0(:,:)
        field@lat2d = loadfile->gridlat_0(:,:)

    end if;;
    end if;;

    return(field)

end;;

;-----------------------------------------------------------
; read topography and land-fraction for cosmo-grid
undef("field_cm_constant")
function field_cm_constant( loadfile, fieldname, ftime )
begin;;

    ; loadfile = addfile(file_cm_constant+ftype,"r")
    ; print( getfilevarnames( loadfile ) )
    print( fieldname )
    ftype = ".grb"
    if ( str_get_cols(getfilepath (loadfile),-3,-1) .eq. ".nc") then
        ftype = ".nc"
    end if

    ftype_n = get_grib_metadata( loadfile )
    numberGrid = ftype_n@numberGrid

    if( fieldname .eq. "HSURF" )then
        if( ftype .eq. ".grb" .or. ftype_n .eq. "grib1" )then
            ; if( isdefined(getenv("NCL_GRIB_PTABLE_PATH")) )then
            ; if ( getenv("NCL_GRIB_PTABLE_PATH") .ne. "missing" ) then
            if ( .not. ismissing(getenv("NCL_GRIB_PTABLE_PATH")) ) then
                print("user(cosmo) list variable")
                ; field   = loadfile->HH_GDS10_SFC
                fname = "HH_" + numberGrid + "_SFC"
                ; hhl    = loadfile->HH_GDS10_HYBL
                ; frland = loadfile->FR_LAND_GDS10_SFC
            else
                print("default list variable")
                ; field   = loadfile->DIST_GDS10_SFC
                ; fname = "HGT_" + numberGrid + "_SFC"
                fname = "DIST_" + numberGrid + "_SFC"
                ; frland = loadfile->LAND_GDS10_SFC
            end if

        else if( ftype_n .eq. "grib2" )then
            fname =  "GP_P0_L1_" + numberGrid

        end if
        end if
        field   = loadfile->$fname$

        if( ftype .eq. ".nc" )then
            field   = loadfile->HSURF(0,:,:)
            ; frland = loadfile->FR_LAND(0,:,:)
        end if
        ; if( .not. isvar("hsurf") )then
            ; print("Only grb or nc file type is supported!")
            ; exit
        ; end if

    else if( fieldname .eq. "URBAN" .or. \
             fieldname .eq. "AHF" .or. \
             fieldname .eq. "ISA"   \
        )then
        ; field = loadfile->VAR_92_GDS10_SFC(:,:)
        ftype = ".nc"
        ; fname = "/cygdrive/d/Denis/yaDisk/HMC/tmp/cm01msk_2018112700/laf2018112700.nc"
        fname = "/cygdrive/e/Denis/yaDisk/HMC/tmp/cm01msk_2018112700/laf2018112700.nc"
        loadfile = addfile(fname, "r")
        field = loadfile->$fieldname$(0,:,:)
        field@forecast_time = 0
        field@forecast_time_units = "hours"
        field@initial_time = "11/27/2018 (00:00)"

    else if( fieldname .eq. "SOILTYP" .or. fieldname .eq. "PEAT" )then
        field   = loadfile->SOILTYP_GDS10_SFC

    end if
    end if
    end if

    if( fieldname .eq. "FRLAND" )then;;
        print( " load frland " )
        ; print( loadfile )
        ; print( getfilepath (loadfile) )
        if ( getenv("NCL_GRIB_PTABLE_PATH") .ne. "missing" .and. ftype .eq. ".grb" ) then
            print("user(cosmo) list variable")
            field = loadfile->FR_LAND_GDS10_SFC
        else if (ftype .eq. ".grb" )
            print("default list variable")
            field = loadfile->LAND_GDS10_SFC
        else if (ftype .eq. ".nc" )
            field = loadfile->FR_LAND
        end if
        end if
        end if

    end if;;

    if( fieldname .eq. "GLON" )then;;
        field = loadfile->RLON_GDS10_SFC
    else if( fieldname .eq. "GLAT" )then;;
        field = loadfile->RLAT_GDS10_SFC
    end if;;
    end if;;

    latlon = str_split(field@coordinates, " ")
    if( ftype .eq. ".grb" )then
        lat2d = loadfile->$latlon(0)$
        lon2d = loadfile->$latlon(1)$
        rot   = loadfile->g10_rot_2
    end if
    if( ftype .eq. ".nc" )then
        lat2d = loadfile->$latlon(1)$
        lon2d = loadfile->$latlon(0)$
        ; rot   = loadfile->g10_rot_2
    end if
    
    if( fieldname .eq. "rot" )then
        field(:,:)  = loadfile->g10_rot_2
        field@units = "degrees"
        field = field * 180/ 3.1415
    end if

    ; geo-reference data
    field@lat2d = lat2d
    field@lon2d = lon2d

    ; get position of rotated North pole
    if( ftype .eq. ".grb" )then
        pole_lon = lat2d@Longitude_of_southern_pole - 180.0
        pole_lat = -lat2d@Latitude_of_southern_pole
    end if
    if( ftype .eq. ".nc" )then
        pole = loadfile->rotated_pole
        pole_lon = pole@grid_north_pole_longitude
        pole_lat = pole@grid_north_pole_latitude
    end if

    field@pole_lon = pole_lon
    field@pole_lat = pole_lat

    ; get dimensions
    nlat = dimsizes(lat2d(:,0))
    nlon = dimsizes(lon2d(0,:))

    ; print( nlon )
    ; print( nlat )

    ; hsurf@nlat = nlat
    ; hsurf@nlon = nlon

    ; nz = dimsizes(hhl(:,0,0))
    ; hfl  = (hhl(0:nz-2,:,:) + hhl(1:nz-1,:,:))*0.5
    ; hfl@units = "m"
    ; hfl@long_name = "heights of hybrid model levels"
    ; hfl@coordinates = "g10_lat_1 g10_lon_2"

    ; print( hhl(:,0,0) )
    ; print( hfl(:,0,0) )

    return(field)
end;;
;-----------------------------------------------------------

undef("point_cm_constants")
function point_cm_constants( fname, fieldname, select )
local field, const
begin;;
    print( fieldname )
    ftype = ".grb"

    const = True
    loadfile = addfile(fname, "r")
    if( fieldname .eq. "hfl" )then
        if( ftype .eq. ".grb" )then
            ; if( isdefined(getenv("NCL_GRIB_PTABLE_PATH")) )then
            if ( getenv("NCL_GRIB_PTABLE_PATH") .ne. "missing" ) then
                print("user(cosmo) list variable")
                ; field   = loadfile->HH_GDS10_SFC(select@j,select@i)
                hsurf   = loadfile->HH_GDS10_SFC(select@j,select@i)
                ; const@hsurf   = loadfile->HH_GDS10_SFC(select@j,select@i)
                const@hsurf   = hsurf
                const@hhl     = loadfile->HH_GDS10_HYBL(:,select@j,select@i)
                nz = dimsizes(const@hhl)
                const@hfl  = (const@hhl(0:nz-2) + const@hhl(1:nz-1))*0.5
                ; const@hsurf   = const@hhl(0)
                const@frland  = loadfile->FR_LAND_GDS10_SFC(select@j,select@i)
                field = const@hhl
                latlon = str_split(hsurf@coordinates, " ")
                ; print(latlon)
                ; latlon = getfilevardimnames(loadfile,"HH_GDS10_SFC")
                const@lat2d = loadfile->$latlon(0)$(select@j,select@i)
                const@lon2d = loadfile->$latlon(1)$(select@j,select@i)
            else
                print("default list variable")
                field   = loadfile->DIST_GDS10_SFC
                ; frland = loadfile->LAND_GDS10_SFC
            end if
        end if

        if( ftype .eq. ".nc" )then
            field   = loadfile->HSURF(0,:,:)
            ; frland = loadfile->FR_LAND(0,:,:)
        end if
    end if

    print( const )
    ; print( const@hhl )
    ; print( const@hfl )
    ; print( field )
    ; print( getfiledimnames(loadfile) )
    ; print( getfilevardimnames(loadfile,"HH_GDS10_SFC"))
    ; print( latlon )
    ; att = getfilevaratts(loadfile,"HH_GDS10_SFC")
    ; print( att )
    ; print( att@coordinates )
    ; print( hsurf )
    return const

end;;

;-------------------- surface fields ---------------------
undef("field_txt_1c")
function field_txt_1c( loadfile, fieldname, ftime )
begin;;

    field = asciiread(loadfile,   -1, "float" )

    if(      fieldname .eq. "PMSL" )then;;
        ; field = loadfile->PRMSL_GDS10_MSL
        field = loadfile->PMSL_GDS10_MSL(:,:)

    else if( fieldname .eq. "QNH" )then;;
        field = loadfile->PMSL_GDS10_MSL(:,:)

    else if( fieldname .eq. "T_2M" )then;;
        field = field - 273.15
        field@long_name = "temperature at 2m"
        field@units = "C"

    else if( str_upper(fieldname) .eq. "U_10M" )then;;
        field@long_name = "U-component of wind "
        field@units = "m/s"

    else if( str_upper(fieldname) .eq. "V_10M" )then;;
        field@long_name = "V-component of wind "
        field@units = "m/s"

    end if;;
    end if;;
    end if;;
    end if;;
    end if;;

    return(field)

end;;
