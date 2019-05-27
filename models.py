from datetime import datetime

from application import db


class Input(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    input = db.Column(db.String(80), unique=True, nullable=False)
    time = db.Column(db.DateTime, default=datetime.utcnow)

    def __repr__(self):
        return "id {} time {} input {}".format(self.id, self.input, self.time)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)

    def __repr__(self):
        return '{!r}'.format(self.username)
