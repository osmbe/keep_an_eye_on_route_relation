# This is a very simple script to keep an eye on OSM relations and detect when they break.
# When you run the script, it simply checks if the status of the relation is OK or not, according to ra.osmsurround.org
# It can optionally also check if the length is still equal to a length you listed beforehand.
#
# First of all, you need clear text file, in wich you write down the relation number you want to check.

# (optional):   You can add a comma, followed by the relation length, expressed in KM, with decimal separator "."
#               for example: 52997,7.161
#               (in order to get the length for your relations, you scrape them from  http://ra.osmsurround.org/analyzeRelation using a modified version of this script.
# Questions: s8evq@runbox.com


# Change the two variables below
list="/change/path/to/relations_list"
tmp_html="/tmp/keepeye.html"


grep -v "#" $list | while read list_line

do

list_relationnr=$(echo $list_line | cut -f1 -d,)
list_length=$(echo $list_line | cut -s -f2 -d,)


# sleep function. so the script does not bother the ra.osmsurround.org website too much
sleep 1


wget -q --header='Accept-Language: en-us' --user-agent Mozilla/4.0  -O $tmp_html "http://ra.osmsurround.org/analyzeRelation?relationId=$list_relationnr"


#check status
if grep "alert-error" $tmp_html > /dev/null ; then
        echo -n "NOT OK $list_relationnr "
        grep "alert-heading" $tmp_html | cut -f2 -d ">" | cut -f1 -d "<"
else
        if ! grep "alert-success" $tmp_html > /dev/null ; then
        echo "Other error with $list_relationnr"
        fi
fi



#check length
grepped_length=$(grep "Length in KM: <span class=\"label label-info\">" $tmp_html | cut -f2 -d ">" | cut -f1 -d "<" )
if [ ! -z $list_length ] ; then
        if [ ! "$(echo $grepped_length==$list_length | bc -l)" == 1 ]; then
                echo "NOT OK $list_relationnr Length does not match"
        fi
fi


done

