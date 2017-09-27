#! /bin/csh


#### EDITAR SOMENTE ESTA PARTE PARA CADA SUJEITO ####
#####################################################
set study = DIALETO
set subj = 001
set run = PALAVRAS
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
		${script_folder}/timing/palavras_dialeto1.1D	\
		${script_folder}/timing/palavras_dialeto2.1D	\
		${script_folder}/timing/palavras_dialeto3.1D	\
		${script_folder}/timing/palavras_portugues.1D	\
		${script_folder}/timing/palavras_alemao.1D	\
	-regress_stim_labels dia1 dia2 dia3 port alemao 	\
	-regress_basis_multi							\
	'BLOCK(3,1)' 'BLOCK(3,1)' 'BLOCK(3,1)' 'BLOCK(3,1)' 'BLOCK(3,1)' 	\
	-regress_local_times							\
	-regress_opts_3dD							\
		-gltsym 'SYM: +dia1 -dia2'					\
		-glt_label 1 dia1_vs_dia2					\
		-gltsym 'SYM: +dia1 -dia3'					\
		-glt_label 2 dia1_vs_dia3					\
		-gltsym 'SYM: +dia2 -dia3'					\
		-glt_label 3 dia2_vs_dia3					\
		-gltsym 'SYM: +port -dia1'					\
		-glt_label 4 port_vs_dia1					\
		-gltsym 'SYM: +port -alemao'					\
		-glt_label 5 port_vs_alemao					\
		-gltsym 'SYM: +alemao -dia1'					\
		-glt_label 6 alemao_vs_dia1					\
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






