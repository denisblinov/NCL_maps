
;-----------------------------------------------------------------------------
undef("fDDHHmm")
function fDDHHmm( t, unit )
local fh, fterm
begin;;
    if( unit .eq. "minute" )then
        fh = 60
    else if( unit .eq. "hour" .or. unit .eq. "" )then
        fh = 1
    end if
    end if
    fterm = sprinti("%0.2i", t/fh/24) + sprinti("%0.2i", t/fh%24) + sprinti("%0.2i", t%fh)

    return fterm

end;;
;-----------------------------------------------------------------------------

; print( grib_stime2itime(initime) )

undef("nunitsInHour")
function nunitsInHour( unit )
local fh
begin;;
    if( unit .eq. "minute" )then
        fh = 60
    else if( unit .eq. "hour" )then
        fh = 1
    end if
    end if

    return fh

end;;

undef("get_inidate")
function get_inidate( initial_time )
begin;;

; 07/04/2019 (00:00)
    if( isStrSubset(initial_time,"-") )then
        delim = "- :"
        inidate = str_get_field(initial_time, 1, delim) +  \
                  sprinti("%0.2i", toint(str_get_field(initial_time, 2, delim))) +  \
                  sprinti("%0.2i", toint(str_get_field(initial_time, 3, delim))) +  \
                  "Z" + \
                  str_get_field(initial_time, 4, delim)
                  

    else
        inidate = str_get_cols(initial_time,6,9) +  \
                  str_get_cols(initial_time,0,1) +  \
                  str_get_cols(initial_time,3,4) +  \
                  "Z" + \
                  str_get_cols(initial_time,12,16)
    end if
    ; print("inidate: " + inidate)
    return inidate
end;;

undef("get_datetime_NCL")
function get_datetime_NCL( initial_time )
begin;;

        inidate = str_get_cols(initial_time,4,5) + "/" + \
                  str_get_cols(initial_time,6,7) + "/" + \
                  str_get_cols(initial_time,0,3) +  \
                  " (" + \
                  str_get_cols(initial_time,9,10) + \
                  str_get_cols(initial_time,11,13) + \
                  ")"
                  ; ":00)"

    ; print(inidate)
    return inidate
end;;

undef("get_dateTime_fromDATEHH")
function get_dateTime_fromDATEHH( datehh )
begin;;
; datehh:  2016071318
; result:  2016-07-13Z18:00:00.0

        result  = str_get_cols(datehh,0,3) + "-" + \
                  str_get_cols(datehh,4,5) + "-" + \
                  str_get_cols(datehh,6,7) + "Z" + \
                  str_get_cols(datehh,8,9) + \
                  ":00:00.0"

    ; print(result)
    return result
end;;

undef("get_actDateTime")
function get_actDateTime( initial_time, fleadtime, tunit )
local initial_time, inidate
begin;;

    ; print("initial_time: " + initial_time + " " + fleadtime + " tunit: " + tunit )
    ; print(str_get_cols(initial_time,4,4))
    if( str_get_cols(initial_time,4,4) .eq. "-" )then
        inidate = initial_time
    else
        inidate = str_get_cols(initial_time,6,9) + str_get_cols(initial_time,0,1) + \
              str_get_cols(initial_time,3,4) + "Z" + str_get_cols(initial_time,12,16)
    end if

    if( str_get_cols(tunit,0,2) .eq. "min" )then
        curtime = systemfunc( "date -u -d '" + inidate + " " \
                + fleadtime + " minute'  +%H:%M\ %d%b%Y" )
    else
        curtime = systemfunc( "date -u -d '" + inidate + " " \
                + fleadtime + " hour'  +%H:00\ %d%b%Y" )
    end if

    return curtime

end;;

undef("get_actDateZhh")
function get_actDateZhh( inDATEzHH, fhour )
begin;;
    DATEHH = systemfunc( "date -u -d '" + inDATEzHH + " " \
           + fhour + " hour'  +%Y%m%dZ%H" )
    return DATEHH
end;;

