python <<EOF
import threading
import time

print('xxx')

def print_to_vim():
    print('yyy')
    while True:
        time.sleep(4)
        print('ggg')

threading.Thread(name='test', target=print_to_vim).start()

print('zzz')

time.sleep(3)

EOF
