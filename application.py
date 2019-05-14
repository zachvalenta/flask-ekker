from flask import Flask, render_template

app = Flask(__name__)


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
        "index.html", title="index", paragraph=["sentence one", "sentence two"]
    )


@app.route("/add")
def add():
    return render_template("add.html")
