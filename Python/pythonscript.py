
from python_terraform import *

tf = Terraform(working_dir='/root/var/lib/jenkins/workspace/Terraform-Python/Python')
tf.plan(lock=False)
#approve = {"auto-approve": True}
print(tf.init(reconfigure=True))
print(tf.apply(skip_plan = True))
