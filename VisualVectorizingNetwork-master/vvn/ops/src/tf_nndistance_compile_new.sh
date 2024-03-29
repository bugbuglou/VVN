#!/bin/bash

TF_CFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))') )
TF_LFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))') )

/usr/local/cuda-10.0/bin/nvcc tf_nndistance_g.cu -D_GLIBCXX_USE_CXX11_ABI=0 -std=c++11 -c -o tf_nndistance_g.cu.o ${TF_CFLAGS[@]} -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC -O2

g++ -std=c++11 tf_nndistance.cpp tf_nndistance_g.cu.o -o tf_nndistance_so.so -shared -fPIC -lcudart -L/usr/local/cuda-10.0/lib64/ ${TF_CFLAGS[@]} ${TF_LFLAGS[@]} -O2
