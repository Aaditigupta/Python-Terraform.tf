
from python_terraform import *
import argparse
ap = argparse.ArgumentParser()
ap.add_argument("-a", "--arg1", required=True,
    help="path to argument1")
ap.add_argument("-b", "--arg2", required=True,
    help="path to argument2")
ap.add_argument("-c", "--arg3", required=True,
    help="path to argument3")
ap.add_argument("-d", "--arg4", required=True,
    help="path to argument4")
ap.add_argument("-e", "--arg5", required=True,
    help="path to argument5")

    
args = vars(ap.parse_args())
enter = int(args['arg1'])
instance_id = args['arg2']
region = args['arg3']
d = {}
d[region] = instance_id
state = int(args['arg4'])

if bool(state) == False:
    vpc_id = args['arg5']
if bool(state) == True:
    tf = Terraform(working_dir='/var/lib/jenkins/workspace/Infra Provisioning/Python', variables={'count':enter, 'aws-region':region , 'AMIs': d})
    tf.plan(no_color=IsFlagged, refresh=False, capture_output=True)
    #approve = {"auto-approve": True}
    print(tf.init(reconfigure=True))
    print(tf.apply(skip_plan = True))
else:
    tf = Terraform(working_dir='/var/lib/jenkins/workspace/Infra Provisioning/Python/resource', variables={'count':enter, 'aws-region':region , 'AMIs': d, 'vpc_id': vpc_id})
    tf.plan(no_color=IsFlagged, refresh=False, capture_output=True)
    #approve = {"auto-approve": True}
    print(tf.init(reconfigure=True))
    print(tf.apply(skip_plan = True))
