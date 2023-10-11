FROM python:3

RUN apt-get install python3 -y

# Set the working directory to /app 
WORKDIR /app

# Copy the current directory contents into the container at /app 
COPY . /app

# copy requirements.txt to workdir 
COPY docker/requirements.txt .

# install requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# create db dir
CMD mkdir /app/db

# copy run.sh to image 
COPY docker/run.sh . 

# grant permissions run.sh 
RUN chmod +x run.sh 

# after completed work, run 
CMD ["./run.sh"]
