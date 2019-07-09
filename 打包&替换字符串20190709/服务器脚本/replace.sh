#!/bin/bash
echo "============== start replace... ==================="

######################替换文件夹名################################
echo -e \\033[34m 1.start replace file-box \\033[0m
if mv ./$1/src/interface/$2 ./$1/src/interface/$3
then
    echo "$1/src/interface/路径下$2已更名为$3"
else 
    echo "$1/src/interface/路径下更名失败！！！"
fi

if mv ./$1/src/world_scripts/$2 ./$1/src/world_scripts/$3
then
    echo "$1/src/world_scripts/路径下$2已更名为$3"
else 
    echo "$1/src/world_scripts/路径下更名失败！！！"
fi

if mv ./$1/include/interface/$2 ./$1/include/interface/$3
then
    echo "$1/include/interface/路径下$2已更名为$3"
else 
    echo "$1/include/interface/路径下更名失败！！！"
fi

if mv ./$1/include/scripts/$2 ./$1/include/scripts/$3
then
    echo "$1/include/scripts/路径下$2已更名为$3"
else 
    echo "$1/include/scripts/路径下更名失败！！！"
fi

if mv ./$1/scripts_xml/$2 ./$1/scripts_xml/$3
then
    echo "$1/scripts_xml/路径下$2已更名为$3"
else 
    echo "$1/scripts_xml/路径下更名失败！！！"
fi
echo -e "\n"



#####################替换文件名######################################
echo -e \\033[34m 2.start replace file_name \\033[0m
typeset -u t2=$2 #把变量2转换为大写
typeset -u t3=$3 #把变量3转换为大写

if rename $t2 $t3 ./$1/src/interface/$3/$t2*
then
    echo "$1/src/interface/$3路径下所有文件$t2已替换为$t3"
fi

if rename $t2 $t3 ./$1/src/world_scripts/$3/$t2*
then
    echo "$1/src/world_scripts/$3路径下所有文件$t2已替换为$t3"
fi

if rename $t2 $t3 ./$1/include/interface/$3/$t2*
then
    echo "$1/include/interface/$3路径下所有文件$t2已替换为$t3"
fi

if rename $t2 $t3 ./$1/include/scripts/$3/$t2*
then
    echo "$1/include/scripts/$3路径下所有文件$t2已替换为$t3"
fi

#if rename $t2 $t3 ./$1/scripts_xml/$3/$t2*
#then
#    echo "$1/scripts_xml/$3路径下所有文件$t2已替换为$t3"
#fi
echo -e "\n"


 ####################替换文件内字符串####################################
echo -e \\033[34m 3.start replace file_string \\033[0m
if sed -i "s/$t2/$t3/g" `grep $t2 -rl ./$1/src/interface/$3`
then
    echo "$1/src/interface/$3路径下所有【文件字符串】$t2已替换为$t3"
fi
if sed -i "s/$2/$3/g" `grep $2 -rl ./$1/src/interface/$3`
then
    echo "$1/src/interface/$3路径下所有【文件字符串】$2已替换为$3"
fi

if sed -i "s/$t2/$t3/g" `grep $t2 -rl ./$1/src/world_scripts/$3`
then
    echo "$1/src/world_scripts/$3路径下所有【文件字符串】$t2已替换为$t3"
fi
if sed -i "s/$2/$3/g" `grep $2 -rl ./$1/src/world_scripts/$3`
then
    echo "$1/src/world_scripts/$3路径下所有【文件字符串】$2已替换为$3"
fi

if sed -i "s/$t2/$t3/g" `grep $t2 -rl ./$1/include/interface/$3`
then
    echo "$1/include/interface/$3路径下所有【文件字符串】$t2已替换为$t3"
fi
if sed -i "s/$2/$3/g" `grep $2 -rl ./$1/include/interface/$3`
then
    echo "$1/include/interface/$3路径下所有【文件字符串】$2已替换为$3"
fi

if sed -i "s/$t2/$t3/g" `grep $t2 -rl ./$1/include/scripts/$3`
then
    echo "$1/include/scripts/$3路径下所有【文件字符串】$t2已替换为$t3"
fi
if sed -i "s/$2/$3/g" `grep $2 -rl ./$1/include/scripts/$3`
then
    echo "$1/include/scripts/$3路径下所有【文件字符串】$2已替换为$3"
fi

if sed -i "s/$t2/$t3/g" `grep $t2 -rl ./$1/scripts_xml/$3`
then
    echo "$1/scripts_xml/$3路径下所有【文件字符串】$t2已替换为$t3"
fi
if sed -i "s/$2/$3/g" `grep $2 -rl ./$1/scripts_xml/$3`
then
    echo "$1/scripts_xml/$3路径下所有【文件字符串】$2已替换为$3"
fi
echo -e "\n"

                                #made by juran
   






