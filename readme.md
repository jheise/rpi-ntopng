# rpi-ntopng

Run ntopng on a raspberry pi in docker

`docker run -d -p 3000:3000 --link nprobe:nprobe --link redis:redis jheise/rpi-ntopng`

ntopng requires a redis cache and nprobe
