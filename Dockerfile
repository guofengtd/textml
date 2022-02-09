# FROM nvidia/cuda:11.4.3-base-centos8
FROM nvidia/cuda:11.2.0-devel-ubuntu18.04

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/compat

RUN apt update -y && apt install -y python3.8

RUN apt-get install -y python3-venv

# 创建 venv
RUN python3.8 -m venv /venv
RUN /venv/bin/pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/

# 升级 pip
RUN /venv/bin/pip install --upgrade pip

RUN mkdir /app

ADD aclImdb_v1.tar.gz /app

# 删除不用的
RUN rm -rf /app/aclImdb/train/unsup

ADD requirements.txt /app
ADD logging.conf /app

# 安装依赖
RUN /venv/bin/pip install -r /app/requirements.txt

ADD main.py /app

WORKDIR /app

CMD [ "/venv/bin/python", "main.py" ]
