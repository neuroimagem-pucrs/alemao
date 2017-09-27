#! /bin/csh


#### EDITAR SOMENTE ESTA PARTE PARA CADA SUJEITO ####
#####################################################
set study = DIALETO
set subj = 001
set run = FRASES
#####################################################

set script_folder = `pwd`

set template = MNI152_T1_2009c+tlrc


cd ../${study}${subj}/visit1


afni_proc.py						\
	-subj_id ${study}${subj}                        \
	-script proc.${study}${subj}.${run}.tcsh 	\
	-out_dir PROC.${run} 				\
	-dsets ${run}/${study}${subj}.${run}.nii.gz	\
	-copy_anat ANAT/${study}${subj}.ANAT.nii.gz	\
 	-do_block despike align tlrc  			\
	-tcat_remove_first_trs 3                        \
	-tshift_opts_ts -tpattern alt+z			\
	-volreg_align_to first				\
	-volreg_align_e2a				\
	-volreg_tlrc_warp				\
	-align_opts_aea -skullstrip_opts 		\
		-shrink_fac_bot_lim 0.8 		\
		-no_pushout				\
	-tlrc_base ${template}				\
        -mask_segment_anat yes				\
	-blur_filter -1blur_fwhm			\
	-blur_size 6 					\
	-regress_stim_times				\
		${script_folder}/timing/FRASES/frase_controle.1D	\
		${script_folder}/timing/FRASES/frase_cognato.1D	\
		${script_folder}/timing/FRASES/pergunta_controle.1D	\
		${script_folder}/timing/FRASES/pergunta_cognato.1D	\
	-regress_stim_labels fr_cont fr_cog perg_cont perg_cog  	\
	-regress_basis_multi							\
	'BLOCK(6,1)' 'BLOCK(6,1)' 'BLOCK(3,1)' 'BLOCK(3,1)'		 	\
	-regress_local_times							\
	-regress_opts_3dD							\
		-gltsym 'SYM: +fr_cont -fr_cog'					\
		-glt_label 1 fr_cont_vs_fr_cog					\
		-gltsym 'SYM: +perg_cont -perg_cog'				\
		-glt_label 2 perg_cont_vs_perg_cog				\
		-jobs 4								\
	-regress_est_blur_epits							\
	-regress_est_blur_errts							\
	-regress_censor_motion 0.3						\
	-regress_censor_outliers 0.1						\
	-regress_apply_mot_types demean						\
	-regress_run_clustsim yes						\
	-execute


cd ../${study}${subj}/PROC.${run}
gzip *BRIK 



exit






