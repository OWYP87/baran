from flask import Flask, request, jsonify, abort
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from flask_migrate import Migrate
from utils import RepresentsInt
from models import db, Word2Number
# import db config.py
from config import Config

import logging
import string
import re
import os

#initliazing our flask app, SQLAlchemy and Marshmallow
app = Flask(__name__)

app.config.from_object(Config)

app.logger.setLevel(logging.ERROR)

#db = SQLAlchemy(app)
ma = Marshmallow(app)
db.init_app(app)

migrate = Migrate(app, db)

@app.errorhandler(404)
def page_not_found(e):
  return jsonify(error=str(e)), 404

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def catch_all(path):
    
    # removes all special characters and converts them to lower case
    word = str(''.join(x for x in path if x.isalnum())).lower()
    # encode
    encoded = []
    encoded_str = ""
    for character in word:
      
      number = int(character) if RepresentsInt(character) else ord(character) - 96 
      encoded.append(number)
      encoded_str = ''.join(str(e) for e in encoded)
    if encoded_str == "":
      abort(404, description="Resource not found")
    else:
      my_word = Word2Number(encoded_str, path)
      db.session.add(my_word)
      db.session.commit()

      return jsonify(
        result=encoded_str
      )

@app.route('/ready')
def get_ready():
  return jsonify(
    status='ok'
    )

@app.route('/version')
def get_version():
    try:
        with open('version.txt', 'r') as file:
            version = file.read().strip()
        return jsonify(version=str(version))
    except FileNotFoundError:
        return jsonify(error="Version file not found"), 404



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
