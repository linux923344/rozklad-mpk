#!/bin/bash
#-----CHANGE IT------

HTML="../rozklad"
lines=(KORN42 MURA42 OPL01 ORZE42 RKAP73 SOB42 UAMB01)

#-------------------

mkdir -p ./lines
LINE=$1
output=$(echo "\$output")
for line in "${lines[@]}"; do
cat << EOF > lines/$line.php
<?php
$output = shell_exec('../schedule $line');
echo "<pre>$output</pre>";
?>
EOF
done

#CREATE INDEX
cat << EOF > index.php
<html>
<head>
<title>POZNAŃ Rozkład Jazdy</title>
<script language="javascript">
function SelectRedirect(){
switch(document.getElementById('s1').value)
{
EOF

for line in "${lines[@]}"; do
cat << EOF >> index.php
case "$line":
window.location="$HTML/lines/$line.php";
break;
EOF
done

cat << EOF >> index.php
}// end of switch
}
</script>
</head>
<body>
<SELECT id="s1" NAME="section" onChange="SelectRedirect();">
<Option value="">Select Tram</option>
EOF

for line in "${lines[@]}"; do
cat << EOF >> index.php
<Option value="$line">$line</option>
EOF
done

cat << EOF >> index.php
</SELECT>
</body>
</html>
EOF



