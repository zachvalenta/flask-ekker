from datetime import datetime
import os

from dotenv import find_dotenv, load_dotenv
from flask import Flask, render_template, request, redirect, url_for, flash
from loguru import logger

app = Flask(__name__)
load_dotenv(find_dotenv())
app.config["SECRET_KEY"] = os.getenv("SECRET_KEY").encode()
bookmarks = []


def store_bookmark(input):
    bookmarks.append(dict(input=input, user="zjv", date=datetime.utcnow()))


def get_bookmarks_by(sort_key):
    return sorted(bookmarks, key=lambda bm: bm[sort_key])


@app.errorhandler(404)
def not_found(e):
    return (
        render_template("404.html"),
        404,
    )  # need to incl status code here otherwise will return 200


@app.route("/")
@app.route("/index")
def index():
    return render_template(
        "index.html",
        title="index",
        paragraph=["sentence one", "sentence two"],
        marks=get_bookmarks_by("date"),
    )


@app.route("/add", methods=["GET", "POST"])
def add():
    if request.method == "POST":
        form_input = request.form["dummy_form"]
        logger.debug("form input -> {}".format(form_input))
        flash(form_input)  # store flash in session obj
        store_bookmark(form_input)
        return redirect(url_for("index"))
    return render_template("add.html")
