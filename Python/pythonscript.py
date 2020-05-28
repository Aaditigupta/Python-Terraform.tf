
from python_terraform import *
import argparse
import time
ap = argparse.ArgumentParser()
ap.add_argument("-a", "--arg1", required=True,
    help="path to argument1")
ap.add_argument("-b", "--arg2", required=True,
    help="path to argument2")
ap.add_argument("-c", "--arg3", required=True,
    help="path to argument3")
args = vars(ap.parse_args())

enter = int(args['arg1'])
instance_id = args['arg2']
region = args['arg3']
d = {}
d[region] = instance_id
tf = Terraform(working_dir='/home/test', variables={'count':enter, 'aws-region':region , 'AMIs': d })
tf.plan(no_color=IsFlagged, refresh=False, capture_output=True, out= "plan.out")
#approve = {"auto-approve": True}
print(tf.init(reconfigure=True))
tf.apply("plan.out",skip_plan = True)
time.sleep(300)
tf.destroy()
