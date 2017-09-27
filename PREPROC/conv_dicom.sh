#! /bin/csh


### In this script we will read the dicom files and convert them to NII. In the process we will also create the
### subject folders as well as putting th nii files in the correct location.
### Note, this script assumes that the subject folder exists, and inside it there is a "dicom" folder in it with the
### dicom files in it
###
### Author: Nathalia Esper
### Aug 29, 2017

### SOMENTE EDITAR ESTA PARTE PARA CADA SUJEITO ####

set study = DIALETO
set subj = 001
set frases = 005 
set palavras = 004
set rst = 006
set anat = 008

###########################@@@@@@@@@@@@@@@@@@@@

# get out of script folder
cd ..

# go inside subject folder
cd ${study}${subj}/visit1

# convert dicom images to nii
set subj_folder = `pwd`

# Essa é a linha que ira converter o arquivo DICOM para NIFTI
dcm2nii -c -g -o ${subj_folder} scans/*


##########################################################
# T1 - Anatomical
set image = ANAT
set number = ${anat}
mkdir ${image}

cd ${image}
mv ../2*s${number}*.nii.gz ${study}${subj}.${image}.nii.gz
cd $subj_folder

rm co*.nii.gz
rm o*.nii.gz


##########################################################
# FRASES

set image = FRASES
set number = ${frases}
mkdir ${image}

cd ${image}

mv ../2*s${number}*.nii.gz ${study}${subj}.${image}.nii.gz
cd $subj_folder



##########################################################
# PALAVRAS

set image = PALAVRAS
set number = ${palavras}
mkdir ${image}

cd ${image}

mv ../2*s${number}*.nii.gz ${study}${subj}.${image}.nii.gz
cd $subj_folder


##########################################################
# RESTING-STATE

set image = RST
set number = ${rst}
mkdir ${image}

cd ${image}

mv ../2*s${number}*.nii.gz ${study}${subj}.${image}.nii.gz
cd $subj_folder


#############################################################
# Compacta a pasta
tar -zcvf dicom.tar.gz scans/

# Deleta a pasta scans original
rm -rfv scans/

# remove arquivos extras
rm *nii.gz
