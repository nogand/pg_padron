BEGIN {
  FS=","
  OFS=","
}
{
print $1,$4,gensub(/\ +$/,"","g",$6),gensub(/\ +$/,"","g",$7),gensub(/\ +$/,"","g",$8),substr($2,1,1),substr($2,2,2),substr($2,4,3),$5 > "personas.txt"
}
