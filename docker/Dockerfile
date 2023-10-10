FROM python:3

RUN apt-get install python3 -y

# Set the working directory to /app 
WORKDIR /app

# Copy the current directory contents into the container at /app 
COPY . /app

# Skopiuj plik requirements.txt do katalogu roboczego w kontenerze 
COPY requirements.txt .

# install requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# create db dir
CMD mkdir /app/db

# Skopiuj plik run.sh do kontenera 
COPY run.sh . 

# Nadaj uprawnienia do pliku run.sh 
RUN chmod +x run.sh 

# Ustaw komendę, która zostanie uruchomiona po starcie kontenera 
CMD ["./run.sh"]
