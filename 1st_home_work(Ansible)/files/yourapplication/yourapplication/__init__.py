from flask import Flask, request
from flask import render_template
import emoji

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def hello_world():
    if request.method == 'POST':
        anim = request.get_json(force=True)
        if anim:
            animal = anim['animal']
            sound = anim['sound']
            count = anim['count']
            ans = ""
            for i in range(count):
                ans += "{} says {}\n".format(animal, sound)
            animal = ':{}:'.format(anim['animal'])
            if animal == emoji.emojize(animal):
                animal = '{}'.format(anim['animal'])
                ans += 'Made with {} by Marsel\n'.format(animal)
                return emoji.emojize(ans)
            else:
                ans += 'Made with {} by Marsel\n'.format(animal)
                return emoji.emojize(ans)
    else:
        answ = '''<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<title>webapp</title>
<h1>This is a flask web servise.</h1>
<h3>The service handls GET and POST requests.</h3>

<p>In GEST request it shows this page</p>
<p>In POST request it recieves the json object and returns string, which is the result of processing json object.<br>
    To check this, type the following command in the command line:<br>
    <code>curl -XPOST -d'{"animal":"cow", "sound":"moooo", "count": 3}' http://myvm.localhost/</code></p>
<p>This service is made on Flack and runs on a Debian virtual machine and on Apache web server.<br>
    Also the service has an emoji support. Why on Earth would we create stuff that does not support emoji?!:smiling_face_with_sunglasses:


'''
        return emoji.emojize(answ)

if __name__ == '__main__':
    # run app in debug mode on port 5000
    app.run()
