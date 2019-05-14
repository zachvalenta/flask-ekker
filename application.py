from flask import Flask, render_template

app = Flask(__name__)


@app.route("/")
def index():
    return render_template(
        "index.html", title="index", paragraph=["sentence one", "sentence two"]
    )


@app.route("/add")
def add():
    return render_template("add.html")
