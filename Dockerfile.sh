# sudo docker build -t shimwell:nuclear_xs_viewer .

sudo docker build --build-arg webhostip=http://35.225.255.223:8080  -t shimwell:nuclear_xs_viewer .

sudo docker run -p 80:80 shimwell:nuclear_xs_viewer
