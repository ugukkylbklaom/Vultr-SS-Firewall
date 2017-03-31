#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


install_path=/fs/
package_download_url=未定
package_save_name=finalspeed_server.zip
 
function checkjava(){
	java -version
	#echo $?
	if [[ $? -le 1 ]] ;then
		echo " Run java success"
	else
		echo " Run java failed"
		echo $OS
		if [[ $OS = "centos" ]]; then
			echo " Install  centos java ..."
			yum install -y java-1.8.0-openjdk
		fi
		if [[ $OS = "ubuntu" ]]; then
			echo " Install  ubuntu java ..."
			apt-get install -y openjdk-7-jre
		fi
		if [[ $OS = "debian" ]]; then
			echo " Install  debian java ..."
			apt-get install -y openjdk-7-jre
		fi
	fi
	# if [[ ! -d "$result" ]]; then
		# echo "不存在"
	# else
		# echo "存在"
	# fi
	echo $result
}


function checkunzip(){
	unzip
	#echo $?
	if [[ $? -le 1 ]] ;then
		echo " Run unzip success"
	else
		echo " Run unzip failed"
		echo $OS
		if [[ $OS = "ubuntu" ]]; then
			echo " Install  ubuntu unzip ..."
			apt-get -y install unzip
		fi
		if [[ $OS = "debian" ]]; then
			echo " Install  debian unzip ..."
			apt-get -y install unzip
		fi
		if [[ $OS = "centos" ]]; then
			echo " Install  centos unzip ..."
			yum install -y unzip
		fi
	fi
	# if [[ ! -d "$result" ]]; then
		# echo "不存在"
	# else
		# echo "存在"
	# fi
	echo $result
}

function checkwget(){
	wget
	#echo $?
	if [[ $? -le 1 ]] ;then
		echo " Run wget success"
	else
		echo " Run wget failed"
		echo $OS
		if [[ $OS = "ubuntu" ]]; then
			echo " Install  ubuntu wget ..."
			apt-get -y install wget
		fi
		if [[ $OS = "debian" ]]; then
			echo " Install  debian wget ..."
			apt-get -y install wget
		fi
		if [[ $OS = "centos" ]]; then
			echo " Install  centos wget ..."
			yum install -y wget
		fi
	fi
	echo $result
}


function checkenv(){
		if [[ $OS = "ubuntu" ]]; then
			apt-get update
			apt-get -y install libpcap-dev
			apt-get -y install iptables
		fi
		if [[ $OS = "debian" ]]; then
			echo "apt-get updateapt-get updateapt-get update"
			apt-get update
			apt-get -y install libpcap-dev
			apt-get -y install iptables
		fi
		if [[ $OS = "centos" ]]; then
			#yum update
			yum -y install libpcap
			yum -y install iptables
		fi
}



function checkos(){
    if [[ -f /etc/redhat-release ]];then
        OS=centos
    elif [[ ! -z "`cat /etc/issue | grep bian`" ]];then
        OS=debian
    elif [[ ! -z "`cat /etc/issue | grep Ubuntu`" ]];then
        OS=ubuntu
    else
        echo "Unsupported operating systems!"
        exit 1
    fi
	echo $OS
}

 
#  Install finalspeed
function install_finalspeed(){
	rm -f $package_save_name
	echo "Download software..."
	if ! wget -O $package_save_name $package_download_url ; then
		echo "Download software failed!"
		exit 1
	fi

	if [[ ! -d "$install_path" ]]; then
		mkdir "$install_path"
		else
		echo "Update Software..."
	fi
	
	unzip -o $package_save_name  -d $install_path
	
	sh ${install_path}"restart.sh"
	tail -f ${install_path}"server.log"
}


checkos
checkenv
checkwget
checkjava
checkunzip
install_finalspeed
