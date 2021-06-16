.PHONY: clean all kumato-init cuda java-se

cuda_version = 10.2.89
cudnn_version = 7.6.5.32
java_se_version = 14

current_dir = $(shell pwd)

all: clean kumato-init cuda java-se

cuda: cuda-base cuda-runtime cudnn-runtime


cuda-base:
	cp $(current_dir)/kumato-init/kumato-init $(current_dir)/cuda-base:$(cuda_version)/
	chmod +x $(current_dir)/cuda-base:$(cuda_version)/kumato-init
	bash -c "cd $(current_dir)/cuda-base:$(cuda_version) && docker build -t cuda-base:$(cuda_version) ."

cuda-runtime:
	cp $(current_dir)/kumato-init/kumato-init $(current_dir)/cuda-runtime:$(cuda_version)/
	chmod +x $(current_dir)/cuda-runtime:$(cuda_version)/kumato-init
	bash -c "cd $(current_dir)/cuda-runtime:$(cuda_version) && docker build -t cuda-runtime:$(cuda_version) ."

cudnn-runtime:
	cp $(current_dir)/kumato-init/kumato-init $(current_dir)/cudnn-runtime:$(cudnn_version)/
	chmod +x $(current_dir)/cudnn-runtime:$(cudnn_version)/kumato-init
	bash -c "cd $(current_dir)/cudnn-runtime:$(cudnn_version) && docker build -t cudnn-runtime:$(cudnn_version) ."

java-se:
	bash -c "cd $(current_dir)/java-se:$(java_se_version) && docker build -t java-se:$(java_se_version) ."

kumato-init:
	bash -c "cd $(current_dir)/kumato-init && docker build -t kumato-init:latest ."

save:
	docker save cuda-base:$(cuda_version) \
				cuda-runtime:$(cuda_version) \
				cudnn-runtime:$(cudnn_version) \
				java-se:$(java_se_version) \
				-o /tmp/archive.tar.gz

clean:
	-rm -f $(current_dir)/cuda-base:$(cuda_version)/kumato-init
	-rm -f $(current_dir)/cuda-runtime:$(cuda_version)/kumato-init
	-rm -f $(current_dir)/cudnn-runtime:$(cudnn_version)/kumato-init
	-docker rmi cuda-base:$(cuda_version) \
				cuda-runtime:$(cuda_version) \
				cudnn-runtime:$(cudnn_version) \
				java-se:$(java_se_version) \
				kumato-init:latest

