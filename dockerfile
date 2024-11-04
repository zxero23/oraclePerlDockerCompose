FROM ubuntu:22.04


ENV ORACLE_HOME=/opt/oracle/instantclient_23_4
ENV LD_LIBRARY_PATH=$ORACLE_HOME:$LD_LIBRARY_PATH
ENV C_INCLUDE_PATH=$ORACLE_HOME:$C_INCLUDE_PATH
ENV PATH=$ORACLE_HOME:$PATH

ENV STEALTH_USR="stl"
ENV STEALTH_PWD="stl"
ENV TWO_TASK="ARDPROD.WORLD"
ENV ORACLE_SID="ARDPROD"

ENV TNS_ADMIN=/etc/oracle
RUN apt update -y && \
    apt upgrade -y && \
    apt install -y curl \
    libaio1 \
    unzip
	
RUN apt install -y libdbi-perl 

RUN apt install -y build-essential
RUN apt install -y libdbi-perl 


RUN mkdir -p /opt/oracle


WORKDIR /opt/oracle
RUN curl -o oracleclient.zip https://download.oracle.com/otn_software/linux/instantclient/2340000/instantclient-basic-linux.x64-23.4.0.24.05.zip 
RUN    curl -o sqlplus.zip https://download.oracle.com/otn_software/linux/instantclient/2340000/instantclient-sqlplus-linux.x64-23.4.0.24.05.zip 
RUN    curl -o oracletools.zip https://download.oracle.com/otn_software/linux/instantclient/2340000/instantclient-tools-linux.x64-23.4.0.24.05.zip 
RUN    curl -o sdk.zip https://download.oracle.com/otn_software/linux/instantclient/2340000/instantclient-sdk-linux.x64-23.4.0.24.05.zip
RUN unzip  oracleclient.zip 
RUN unzip -o oracletools.zip 
RUN unzip  -o sqlplus.zip
RUN unzip -o sdk.zip

RUN sh -c "echo /opt/oracle/instantclient_23_4 > \
    /etc/ld.so.conf.d/oracle-instantclient.conf" && \
    ldconfig
	

# Instala DBD::Oracle usando cpanm
RUN apt install -y cpanminus 
RUN cpanm DBI 
RUN cpanm  DBD::Oracle 
RUN cpanm MIME::Lite