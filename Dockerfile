FROM ubuntu
LABEL maintainer="blodhi@korea.ac.kr"
LABEL description="learning the docker environment"


## --install packages --##
RUN apt-get update && apt-get install -y \
	wget \
	bowtie2 \
	tophat \
	git \
	unzip

ENV WORKPATH /usr/local/bin
WORKDIR $WORKPATH
## Install SRA Toolkit from http
RUN wget -nv --output-document sratoolkit.tar.gz http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz && \
	tar -vxzf sratoolkit.tar.gz
## add toolkit path to path variable
ENV PATH=$WORKPATH/sratoolkit.2.8.2-1-ubuntu64/bin



# hisat
#RUN wget -nv ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.1.0-Linux_x86_64.zip && \
#	unzip hisat2-2.1.0-Linux_x86_64.zip
#ENV PATH="$PATH:$WORKPATH/hisat2-2.1.0/"

##cleanup the image
#RUN rm -rf sratoolkit.tar.gz && \
#	rm -rf hisat2-2.1.0-Linux_x86_64.zip \
#	apt-get clean


# create an app user
#ENV HOME /home/user
#RUN useradd --create-home --home-dir $HOME user \
#    && chmod -R u+rwx $HOME \
#    && chown -R user:user $HOME

#WORKDIR $HOME
#USER user