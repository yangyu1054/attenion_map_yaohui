from flask import Flask, render_template, request, redirect, url_for
import subprocess
import os
import time

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

app.config['UPLOAD_FOLDER'] = './static/img/upload'

@app.route('/add-data', methods=['GET', 'POST'])
def add_data():
    if request.method == 'GET':
        return render_template('addData.html')
    
    if request.method == 'POST':
        print(request.files)
        _file = request.files['file']
        path = os.path.join(app.config['UPLOAD_FOLDER'], 'input.jpg')
        _file.save(path)
    return redirect(url_for('index'))


@app.route('/predict', methods=['GET', 'POST'])
def predict():
    checkpoint = 'checkpoint1/checkpoint.pth'
    src = os.path.join(app.config['UPLOAD_FOLDER'], 'input.jpg')
    output_dir = 'static/img/output_dir'
    layer_id = 11 
    e_d = 'enc'
    x = 0 
    y = 21
    layerPath = e_d+'_layer' + str(layer_id)
    patchPath = 'patch_' + str(x) + '_' + str(y)
    path = os.path.join(output_dir, layerPath, patchPath)
    if request.method == 'GET':
        command = f"python3 -m segm.scripts.show_attn_map {checkpoint} {src} {output_dir} --layer-id {layer_id} --x-patch {x} --y-patch {y} --{e_d}"
        subprocess.run(command.split())
        # time.sleep(20)
        res = {'imgs': [os.path.join(path, each) for each in os.listdir(path)]}
        print(res)
        return render_template('predict.html', res = res)
    if request.method == 'POST':
        #todo set parameters
        return render_template('predict.html', res = res)

if __name__ == '__main__':
    from waitress import serve
    serve(app, host="0.0.0.0", port=5000)