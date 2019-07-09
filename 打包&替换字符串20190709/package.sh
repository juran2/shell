#!/bin/bash

#用  途：用于自动将hbuilder项目打包成Android，需要hbuilder资源以及原Android包
#参  数：1:旧的包名 2:新的包名 3:HBuilder资源
#知识点：1.shell传递参数；2.文件复制，替换；3.jq工具和语法使用；4.正则表达式。
#不足点：1.原微信目录未作删除；2.其他未知。
#作  者：made by juran

#定义一些后面经常用到的路径
used_path="/home/juran/test/$1"
android_path="/home/juran/test/$2"
hbuilder_path="/home/juran/test/hbuilder/APP项目/$3"

#检测输入参数
if [ $# -ne 3 ];then
   echo "usage: arument 1:旧的包名 2:新的包名 3:HBuilder资源"
   exit
fi

if [ ! -d "$used_path" ];then
  echo "$1不存在"
  exit
fi

if [ -d "$android_path" ];then 
  echo "$2已经存在"
  exit
fi

if [ ! -d $hbuilder_path ];then
  echo "$3资源不存在"
  exit
fi

#如果新的包没有拷贝，那就拷贝一份
if [ ! -d $android_path ];then
   echo "复制$1到$2..."
   cp -r $used_path $android_path
else
   echo "$2已经存在！！！"
   exit
fi

#从manifest.json取得需要的数据
if [ ! -f "$hbuilder_path/manifest_temp.json" ];then
   cp "$hbuilder_path/manifest.json" "$hbuilder_path/manifest_temp.json"
   sed -i "s/\/\*.*\*\///g" "$hbuilder_path/manifest_temp.json" #用正则表达式去掉/**/类型注释
   sed -i "s/\/\/.*//g" "$hbuilder_path/manifest_temp.json" #用正则表达式去掉//类型注释
fi
new_id=`echo $(cat "$hbuilder_path/manifest_temp.json" | jq '.id') | sed s/\"//g` #用jq获得id，然后管道去掉“”双引号
new_name=`echo $(cat "$hbuilder_path/manifest_temp.json" | jq '.name') | sed s/\"//g`
wx_appid=`echo $(cat "$hbuilder_path/manifest_temp.json" | jq '.plus.distribute.plugins.oauth.weixin.appid') | sed s/\"//g`
wx_appsecret=`echo $(cat "$hbuilder_path/manifest_temp.json" | jq '.plus.distribute.plugins.oauth.weixin.appsecret') | sed s/\"//g`

#拷贝一份manifest.json，去掉注释，然后获取对应的数据
temp_file="$android_path/app/src/main/assets/apps/*/www/manifest.json"
if [ -f $temp_file ];then
   sed -i "s/\/\*.*\*\///g" $temp_file
   sed -i "s/\/\/.*//g" $temp_file
   old_id=`echo $(cat $temp_file | jq '.id') | sed s/\"//g`
   old_name=`echo $(cat $temp_file | jq '.name') | sed s/\"//g`
fi

#打印出从json文件中获取的必须数据
echo "old_id=$old_id"
echo "old_name=$old_name"
echo "new_id=$new_id"
echo "new_name=$new_name"
echo "wx_appid=$wx_appid"
echo "wx_appsecret=$wx_appsecret"

#列举出要操作的文件
id_files=("$android_path/app/build.gradle" "$android_path/app/src/main/AndroidManifest.xml" "$android_path/app/src/main/assets/data/dcloud_control.xml" "$android_path/app/src/main/java/*/*/*/*/wxapi/WXEntryActivity.java" "$android_path/app/src/main/java/*/*/*/*/wxapi/WXPayEntryActivity.java")
name_files=("$android_path/app/build.gradle" "$android_path/app/src/main/res/values/strings.xml")
#替换文件中的appid
for file in ${id_files[@]}
do
   if [ -f $file ];then
	sed -i "s/$old_id/$new_id/g" $file
	echo "$file已替换"
   fi
done

#替换微信路径目录
told_id=${old_id//\./\/}  #把id里面的.替换成/，用于路径
tnew_id=${new_id//\./\/}
old_wxpath="$android_path/app/src/main/java/$told_id/wxapi"
new_wxpath="$android_path/app/src/main/java/$tnew_id/"
if [ ! -d $new_wxpath ];then
	mkdir -p $new_wxpath
	cp -r $old_wxpath $new_wxpath
	rm -r $old_wxpath
	echo "========微信目录创建完成"
fi

#替换hbuilder资源
if [ -d "$android_path/app/src/main/assets/apps/$old_id" ];then
	mv "$android_path/app/src/main/assets/apps/$old_id" "$android_path/app/src/main/assets/apps/$new_id"
	rm -r "$android_path/app/src/main/assets/apps/$new_id/www"
	cp -r "$hbuilder_path" "$android_path/app/src/main/assets/apps/$new_id/www"
	echo "=========hbuilder资源替换完成"
fi

#替换Android包名和icon
for file in ${name_files[@]}
do
    if [ -f $file ];then
	sed -i "s/$old_name/$new_name/g" $file
	sed -i "s/d\">.*</d\">$wx_appid</g" $file #正则匹配<string name="wx_appud"><>并替换内容
	sed -i "s/t\">.*</t\">$wx_appsecret</g" $file
	echo "$file已替换"
    fi
done
cp "$hbuilder_path/images/logo.png" "$android_path/app/src/main/res/drawable-xxhdpi/icon.png"
cp "$hbuilder_path/images/logo.png" "$android_path/app/src/main/res/drawable-xxhdpi/push.png"
echo "android图片资源替换完成"

echo "$2：自动化打包完成！！！"
