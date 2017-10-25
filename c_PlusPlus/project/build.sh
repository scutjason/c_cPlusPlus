#!/bin/bash
build_dir=build

pushd tools
sh install
popd

pushd 3rdparty/gperftools-2.0
chmod 777 configure
./configure --enable-frame-pointers --enable-static=yes  --enable-shared=no --prefix=/home
make
make install
popd

if [ -f /opt/rh/tools/enable ]; then
	. /opt/rh/tools/enable
fi

if [ -e "$build_dir" ]; then
	rm -rf $build_dir
fi

mkdir $build_dir
pushd $build_dir

cmake -DPOCO_STATIC=ON -DENABLE_XML=OFF -DENABLE_MONGODB=OFF -DENABLE_PDF=OFF -DENABLE_NETSSL=OFF -DENABLE_CRYPTO=OFF \
      -DENABLE_DATA=OFF -DENABLE_DATA_SQLITE=OFF -DENABLE_DATA_MYSQL=OFF -DENABLE_ZIP=OFF -DENABLE_PAGECOMPILER=OFF \
      -DENABLE_PAGECOMPILER_FILE2PAGE=OFF -DBUILD_SHARED_LIBS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF ..

make -j`cat /proc/cpuinfo | grep processor | wc -l`

archive_dir=target
mkdir -p $archive_dir/project/etc
mkdir -p $archive_dir/project/log

cp bin/project $archive_dir/

cp ../etc/project.ini $archive_dir/project/etc/

pushd $archive_dir
tar zcf project.tar project/

echo project is build and archived in file $PWD/project.tar
popd
popd
