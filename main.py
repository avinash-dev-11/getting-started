#Maintained & Authored by Avinash Kumar<avinash.kumar@hashedin.com>
from flask import Flask, render_template
import tablib
import os

app = Flask (__name__)
dataset = tablib.Dataset()
with open(os.path.join(os.path.dirname(__file__),'./templates/projects.csv')) as f:
    dataset.csv = f.read()

@app.route("/")
def index():
    return dataset.html

@app.route('/iam')
def view_page():
    iamset = tablib.Dataset()
    with open(os.path.join(os.path.dirname(__file__),'./templates/projects_iam.csv')) as f:
        iamset.csv = f.read()
    return iamset.html

@app.route('/bucket')
def bucket_page():
    bucketset = tablib.Dataset()
    with open(os.path.join(os.path.dirname(__file__),'./templates/buckets_iam.csv')) as f:
        bucketset.csv = f.read()
    return bucketset.html

@app.route('/serviceaccount')
def service_page():
    serviceset = tablib.Dataset()
    with open(os.path.join(os.path.dirname(__file__),'./templates/serviceAccounts.csv')) as f:
        serviceset.csv = f.read()
    return serviceset.html

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    app.run(debug=True,host='0.0.0.0',port=port)
