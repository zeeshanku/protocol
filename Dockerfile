FROM ubuntu
LABEL maintainer="blodhi@korea.ac.kr"
LABEL description="learning the docker environment"


## --install packages --##
RUN apt-get update && apt-get install -y \
	wget \
	bowtie2 \
	tophat \
	git \
	build-essential\
	libncurses5-dev\
	zlib1g-dev\
	libbz2-dev\
	liblzma-dev\
	bzip2\
	unzip

ENV WORKPATH /usr/local/bin
WORKDIR $WORKPATH
## Install SRA Toolkit from http
RUN wget -nv --output-document sratoolkit.tar.gz http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz && \
	tar -vxzf sratoolkit.tar.gz
## add toolkit path to path variable
USER root
ENV PATH $WORKPATH/sratoolkit.2.8.2-1-ubuntu64/bin:$PATH



# hisat
RUN wget -nv ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.1.0-Linux_x86_64.zip && \
	unzip hisat2-2.1.0-Linux_x86_64.zip
ENV PATH $WORKPATH/hisat2-2.1.0:$PATH

# cufflinks (links merge diff compare) binaries
RUN wget -nv --output-document cufflinks-2.2.1.Linux_x86_64 http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz && \
	tar -vxzf cufflinks-2.2.1.Linux_x86_64
ENV PATH $WORKPATH/cufflinks-2.2.1.Linux_x86_64:$PATH

## Samtools 1.6##
ENV SAMVERSION 1.6
RUN wget -nv https://github.com/samtools/samtools/releases/download/1.6/samtools-${SAMVERSION}.tar.bz2
RUN bzip2 -d  samtools-${SAMVERSION}.tar.bz2 && \
	tar -xvf samtools-${SAMVERSION}.tar && \
	cd samtools-${SAMVERSION} && \
	apt-get install -y libcurl4-openssl-dev && \
	./configure && \
	make install

##cleanup the image
RUN rm -rf sratoolkit.tar.gz && \
	rm -rf hisat2-2.1.0-Linux_x86_64.zip \
	rm -rf cufflinks-2.2.1.Linux_x86_64.tar.gz \
	rm -rf samtools-${SAMVERSION}.tar.bz2 \
	apt-get clean



#ENV SHELL /bin/bash



# create an app user
#ENV HOME /home/user
#RUN useradd --create-home --home-dir $HOME user \
#    && chmod -R u+rwx $HOME \
#    && chown -R user:user $HOME

#WORKDIR $HOME
#USER user