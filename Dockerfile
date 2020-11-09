FROM nvidia/cuda:10.1-base-ubuntu18.04

ARG USERNAME

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN apt-get install -y git

RUN pip3 install -U pip
RUN pip3 install jupyter numpy matplotlib opencv-python pandas
RUN pip3 install -U scikit-learn
RUN pip3 install torch torchvision
RUN pip3 install tqdm

RUN useradd -m -s /bin/bash ${USERNAME}

USER ${USERNAME}

RUN jupyter notebook --generate-config
RUN { \
        echo "c.NotebookApp.ip = '0.0.0.0'";\
        echo "c.NotebookApp.open_browser = False"; \
    } >> /home/${USERNAME}/.jupyter/jupyter_notebook_config.py

EXPOSE 8888
