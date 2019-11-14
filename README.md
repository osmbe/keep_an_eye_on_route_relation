# keep_an_eye_on_route_relation
A tool to monitor a list of relations

This is a very simple script to keep an eye on OSM relations and detect when they break.
When you run the script, it simply checks if the status of the relation is OK or not, according to ra.osmsurround.org
It can optionally also check if the length is still equal to a length you listed beforehand.

First of all, you need clear text file, in wich you write down the relation number you want to check.

(optional):   You can add a comma, followed by the relation length, expressed in KM, with decimal separator ".".
              For example: 52997,7.161
              (in order to get the length for your relations, you scrape them from  http://ra.osmsurround.org/analyzeRelation using a modified version of this script.)
Questions: s8evq@runbox.com
