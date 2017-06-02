#!/bin/bash
build_dir=build

pushd devtoolset-6
sh install
popd

pushd 3rdparty/gperftools-2.0
chmod 777 configure
./configure --enable-frame-pointers --enable-static=yes  --enable-shared=no
popd

pushd 3rdparty/gperftools-2.0
make
popd

pushd 3rdparty/gperftools-2.0
make install
popd


if [ -f /opt/rh/devtoolset-6/enable ]; then
	. /opt/rh/devtoolset-6/enable
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

popd
