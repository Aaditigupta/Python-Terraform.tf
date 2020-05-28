
from python_terraform import *

tf = Terraform(working_dir='/var/lib/jenkins/workspace/Terraform-Python/Python')
tf.plan()
print(tf.init(reconfigure=True))
print(tf.apply(skip_plan = True))
