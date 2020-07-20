FROM ubuntu:20.04

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata dirmngr gnupg2 && \
    rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources.list
RUN echo "deb http://packages.ros.org/ros2/ubuntu focal main" > /etc/apt/sources.list.d/ros2-latest.list

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# install bootstrap tools + workspace dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \
    \
    python3-importlib-metadata \
    python3-lark \
    libzstd-dev \
    libpyside2-dev \
    libshiboken2-dev \
    python3-pyside2.qtsvg \
    shiboken2 \
    libbenchmark-dev \
    python3-packaging \
    liburdfdom-headers-dev \
    libconsole-bridge-dev \
    libopencv-dev \
    python3-mock \
    libeigen3-dev \
    cppcheck \
    qtbase5-dev \
    qt5-qmake \
    pyqt5-dev \
    python3-pyqt5 \
    python3-pyqt5.qtsvg \
    python3-sip-dev \
    libqt5opengl5 \
    libtinyxml-dev \
    libxml2-utils \
    libassimp-dev \
    python3-mypy \
    python3-pytest-mock \
    libbullet-dev \
    uncrustify \
    pyflakes3 \
    libcunit1-dev \
    python3-psutil \
    pydocstyle \
    python3-netifaces \
    libyaml-dev \
    libspdlog-dev \
    python3-numpy \
    python3-pycodestyle \
    libcppunit-dev \
    libtinyxml2-dev \
    libcurl4-openssl-dev \
    curl \
    libfreetype6-dev \
    libx11-dev \
    libxaw7-dev \
    libxrandr-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    clang-tidy \
    clang-format \
    python3-babeltrace \
    python3-pydot \
    python3-pygraphviz \
    python3-matplotlib \
    python3-lttng \
    python3-ifcfg \
    python3-flake8 \
    libsqlite3-dev \
    liblog4cxx-dev \
    python3-lxml \
    python3-cryptography \
    libasio-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# setup colcon mixin and metadata
RUN colcon mixin add default \
      https://raw.githubusercontent.com/colcon/colcon-mixin-repository/1ddb69bedfd1f04c2f000e95452f7c24a4d6176b/index.yaml && \
    colcon mixin update && \
    colcon metadata add default \
      https://raw.githubusercontent.com/colcon/colcon-metadata-repository/6b81483901cbcc242029312725a21b650f6273a3/index.yaml && \
    colcon metadata update

# Clone workspace
RUN mkdir -p /benchmark_ros2_compile/src
WORKDIR /benchmark_ros2_compile
COPY ros2-2020_07_20.repos .
RUN vcs import --shallow --input ros2-2020_07_20.repos ./src

COPY benchmark.bash .
ENTRYPOINT ["./benchmark.bash"]
COPY build_workspace.bash .
CMD ["./build_workspace.bash"]
