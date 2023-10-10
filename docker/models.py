from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

#this is our database model
class Word2Number(db.Model):
    __tablename__ = 'word2numbers'

    id = db.Column(db.Integer, primary_key = True)
    encoded = db.Column(db.String(2000))
    path = db.Column(db.String(4000))

    def __init__(self, encoded, path):
      self.encoded = encoded
      self.path = path

    def __repr__(self):
      return '<result {}>'.format(self.encoded)
