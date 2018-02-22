# Angular running on Nginx - as non root! 

Simple angular project served using Nginx

## Docker usuage

Build project

`docker build -t dis-app .`

Run project

`docker run -i -t -p 8080:80 dis-app`  -> ctrl+c to exit 