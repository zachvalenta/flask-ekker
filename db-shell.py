#!/usr/bin/env python

print("\n 🔌 seed db... 🔌\n")

from application import db
from models import User

db.create_all()

seed_users = [User(username='alice'), User(username='bob')]
db.session.bulk_save_objects(seed_users)
db.session.commit()
print('🧬  users --> {}'.format(User.query.all()))

print("\n 🔌 finished :) 🔌\n")
