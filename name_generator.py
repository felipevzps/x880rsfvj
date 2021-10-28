import random
import string

name = string.ascii_lowercase + string.digits
print("name = " + ''.join(random.sample(name*9,9)))
#name = x880rsfvj