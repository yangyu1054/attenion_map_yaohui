run_image:
	docker run -it --gpus all -e DISPLAY=$$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/yang/attention_map_deploy/attention_inference:/app -p 8080:8080 -p 5000:5000  vit

build_image:
	docker build -t vit .


ju:
	jupyter notebook --allow-root --ip=0.0.0.0 --port=8080


category:
	python3 pre_process.py --real=../data/real --machine=../data/machine --output_train=../data/train.txt --output_test=../data/test.txt --percentage=0.8
