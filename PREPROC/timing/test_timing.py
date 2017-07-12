# /usr/bin/env python

import os

# how do I run an afni code?


os.system('ls')
TR = 2
NT = 238
#NT = 600

# Transform TR in string
# same for NT

numstims = 3
timing1 = "dialeto.1D"
timing2 = "portugues.1D"
timing3 = "alemao.1D"

afni_command = "3dDeconvolve -nodata {0} {1} -polort -1 -num_stimts {2} " \
    "-stim_times 1 {3} \'BLOCK(2,1)\' "\
    "-stim_times 2 {4} \'BLOCK(2,1)\' "\
    "-stim_times 3 {5} \'BLOCK(2,1)\' "\
    "-x1D stdout: | 1dplot -stdin -one -thick".format(str(NT), str(TR),str(numstims), timing1, timing2,timing3)

print(afni_command)

os.system(afni_command)
