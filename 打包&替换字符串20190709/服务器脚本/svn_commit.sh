#!/bin/bash
echo "==============svn commit pravite==================="
s1="src/interface"
s2="src/world_scripts"
i1="include/interface"
i2="include/scripts"
sc="scripts_xml"

echo "start commit code..."
if svn ci ./$1/$s1/$2/*.cpp -m "$3"
then 
    echo -e \\033[34m $1/$s1/$2/*.cpp提交成功！ \\033[0m 
fi

if svn ci ./$1/$s2/$2/*.cpp -m "$3"
then 
    echo -e \\033[34m $1/$s2/$2/*.cpp提交成功！ \\033[0m 
fi

if svn ci ./$1/$i1/$2/*.cpp -m "$3"
then 
    echo -e \\033[34m $1/$i1/$2/*.h提交成功！ \\033[0m 
fi

if svn ci ./$1/$i2/$2/*.cpp -m "$3"
then 
    echo -e \\033[34m $1/$i2/$2/*.h提交成功！ \\033[0m 
fi

if svn ci ./$1/$sc/$2/*.cpp -m "$3"
then 
    echo -e \\033[34m $1/$sc/$2/*.xml提交成功！ \\033[0m 
fi


                                    #made by juran