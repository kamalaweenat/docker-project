#!/usr/bin/env python3

import datetime
import sys

now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# get the log full path from argument
log_path = sys.argv[1]
with open(log_path, 'a') as f:
    f.write(f"{now} succeed")
    f.write('\n')
    print("Python output: <<Succeed>>")