undef("get_month3RuLabel")
function get_month3RuLabel( monthString )
begin;;
    curtime = monthString
    ; change ~ on # need for problem with ~
    ; curtime = str_sub_str(curtime, "Jan", "#F11#^mc#F07#" ) big letter
    curtime = str_sub_str(curtime, "Jan", "~mc" )
    curtime = str_sub_str(curtime, "Feb", "tfc" )
    curtime = str_sub_str(curtime, "Mar", "lap" )
    curtime = str_sub_str(curtime, "Apr", "aop" )
    curtime = str_sub_str(curtime, "May", "la~" )
    curtime = str_sub_str(curtime, "Jun", "i}m" )
    curtime = str_sub_str(curtime, "Jul", "i}k" )
    curtime = str_sub_str(curtime, "Aug", "acd" )
    curtime = str_sub_str(curtime, "Sep", "qfm" )
    curtime = str_sub_str(curtime, "Oct", "njr" )
    curtime = str_sub_str(curtime, "Nov", "mn~" )
    curtime = str_sub_str(curtime, "Dec", "efj" )

    curtime = "#F11#" + curtime + "#F07#"

    return curtime
end;;

undef("get_monthRuLabel")
function get_monthRuLabel( monthString )
begin;;
    curtime = monthString
    ; change ~ on # need for problem with ~
    curtime = str_sub_str(curtime, "January",   "~mc" )
    curtime = str_sub_str(curtime, "February",  "tfc" )
    curtime = str_sub_str(curtime, "March",     "lap" )
    curtime = str_sub_str(curtime, "April",     "aop" )
    curtime = str_sub_str(curtime, "May",       "la~" )
    curtime = str_sub_str(curtime, "June",      "i}m" )
    ; curtime = str_sub_str(curtime, "July",      "#F11#i}k#F07#" )
    curtime = str_sub_str(curtime, "July",      "i}k" )
    curtime = str_sub_str(curtime, "Augast",    "acd" )
    curtime = str_sub_str(curtime, "September", "qfm" )
    curtime = str_sub_str(curtime, "October",   "njr" )
    curtime = str_sub_str(curtime, "November",  "mn~" )
    curtime = str_sub_str(curtime, "December",  "efj" )

    curtime = "#F11#" + curtime + "#F07#"

    return curtime
end;;


procedure print_timing(timing)
begin;;

    ; print("name                          "+"%         "+"second    ")
    print(" ")
    if( isatt(timing,"routine") )then
        print("Timing of "+ timing@routine +":" )
    else
        print("Timing:")
    end if
    print_table([/"code","runtime[%]","runtime[s]","second"/], "%30s%10s%10s%10s")
    alist = [/timing@name(1:), timing@percent, timing@continious, timing@second(1:)/]
    print_table(alist,"%30s%10.2f%10d%10d")

end;;

function get_timing(prevtiming,name)
local timepoint
begin;;

    timepoint = toint(systemfunc("date +%s"))
    ; print( "timepoint:" + timepoint )
    ; print( dimsizes(prevtiming) )
    ; if( dimsizes(prevtiming) .eq. 1 .and. prevtiming .eq. 0 )then
    ; if( prevtiming .eq. 0 .or. prevtiming .eq. True )then
    if ( .not. isatt(prevtiming,"startpoint") )then
        ; timing = new((/1,2/),string)
        timing = True
        ; i = 0
        ; timing(i,0) = 0
        ; timing(i,1) = name
        timing@startpoint = timepoint
        timing@second = (/0/)
        ; print( typeof(timing@second) )
        ; exit
        timing@name = (/name/)
    else
        ; print( "not new point" )
        ; timing = array_append_record (prevtiming, (/timepoint,name/), 0)
        timing = True
        ; print("dimsizes(prevtiming@second):"+ dimsizes(prevtiming@second) )
        lasti = dimsizes(prevtiming@second)-1
        ; secFromStart = timepoint - prevtiming@second(lasti)
        secFromStart = timepoint - prevtiming@startpoint
        ; print( prevtiming@second )
        ; print( typeof(prevtiming@second(lasti)) )
        ; print( secFromStart )
        ; print( typeof(secFromStart) )
        ; timing@second := (/prevtiming@second,secFromStart/)
        ; timing@name = (/prevtiming@name,name/)
        timing@second = array_append_record(prevtiming@second,secFromStart,0)
        timing@name = array_append_record(prevtiming@name,name,0)
        timing@continious = timing@second(1:lasti+1) - timing@second(0:lasti)
        timing@percent = timing@continious / max((/tofloat(timing@second(lasti+1)),0.1/)) *100
    end if

    return timing

end;;



