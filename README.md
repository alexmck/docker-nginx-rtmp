## About

This is a simple Docker container that will install and run `nginx` with `sergey-dryabzhinsky/nginx-rtmp-module`. The included `nginx.conf` will convert the video to HLS and is available on port 8080. An RTMP stream can be sent to the server on the default port of 1935.

## How to use

To run this Docker container, please use the following commands:

```sh
docker build -t nginx-rtmp .
docker run -p 1935:1935 -p 8080:8080 -v $(pwd)/recordings:/mnt/recordings -v $(pwd)/hls:/mnt/hls nginx-rtmp
```

## How to stream

To stream to this docker container, you can use the following details:

**Server:** `rtmp://127.0.0.1/live`
**Stream Key:** `PickAnyStreamKey`

Or combined, `rtmp://127.0.0.1/live/PickAnyStreamKey`

## Recordings

Once you have finished streaming, the recorded FLV file will be in the `recordings` folder, and all `.ts` video segments and the playlist file will be in the `hls` folder.