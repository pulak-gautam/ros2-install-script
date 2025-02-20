#/bin/bash -xve

sudo apt update && sudo apt install curl
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update -y
sudo apt upgrade -y

sudo apt install -y ros-humble-ros-base python3-colcon-common-extensions python3-rosdep2

sudo apt-get install -y lsb-release wget gnupg
sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null && \
    sudo apt-get update -y && \
    sudo apt-get install gz-garden -y
sudo apt-get install ros-humble-ros-gzgarden -y

echo -e "\n## Execute ${BASH_SOURCE[0]} $(date +'%Y/%m/%d %H:%M:%S')"  >> ~/.bashrc

grep "source /opt/ros/humble/setup.bash" ~/.bashrc
if [ $? = 0 ]; then
  :
else
  echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
fi

grep "export ROS_DOMAIN_ID" ~/.bashrc
if [ $? = 0 ]; then
  :
else
  echo "export ROS_DOMAIN_ID=1" >> ~/.bashrc
fi

grep "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" ~/.bashrc
if [ $? = 0 ]; then
  :
else
  echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc
fi

grep "export _colcon_cd_root=" ~/.bashrc
if [ $? = 0 ]; then
  :
else
  echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
  echo "export _colcon_cd_root=~" >> ~/.bashrc
fi
