FROM hseeberger/scala-sbt:8u265_1.4.6_2.12.12
WORKDIR /run
RUN git clone https://github.com/CryptoBrokersGlobal/DataFeed.git
WORKDIR /run/DataFeed
RUN sbt assembly

FROM openjdk:8
RUN apt-get update && apt-get install wget 
WORKDIR /run/DataFeed
COPY --from=0 /run/DataFeed/target/scala-2.12/df-1.5.18.jar .
RUN wget https://raw.githubusercontent.com/CryptoBrokersGlobal/DataFeed/master/wdf.conf

EXPOSE 6990/tcp
EXPOSE 6991/tcp

CMD ["java", "-jar", "df-1.5.18.jar", "wdf.conf"]