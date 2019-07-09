
#xcodebuild打包脚本

#进入build路径clean一下工程
xcodebuild -target HBuilder clean
echo -e \\033[32m"==========clean successed========" \\033[0m

#archive导出.xcarchive文件
xcodebuild -scheme HBuilder -archivePath build/HBuilder.xcarchive archive
echo -e \\033[32m"==========archive successed======" \\033[0m 

#导出ipa包
xcodebuild -exportArchive -archivePath build/HBuilder.xcarchive -exportPath build -exportOptionsPlist export.plist
echo -e \\033[32m"===========export successed=======" \\033[0m

#made by juran