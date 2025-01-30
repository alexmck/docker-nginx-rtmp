## About

This is a simple Docker container that will install and run `nginx` with `sergey-dryabzhinsky/nginx-rtmp-module`. The included `nginx.conf` will convert the video to HLS and is available on port 8080. An RTMP stream can be sent to the server on the default port of 1935.

A seperate simple Node server is also used to simulate authenticating a stream, including a simulated delay with the authentication.

## Requirements

Please ensure you are have the following installed on your machine:

* Docker Desktop (https://www.docker.com/products/docker-desktop/)
* Node.js (https://nodejs.org)

## How to use

To run this Docker container, please use the following commands:

```sh
docker build -t nginx-rtmp .
docker run -p 1935:1935 -p 8080:8080 -v $(pwd)/recordings:/mnt/recordings -v $(pwd)/recordings:/mnt/recordings-delay -v $(pwd)/hls:/mnt/hls -v $(pwd)/hls:/mnt/hls-delay -v $(pwd)/www:/mnt/www nginx-rtmp
```

Also start the local server in a new terminal window which is used to "authenticate" the stream. In this particular case, we use this to add an artificial delay to starting a stream.

```sh
node server.js
```

## How to stream

To stream to this docker container, you can use the following details:

**Server:** `rtmp://127.0.0.1/live`
**Stream Key:** `PickAnyStreamKey`

Or combined, `rtmp://127.0.0.1/live/PickAnyStreamKey`

### Stream with a simulated delay authenticating at the start

To stream with a simulated delay of 2000 ms before the `NetStream.Connect.Success` event is received, use the following details:

**Server:** `rtmp://127.0.0.1/delay`
**Stream Key:** `PickAnyStreamKey`

Or combined, `rtmp://127.0.0.1/delay/PickAnyStreamKey`

### Streaming with an iPhone

If you are streaming with an iPhone you will need to replace 127.0.0.1 with the IP of your local machine that is running the Docker container.

## Recordings

Once you have finished streaming, the recorded FLV file will be in the `recordings` folder, and all `.ts` video segments and the playlist file will be in the `hls` folder.

## Watching Live

To watch the stream live, point your browser to `http://localhost:8080/www/?key=$StreamKey`. Make sure you replace `$StreamKey` with which ever stream key you have selected. This will allow you to watch the stream in real time.