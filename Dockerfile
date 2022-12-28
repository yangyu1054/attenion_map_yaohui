FROM nvidia/cuda:11.4.0-base-ubuntu20.04

RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y curl
RUN apt-get -y install unzip libsndfile1
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get -y install python3-tk 
RUN apt-get -y install sox 
RUN apt-get -y install libgl1-mesa-glx

RUN pip3 install numpy==1.21
RUN pip3 install flask torchsummary
RUN pip3 install librosa opencv-python matplotlib scikit-image jupyter pandas
RUN pip3 install PyYAML
RUN pip3 install torch 
RUN pip3 install torchvision 
RUN pip3 install transformers

RUN pip3 install opencv-python 
RUN mkdir /app
WORKDIR /app

EXPOSE 5000

RUN apt-get update && apt-get install -y libglib2.0-0
RUN pip3 install flask
RUN pip3 install waitress

COPY setup.py setup.py
COPY requirements.txt requirements.txt
RUN pip3 install .
# COPY . .
WORKDIR /app/src
CMD ["python3", "app.py"]


