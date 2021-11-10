#!/usr/bin/env bash
GREENFG="\e[38;5;82m"
REDWEAKFG="\e[38;5;132m"
BBLUEFG="\e[1;38;5;75m"
GBLUEFG="\e[1;38;5;73m"
FOLDERNAMEFG="\e[1;38;5;45m"
ERRORFG="\e[1;38;5;197m"
RESET="\e[0m"
BOLD="\e[1m"
machine=$(uname -o)
if [ "$machine" = "Android" ]; then
echo -e "${ERRORFG}Unfortunately, Termux is not supported. ${BBLUEFG}Operating system detected as ${machine} ${RESET}"
else
if [[ -d ~/NewOSv3 ]];
then
    echo "NewOS is already installed. Do you want to uninstall it? (y/*)" 
    read -r yesorno
    if [ "$yesorno" = "y" ]; then
    rm -rf ~/NewOSv3
    echo "Uninstalled."
    exit 0
    else
    exit 0
    fi
else

echo -e "${GREENFG}Welcome to the NewOS V3 installer!"
sleep 1
echo -e "${BBLUEFG}Please enter your name."
read -r name
touch ./.name
echo "${name}" > ./.name
echo -e "${BBLUEFG}Please enter your password."
read -s password
echo -e "Verify Password"
read -s verify
touch ./.pass
echo "${verify}" > ./.pass

if [ "$verify" = "$password" ]; then
echo -e "${GREENFG}Password matches. Getting ready..."
sleep 3
echo -e "${BBLUEFG}Downloading NewOS..."
git clone --quiet https://github.com/joshilita/NewOSv3-os
echo "Moving NewOS to home folder"
mkdir ~/NewOSv3
mv NewOSv3-os/* ~/NewOSv3
mv NewOSv3-os/.git ~/NewOSv3
mv NewOSv3-os/.vers ~/NewOSv3
rm -rf NewOSv3-os
echo "Wait.."
sleep 1 
echo "Configuring User Data"
mv .name ~/NewOSv3/
mv .pass ~/NewOSv3/
echo "Finishing touches..."
sleep 5
touch ~/NewOSv3/startup
touch ~/NewOSv3/flogin
echo -e "${GREENFG}NewOS is now installed! Do you want to run it now? (y/*)"
read -r yesno
if [ "$yesno" = "y" ]; then
echo "Running..."
sleep 3
bash ~/NewOSv3/os.sh
exit 0
else
echo "Okay! Bye!"
exit 0
fi
else
echo "Password does not match. Restarting installer..."
sleep 2
bash installer.sh
exit 0
fi
fi
fi
