# Create a flask file
#pip install flask markdown
from flask import Flask, render_template
import os
import markdown

app = Flask(__name__)

# Define the routes home for the application
#@app.route('/')
#def home():
    # return render_template('index.html')


@app.route('/')
def home():
    posts = []
    for file in os.listdir('posts'):
        if file.endswith('.md'):
            title = file[:-3]
            posts.append(title)
    return render_template('index.html', posts=posts)

# Define route to handle request for individual blog
@app.route('/posts/<path:path>')
def post(path):
    with open(f'posts/{path}.md', 'r') as file:
        content = file.read()
        html = markdown.markdown(content)
        return render_template('post.html', content=html)
