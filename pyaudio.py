import pyaudio
import matplotlib.pyplot as plt
import numpy as np
 
pa = pyaudio.PyAudio()
 
format = pyaudio.paInt16
channels = 2
rate = 16000
frames = 1600
duration = 5.0
 
stream = pa.open(format=format, channels=channels, rate=rate, input=True,
                 frames_per_buffer=frames)
print('start recording')
 
data = []
for i in range(0, int(rate / frames * duration)):
    buf = stream.read(frames)
    data.append(np.frombuffer(buf, dtype='int16').reshape((frames,channels)) / float(2**15))
 
stream.close()
pa.terminate()
 
print('stop recording')
 
x = np.concatenate(data)
 
for i in range(channels):
    plt.subplot(channels, 1, i + 1)
    plt.plot(x[:,i])
    plt.ylim(-1.0, 1.0)
plt.show()
 
input()