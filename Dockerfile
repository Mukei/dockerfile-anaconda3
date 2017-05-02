#
# Anaconda3-4.3.1
# kunitaya/anaconda3
#
# 2017-05-01
#   CentOS Linux 7.3.1611
#   Python 3.6.0
#   Anaconda3 4.3.1

FROM kunitaya/centos.jp
MAINTAINER kunitaya

# update yum
RUN yum makecache fast && \
    yum update -y

# install Prerequisite package
RUN yum -y install git bzip2 && \
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
RUN eval "$(pyenv init -)"

# install Anaconda3
RUN pyenv install anaconda3-4.3.1 && \
    pyenv rehash && \
    pyenv global anaconda3-4.3.1 && \
    echo 'export PATH="$PYENV_ROOT/versions/anaconda3-4.3.1/bin/:$PATH"' >> ~/.bashrc
ENV PATH $PYENV_ROOT/versions/anaconda3-4.3.1/bin/:$PATH

# update Conda
RUN yes | conda update conda

# install Python3.5
#RUN conda install python=3.5

# install Chainer
RUN pip install chainer

# install Tensorflow
RUN pip install tensorflow

# install Keras
RUN pip install keras

# clear
RUN yum clean all

CMD ["python"]
