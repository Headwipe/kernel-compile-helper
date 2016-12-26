#!/bin/bash
echo -e "\033[32mSystem updates und Tools werden jetzt installiert!\033[0m"

sleep 1

apt-get update && apt-get upgrade
wait
apt-get install -y htop kernel-package libncurses-dev wget bzip2 make build-essential dialog

cmd=(dialog --keep-tite --menu "Select options:" 22 76 16)

options=(1 "v3.0"
         2 "v4.x"
		 3 "latest stable"
		 4 "latest mainline")

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

for choice in $choices
do
    case $choice in
        1)
			dialog --inputbox "Enter Version Number" 10 60 2>/tmp/gk-v.tmp
			input1="$(cat /tmp/gk-v.tmp)"
			wget https://www.kernel.org/pub/linux/kernel/v3.x/linux-$input1.tar.xz
            tar xvf linux-$input1.tar.xz
			cd linux-$input1
			echo -e "\033[32mKernel wird konfiguriert!\033[0m"
			
			sleep 1
			
			make localyesconfig
			make menuconfig
			
			cmd2=(dialog --keep-tite --menu "Select Options:" 22 76 16)
			
			options2=(1 "1000Hz LLD (Low-Latency Desktop)"
					  2 "100Hz FPD (Forced P. Desktop)")
					  
			choices2=$("${cmd2[@]}" "${options2[@]}" 2>&1 >/dev/tty)
			
			for choice2 in $choices2
			do
				case $choice2 in
					1)
						echo -e "\033[32mCompiling Kernel!\033[0m"
						make-kpkg clean && make-kpkg -j4 --append-to-version -gk-1k-lld --initrd kernel_image kernel_headers
						
						rm-r linux-$input1*
						rm /tmp/gk-v.tmp
						
						dialog --title "Message" --msgbox "Compile complete!!" 8 30
						
						clear
						break
						;;
					2)
						echo -e "\033[32mCompiling Kernel!\033[0m"
						make-kpkg clean && make-kpkg -j4 --append-to-version -gk-100-FPD --initrd kernel_image kernel_headers
						
						rm-r linux-$input1*
						rm /tmp/gk-v.tmp
						
						dialog --title "Message" --msgbox "Compile complete!!" 8 30
						
						clear
						break
						;;
				esac
			done			
			;;
        2)
            dialog --inputbox "Enter Version Number" 10 60 2>/tmp/gk-v.tmp
			input1="$(cat /tmp/gk-v.tmp)"
			wget https://www.kernel.org/pub/linux/kernel/v4.x/linux-$input1.tar.xz
            tar xvf linux-$input1.tar.xz
			cd linux-$input1
			echo -e "\033[32mconfiguring Kernel!\033[0m"
			
			sleep 1
			
			make localyesconfig
			make menuconfig
			
			cmd3=(dialog --keep-tite --menu "Select Options:" 22 76 16)
			
			options2=(1 "1000Hz LLD (Low-Latency Desktop)"
					  2 "100Hz FPD (Forced P. Desktop)")
					  
			choices3=$("${cmd3[@]}" "${options3[@]}" 2>&1 >/dev/tty)
			
			for choice3 in $choices3
			do
				case $choice3 in
					1)
						echo -e "\033[32mcompiling Kernel!\033[0m"
						make-kpkg clean && make-kpkg -j4 --append-to-version -gk-1k-lld --initrd kernel_image kernel_headers
						
						rm-r linux-$input1*
						rm /tmp/gk-v.tmp
						
						dialog --title "Message" --msgbox "Compile complete!!" 8 30
						
						clear
						break
						;;
					2)
						echo -e "\033[32mcompiling Kernel!\033[0m"
						make-kpkg clean && make-kpkg -j4 --append-to-version -gk-100-FPD --initrd kernel_image kernel_headers
						
						rm-r linux-$input1*
						rm /tmp/gk-v.tmp
						
						dialog --title "Message" --msgbox "Compile complete!!" 8 30
						
						clear
						break
						;;
				esac
			done			
			;;
		3)
			curl -s -k https://www.kernel.org/feeds/kdist.xml | sed -n -e 's@.*<guid>\(.*\)</guid>.*@\1@p' | grep 'stable' | head -1 | awk -F , '{print $3}'>/tmp/gk-v.tmp
			input1="$(cat /tmp/gk-v.tmp)"
			wget https://www.kernel.org/pub/linux/kernel/v4.x/linux-$input1.tar.xz
            tar xvf linux-$input1.tar.xz
			cd linux-$input1
			echo -e "\033[32mcompiling Kernel!\033[0m"
			
			sleep 1
			
			make localyesconfig
			make menuconfig
			
			cmd2=(dialog --keep-tite --menu "Select Options:" 22 76 16)
			
			options2=(1 "1000Hz LLD (Low-Latency Desktop)"
					  2 "100Hz FPD (Forced P. Desktop)")
					  
			choices2=$("${cmd2[@]}" "${options2[@]}" 2>&1 >/dev/tty)
			
			for choice2 in $choices2
			do
				case $choice2 in
					1)
						echo -e "\033[32mcompiling Kernel!\033[0m"
						make-kpkg clean && make-kpkg -j4 --append-to-version -gk-1k-lld --initrd kernel_image kernel_headers
						
						rm-r linux-$input1*
						rm /tmp/gk-v.tmp
						
						dialog --title "Message" --msgbox "Compile complete!!" 8 30
						
						clear
						break
						;;
					2)
						echo -e "\033[32mcompiling Kernel!\033[0m"
						make-kpkg clean && make-kpkg -j4 --append-to-version -gk-100-FPD --initrd kernel_image kernel_headers
						
						rm-r linux-$input1*
						rm /tmp/gk-v.tmp
						
						dialog --title "Message" --msgbox "Compile complete!!" 8 30
						
						clear
						break
						;;
				esac
			done			
			;;
		4)
			curl -s -k https://www.kernel.org/feeds/kdist.xml | sed -n -e 's@.*<guid>\(.*\)</guid>.*@\1@p' | grep 'mainline' | head -1 | awk -F , '{print $3}'>/tmp/gk-v.tmp
			input1="$(cat /tmp/gk-v.tmp)"
			wget https://www.kernel.org/pub/linux/kernel/v4.x/testing/linux-$input1.tar.xz
            tar xvf linux-$input1.tar.xz
			cd linux-$input1
						echo -e "\033[32mcompiling Kernel!\033[0m"
			
			sleep 1
			
			make localyesconfig
			make menuconfig
			
			cmd2=(dialog --keep-tite --menu "Select Options:" 22 76 16)
			
			options2=(1 "1000Hz LLD (Low-Latency Desktop)"
					  2 "100Hz FPD (Forced P. Desktop)")
					  
			choices2=$("${cmd2[@]}" "${options2[@]}" 2>&1 >/dev/tty)
			
			for choice2 in $choices2
			do
				case $choice2 in
					1)
						echo -e "\033[32mcompiling Kernel!\033[0m"
						make-kpkg clean && make-kpkg -j4 --append-to-version -gk-1k-lld --initrd kernel_image kernel_headers
						
						rm-r linux-$input1*
						rm /tmp/gk-v.tmp
						
						dialog --title "Message" --msgbox "Compile complete!!" 8 30
						
						clear
						break
						;;
					2)
						echo -e "\033[32mcompiling Kernel!\033[0m"
						make-kpkg clean && make-kpkg -j4 --append-to-version -gk-100-FPD --initrd kernel_image kernel_headers
						
						rm-r linux-$input1*
						rm /tmp/gk-v.tmp
						
						dialog --title "Message" --msgbox "Compile complete!!" 8 30
						
						clear
						break
						;;
				esac
			done			
			;;
	esac
done
