#!/usr/bin/env python

import os
import sys
import pwd


def change_to_user_sage():
    p = pwd.getpwnam('sage')
    if p.pw_uid == os.getuid():
        return
    if os.getuid() != 0:
        raise RuntimeError('insufficient permissions to switch user ids')
    os.setgid(p.pw_gid)
    os.setuid(p.pw_uid)
    os.environ['HOME'] = p.pw_dir

    
if __name__ == '__main__':
    change_to_user_sage()
    if os.isatty(sys.stdin.fileno()):
        print("Launching command-line Sage...")
        os.execl('/home/sage/sage/sage', 'sage')
    else:
        print('Container is not interactive. Use "./docker run -i -t sagemath/sage" to')
        print('run the commandline.')
        os.execl('/home/sage/sage/sage', 'sage',
                 '--notebook=sagenb', 'port=8080', 'interface=""')
