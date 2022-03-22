FROM rapidsai/rapidsai-core-dev:21.12-cuda11.5-devel-ubuntu20.04-py3.8

RUN mkdir -p /opt/meta-json-parser

WORKDIR /opt/meta-json-parser

COPY third_parties third_parties/
COPY benchmark benchmark/
COPY test test/
COPY include include/
COPY CMakeLists.txt CMakeLists.txt

RUN mkdir build
WORKDIR build

RUN /opt/conda/envs/rapids/bin/cmake -DUSE_LIBCUDF=1 -DLOCAL_LIB=1 ..
RUN mv /opt/conda/envs/rapids/include/boost/mp11 /opt/conda/envs/rapids/include/boost/mp11_do_not_use
RUN make -j8
