#!/bin/bash
echo -e \\033[34m==============Creat ./interface/Makefile.am=================== \\033[0m 
for DIR in ./interface/*
do
    if [ -d $DIR ]
    then 
        if test `basename $DIR` !=  "subgames"
        then 
            myfilename=`basename $DIR`
        fi
    fi
done
echo "CPP存入的文件名：$myfilename"


if  >./interface/Makefile.am
then 
    echo "初始化Makefile.am成功！"
fi

public_code="AM_CPPFLAGS += -I../../include/common -I../../include/game -I../../include/interface -I../../include/interface/$myfilename -I../../include/interface/subgames 

shard_LTLIBRARIES = libinterface.la

libinterface_la_SOURCES = \ "

if echo "$public_code" > ./interface/Makefile.am
then 
    echo "public_code写入Makefile.am成功！"
fi
######################按格式写入公共的CPP##############################
for FILE in ./interface/*.cpp
do
    echo "    ` basename $FILE ` \ " >> ./interface/Makefile.am
done
echo "公共CPP写入Makefile.am成功！"
#####################按格式写入自己的CPP###############################
for FILE in ./interface/$myfilename/*.cpp 
do 
    echo "    $myfilename/` basename $FILE ` \ " >> ./interface/Makefile.am
done 
#处理最后一行不加 \ 的问题
sed -i '$d' ./interface/Makefile.am
echo "    $myfilename/` basename $FILE `" >> ./interface/Makefile.am
echo "自己CPP写入Makefile.am成功！"



echo -e \\033[34m==============Creat ./world_scripts/Makefile.am=================== \\033[0m

if  >./world_scripts/Makefile.am
then 
    echo "初始化Makefile.am成功！"
fi

public_code="AM_CPPFLAGS += -I../../include/common -I../../include/game -I../../include/interface/ -I../../include/interface/$myfilename -I../../include/scripts -I../../include/interface/subgames\
-I../../include/scripts/$myfilename 
#subdir = src/world_scripts


#noinst_LIBRARIES = libgame.a
scripts_LTLIBRARIES = libworld.la

libworld_la_SOURCES = \ "

if echo "$public_code" > ./world_scripts/Makefile.am
then 
    echo "public_code写入Makefile.am成功！"
fi
######################按格式写入公共的CPP##############################
for FILE in ./world_scripts/*.cpp
do
    echo "    ` basename $FILE ` \ " >> ./world_scripts/Makefile.am
done
echo "公共CPP写入Makefile.am成功！"
#####################按格式写入自己的CPP###############################
for FILE in ./world_scripts/$myfilename/*.cpp 
do 
    echo "    $myfilename/` basename $FILE ` \ " >> ./world_scripts/Makefile.am
done 
#处理最后一行不加 \ 的问题
sed -i '$d' ./world_scripts/Makefile.am
echo "    $myfilename/` basename $FILE `" >> ./world_scripts/Makefile.am
echo "自己CPP写入Makefile.am成功！"
     
                                          #made by juran