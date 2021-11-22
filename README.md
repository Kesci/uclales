# UCLALES
原始项目地址[传送门](https://github.com/uclales/uclales)

## 修改原因
原项目停止维护，且文档不完善，编译安装使用困难

## 安装方法
在 ubuntu 20.04 LTS 版本中测试通过

## 命令

```shell
sudo apt-get install build-essential
sudo apt-get install libc6-dev
sudo apt-get install zlib1g-dev libssl-dev
sudo apt-get install gfortran
sudo apt-get install libnetcdf-dev libnetcdff-dev

wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.1.tar.gz
tar zxvf openmpi-4.1.1.tar.gz
cd openmpi-4.1.1
./configure --prefix=$HOME/.local/openmpi CC=gcc CXX=g++ FC=gfortran
make -j
make install
MPI_HOME=/usr/local/openmpi
export PATH=${MPI_HOME}/bin:$PATH
export LD_LIBRARY_PATH=${MPI_HOME}/lib:$LD_LIBRARY_PATH
export MANPATH=${MPI_HOME}/share/man:$MANPATH

git clone https://github.com/WidgetA/uclales.git
cd uclales/config && cp ubuntu.cmake default.cmake
cd ..
mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE ..
make -j

```