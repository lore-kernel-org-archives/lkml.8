Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAF5C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09FB206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHaM3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:29:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:11734 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgHaM3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:29:21 -0400
IronPort-SDR: c2EVoHK7/irmCLXNyL1AkdUHWrIIBb/9Y8lfB62TPiWghq83CsOp6eHHPgGYA+O+6BHNb9xxcX
 hhXIwoRLaTEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144696927"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="gz'50?scan'50,208,50";a="144696927"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 05:25:56 -0700
IronPort-SDR: bdUadpDCK6IrF7qGximDJ2aql0RSyIlh843f1ZMnvtgt2xgfaehcchSlZDleU1yg01DqtAfFql
 OKC+a9lo0LOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="gz'50?scan'50,208,50";a="501316998"
Received: from lkp-server02.sh.intel.com (HELO 713faec3b0e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 31 Aug 2020 05:25:53 -0700
Received: from kbuild by 713faec3b0e5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kCisj-00002U-AZ; Mon, 31 Aug 2020 12:25:53 +0000
Date:   Mon, 31 Aug 2020 20:25:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/staging/media/ipu3/ipu3-css-params.c:1211:1: warning: the
 frame size of 2500 bytes is larger than 1024 bytes
Message-ID: <202008312008.sjO7Pa2r%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f75aef392f869018f78cfedf3c320a6b3fcfda6b
commit: 0887a7ebc97770c7870abf3075a2e8cd502a7f52 ubsan: add trap instrumentation option
date:   5 months ago
config: i386-randconfig-r026-20200831 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        git checkout 0887a7ebc97770c7870abf3075a2e8cd502a7f52
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/staging/media/ipu3/ipu3-css.h:10,
                    from drivers/staging/media/ipu3/ipu3-css-params.c:6:
   drivers/staging/media/ipu3/ipu3-abi.h:1250:1: warning: alignment 1 of 'struct imgu_abi_awb_fr_config' is less than 32 [-Wpacked-not-aligned]
    1250 | } __packed;
         | ^
   drivers/staging/media/ipu3/ipu3-css-params.c: In function 'imgu_css_osys_calc':
>> drivers/staging/media/ipu3/ipu3-css-params.c:1211:1: warning: the frame size of 2500 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1211 | }
         | ^

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0887a7ebc97770c7870abf3075a2e8cd502a7f52
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 0887a7ebc97770c7870abf3075a2e8cd502a7f52
vim +1211 drivers/staging/media/ipu3/ipu3-css-params.c

e11110a5b74487 Yong Zhi   2018-12-06   845  
e11110a5b74487 Yong Zhi   2018-12-06   846  /*
e11110a5b74487 Yong Zhi   2018-12-06   847   * This function configures the Output Formatter System, given the number of
e11110a5b74487 Yong Zhi   2018-12-06   848   * stripes, scaler luma and chrome parameters
e11110a5b74487 Yong Zhi   2018-12-06   849   */
27b795adb3c221 Yong Zhi   2019-02-07   850  static int imgu_css_osys_calc(struct imgu_css *css, unsigned int pipe,
51abe041c5ed56 Bingbu Cao 2018-12-06   851  			      unsigned int stripes,
e11110a5b74487 Yong Zhi   2018-12-06   852  			      struct imgu_abi_osys_config *osys,
27b795adb3c221 Yong Zhi   2019-02-07   853  			      struct imgu_css_scaler_info *scaler_luma,
27b795adb3c221 Yong Zhi   2019-02-07   854  			      struct imgu_css_scaler_info *scaler_chroma,
e11110a5b74487 Yong Zhi   2018-12-06   855  			      struct imgu_abi_stripes block_stripes[])
e11110a5b74487 Yong Zhi   2018-12-06   856  {
27b795adb3c221 Yong Zhi   2019-02-07   857  	struct imgu_css_frame_params frame_params[IMGU_ABI_OSYS_PINS];
27b795adb3c221 Yong Zhi   2019-02-07   858  	struct imgu_css_stripe_params stripe_params[IPU3_UAPI_MAX_STRIPES];
e11110a5b74487 Yong Zhi   2018-12-06   859  	struct imgu_abi_osys_formatter_params *param;
e11110a5b74487 Yong Zhi   2018-12-06   860  	unsigned int pin, s;
27b795adb3c221 Yong Zhi   2019-02-07   861  	struct imgu_css_pipe *css_pipe = &css->pipes[pipe];
e11110a5b74487 Yong Zhi   2018-12-06   862  
e11110a5b74487 Yong Zhi   2018-12-06   863  	memset(osys, 0, sizeof(*osys));
e11110a5b74487 Yong Zhi   2018-12-06   864  
e11110a5b74487 Yong Zhi   2018-12-06   865  	/* Compute the frame and stripe params */
27b795adb3c221 Yong Zhi   2019-02-07   866  	if (imgu_css_osys_calc_frame_and_stripe_params(css, stripes, osys,
e11110a5b74487 Yong Zhi   2018-12-06   867  						       scaler_luma,
e11110a5b74487 Yong Zhi   2018-12-06   868  						       scaler_chroma,
e11110a5b74487 Yong Zhi   2018-12-06   869  						       frame_params,
51abe041c5ed56 Bingbu Cao 2018-12-06   870  						       stripe_params, pipe))
e11110a5b74487 Yong Zhi   2018-12-06   871  		return -EINVAL;
e11110a5b74487 Yong Zhi   2018-12-06   872  
e11110a5b74487 Yong Zhi   2018-12-06   873  	/* Output formatter system parameters */
e11110a5b74487 Yong Zhi   2018-12-06   874  
e11110a5b74487 Yong Zhi   2018-12-06   875  	for (s = 0; s < stripes; s++) {
e11110a5b74487 Yong Zhi   2018-12-06   876  		struct imgu_abi_osys_scaler_params *scaler =
e11110a5b74487 Yong Zhi   2018-12-06   877  					&osys->scaler[s].param;
e11110a5b74487 Yong Zhi   2018-12-06   878  		int fifo_addr_fmt = IMGU_FIFO_ADDR_SCALER_TO_FMT;
e11110a5b74487 Yong Zhi   2018-12-06   879  		int fifo_addr_ack = IMGU_FIFO_ADDR_SCALER_TO_SP;
e11110a5b74487 Yong Zhi   2018-12-06   880  
e11110a5b74487 Yong Zhi   2018-12-06   881  		/* OUTPUT 0 / PIN 0 is only Scaler output */
e11110a5b74487 Yong Zhi   2018-12-06   882  		scaler->inp_buf_y_st_addr = IMGU_VMEM1_INP_BUF_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06   883  
e11110a5b74487 Yong Zhi   2018-12-06   884  		/*
e11110a5b74487 Yong Zhi   2018-12-06   885  		 * = (IMGU_OSYS_BLOCK_WIDTH / IMGU_VMEM1_ELEMS_PER_VEC)
e11110a5b74487 Yong Zhi   2018-12-06   886  		 * = (2 * IPU3_UAPI_ISP_VEC_ELEMS) /
e11110a5b74487 Yong Zhi   2018-12-06   887  		 *   (IMGU_HIVE_OF_SYS_OF_SYSTEM_NWAYS)
e11110a5b74487 Yong Zhi   2018-12-06   888  		 * = 2 * 64 / 32 = 4
e11110a5b74487 Yong Zhi   2018-12-06   889  		 */
e11110a5b74487 Yong Zhi   2018-12-06   890  		scaler->inp_buf_y_line_stride = IMGU_VMEM1_Y_STRIDE;
e11110a5b74487 Yong Zhi   2018-12-06   891  		/*
e11110a5b74487 Yong Zhi   2018-12-06   892  		 * = (IMGU_VMEM1_V_OFFSET + VMEM1_uv_size)
e11110a5b74487 Yong Zhi   2018-12-06   893  		 * = (IMGU_VMEM1_U_OFFSET + VMEM1_uv_size) +
e11110a5b74487 Yong Zhi   2018-12-06   894  		 *	(VMEM1_y_size / 4)
e11110a5b74487 Yong Zhi   2018-12-06   895  		 * = (VMEM1_y_size) + (VMEM1_y_size / 4) +
e11110a5b74487 Yong Zhi   2018-12-06   896  		 * (IMGU_OSYS_BLOCK_HEIGHT * IMGU_VMEM1_Y_STRIDE)/4
e11110a5b74487 Yong Zhi   2018-12-06   897  		 * = (IMGU_OSYS_BLOCK_HEIGHT * IMGU_VMEM1_Y_STRIDE)
e11110a5b74487 Yong Zhi   2018-12-06   898  		 */
e11110a5b74487 Yong Zhi   2018-12-06   899  		scaler->inp_buf_y_buffer_stride = IMGU_VMEM1_BUF_SIZE;
e11110a5b74487 Yong Zhi   2018-12-06   900  		scaler->inp_buf_u_st_addr = IMGU_VMEM1_INP_BUF_ADDR +
e11110a5b74487 Yong Zhi   2018-12-06   901  						IMGU_VMEM1_U_OFFSET;
e11110a5b74487 Yong Zhi   2018-12-06   902  		scaler->inp_buf_v_st_addr = IMGU_VMEM1_INP_BUF_ADDR +
e11110a5b74487 Yong Zhi   2018-12-06   903  						IMGU_VMEM1_V_OFFSET;
e11110a5b74487 Yong Zhi   2018-12-06   904  		scaler->inp_buf_uv_line_stride = IMGU_VMEM1_UV_STRIDE;
e11110a5b74487 Yong Zhi   2018-12-06   905  		scaler->inp_buf_uv_buffer_stride = IMGU_VMEM1_BUF_SIZE;
e11110a5b74487 Yong Zhi   2018-12-06   906  		scaler->inp_buf_chunk_width = stripe_params[s].chunk_width;
e11110a5b74487 Yong Zhi   2018-12-06   907  		scaler->inp_buf_nr_buffers = IMGU_OSYS_NUM_INPUT_BUFFERS;
e11110a5b74487 Yong Zhi   2018-12-06   908  
e11110a5b74487 Yong Zhi   2018-12-06   909  		/* Output buffers */
e11110a5b74487 Yong Zhi   2018-12-06   910  		scaler->out_buf_y_st_addr = IMGU_VMEM1_INT_BUF_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06   911  		scaler->out_buf_y_line_stride = stripe_params[s].block_width /
e11110a5b74487 Yong Zhi   2018-12-06   912  						IMGU_VMEM1_ELEMS_PER_VEC;
e11110a5b74487 Yong Zhi   2018-12-06   913  		scaler->out_buf_y_buffer_stride = IMGU_VMEM1_BUF_SIZE;
e11110a5b74487 Yong Zhi   2018-12-06   914  		scaler->out_buf_u_st_addr = IMGU_VMEM1_INT_BUF_ADDR +
e11110a5b74487 Yong Zhi   2018-12-06   915  						IMGU_VMEM1_U_OFFSET;
e11110a5b74487 Yong Zhi   2018-12-06   916  		scaler->out_buf_v_st_addr = IMGU_VMEM1_INT_BUF_ADDR +
e11110a5b74487 Yong Zhi   2018-12-06   917  						IMGU_VMEM1_V_OFFSET;
e11110a5b74487 Yong Zhi   2018-12-06   918  		scaler->out_buf_uv_line_stride = stripe_params[s].block_width /
e11110a5b74487 Yong Zhi   2018-12-06   919  						IMGU_VMEM1_ELEMS_PER_VEC / 2;
e11110a5b74487 Yong Zhi   2018-12-06   920  		scaler->out_buf_uv_buffer_stride = IMGU_VMEM1_BUF_SIZE;
e11110a5b74487 Yong Zhi   2018-12-06   921  		scaler->out_buf_nr_buffers = IMGU_OSYS_NUM_INTERM_BUFFERS;
e11110a5b74487 Yong Zhi   2018-12-06   922  
e11110a5b74487 Yong Zhi   2018-12-06   923  		/* Intermediate buffers */
e11110a5b74487 Yong Zhi   2018-12-06   924  		scaler->int_buf_y_st_addr = IMGU_VMEM2_BUF_Y_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06   925  		scaler->int_buf_y_line_stride = IMGU_VMEM2_BUF_Y_STRIDE;
e11110a5b74487 Yong Zhi   2018-12-06   926  		scaler->int_buf_u_st_addr = IMGU_VMEM2_BUF_U_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06   927  		scaler->int_buf_v_st_addr = IMGU_VMEM2_BUF_V_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06   928  		scaler->int_buf_uv_line_stride = IMGU_VMEM2_BUF_UV_STRIDE;
e11110a5b74487 Yong Zhi   2018-12-06   929  		scaler->int_buf_height = IMGU_VMEM2_LINES_PER_BLOCK;
e11110a5b74487 Yong Zhi   2018-12-06   930  		scaler->int_buf_chunk_width = stripe_params[s].chunk_height;
e11110a5b74487 Yong Zhi   2018-12-06   931  		scaler->int_buf_chunk_height = stripe_params[s].block_width;
e11110a5b74487 Yong Zhi   2018-12-06   932  
e11110a5b74487 Yong Zhi   2018-12-06   933  		/* Context buffers */
e11110a5b74487 Yong Zhi   2018-12-06   934  		scaler->ctx_buf_hor_y_st_addr = IMGU_VMEM3_HOR_Y_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06   935  		scaler->ctx_buf_hor_u_st_addr = IMGU_VMEM3_HOR_U_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06   936  		scaler->ctx_buf_hor_v_st_addr = IMGU_VMEM3_HOR_V_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06   937  		scaler->ctx_buf_ver_y_st_addr = IMGU_VMEM3_VER_Y_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06   938  		scaler->ctx_buf_ver_u_st_addr = IMGU_VMEM3_VER_U_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06   939  		scaler->ctx_buf_ver_v_st_addr = IMGU_VMEM3_VER_V_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06   940  
e11110a5b74487 Yong Zhi   2018-12-06   941  		/* Addresses for release-input and process-output tokens */
e11110a5b74487 Yong Zhi   2018-12-06   942  		scaler->release_inp_buf_addr = fifo_addr_ack;
e11110a5b74487 Yong Zhi   2018-12-06   943  		scaler->release_inp_buf_en = 1;
e11110a5b74487 Yong Zhi   2018-12-06   944  		scaler->release_out_buf_en = 1;
e11110a5b74487 Yong Zhi   2018-12-06   945  		scaler->process_out_buf_addr = fifo_addr_fmt;
e11110a5b74487 Yong Zhi   2018-12-06   946  
e11110a5b74487 Yong Zhi   2018-12-06   947  		/* Settings dimensions, padding, cropping */
e11110a5b74487 Yong Zhi   2018-12-06   948  		scaler->input_image_y_width = stripe_params[s].input_width;
e11110a5b74487 Yong Zhi   2018-12-06   949  		scaler->input_image_y_height = stripe_params[s].input_height;
e11110a5b74487 Yong Zhi   2018-12-06   950  		scaler->input_image_y_start_column =
e11110a5b74487 Yong Zhi   2018-12-06   951  					stripe_params[s].start_column_y;
e11110a5b74487 Yong Zhi   2018-12-06   952  		scaler->input_image_uv_start_column =
e11110a5b74487 Yong Zhi   2018-12-06   953  					stripe_params[s].start_column_uv;
e11110a5b74487 Yong Zhi   2018-12-06   954  		scaler->input_image_y_left_pad = stripe_params[s].pad_left_y;
e11110a5b74487 Yong Zhi   2018-12-06   955  		scaler->input_image_uv_left_pad = stripe_params[s].pad_left_uv;
e11110a5b74487 Yong Zhi   2018-12-06   956  		scaler->input_image_y_right_pad = stripe_params[s].pad_right_y;
e11110a5b74487 Yong Zhi   2018-12-06   957  		scaler->input_image_uv_right_pad =
e11110a5b74487 Yong Zhi   2018-12-06   958  					stripe_params[s].pad_right_uv;
e11110a5b74487 Yong Zhi   2018-12-06   959  		scaler->input_image_y_top_pad = stripe_params[s].pad_top_y;
e11110a5b74487 Yong Zhi   2018-12-06   960  		scaler->input_image_uv_top_pad = stripe_params[s].pad_top_uv;
e11110a5b74487 Yong Zhi   2018-12-06   961  		scaler->input_image_y_bottom_pad =
e11110a5b74487 Yong Zhi   2018-12-06   962  					stripe_params[s].pad_bottom_y;
e11110a5b74487 Yong Zhi   2018-12-06   963  		scaler->input_image_uv_bottom_pad =
e11110a5b74487 Yong Zhi   2018-12-06   964  					stripe_params[s].pad_bottom_uv;
e11110a5b74487 Yong Zhi   2018-12-06   965  		scaler->processing_mode = stripe_params[s].processing_mode;
e11110a5b74487 Yong Zhi   2018-12-06   966  		scaler->scaling_ratio = stripe_params[s].phase_step;
e11110a5b74487 Yong Zhi   2018-12-06   967  		scaler->y_left_phase_init = stripe_params[s].phase_init_left_y;
e11110a5b74487 Yong Zhi   2018-12-06   968  		scaler->uv_left_phase_init =
e11110a5b74487 Yong Zhi   2018-12-06   969  					stripe_params[s].phase_init_left_uv;
e11110a5b74487 Yong Zhi   2018-12-06   970  		scaler->y_top_phase_init = stripe_params[s].phase_init_top_y;
e11110a5b74487 Yong Zhi   2018-12-06   971  		scaler->uv_top_phase_init = stripe_params[s].phase_init_top_uv;
e11110a5b74487 Yong Zhi   2018-12-06   972  		scaler->coeffs_exp_shift = stripe_params[s].exp_shift;
e11110a5b74487 Yong Zhi   2018-12-06   973  		scaler->out_y_left_crop = stripe_params[s].crop_left_y;
e11110a5b74487 Yong Zhi   2018-12-06   974  		scaler->out_uv_left_crop = stripe_params[s].crop_left_uv;
e11110a5b74487 Yong Zhi   2018-12-06   975  		scaler->out_y_top_crop = stripe_params[s].crop_top_y;
e11110a5b74487 Yong Zhi   2018-12-06   976  		scaler->out_uv_top_crop = stripe_params[s].crop_top_uv;
e11110a5b74487 Yong Zhi   2018-12-06   977  
e11110a5b74487 Yong Zhi   2018-12-06   978  		for (pin = 0; pin < IMGU_ABI_OSYS_PINS; pin++) {
e11110a5b74487 Yong Zhi   2018-12-06   979  			int in_fifo_addr;
e11110a5b74487 Yong Zhi   2018-12-06   980  			int out_fifo_addr;
e11110a5b74487 Yong Zhi   2018-12-06   981  			int block_width_vecs;
e11110a5b74487 Yong Zhi   2018-12-06   982  			int input_width_s;
e11110a5b74487 Yong Zhi   2018-12-06   983  			int input_width_vecs;
e11110a5b74487 Yong Zhi   2018-12-06   984  			int input_buf_y_st_addr;
e11110a5b74487 Yong Zhi   2018-12-06   985  			int input_buf_u_st_addr;
e11110a5b74487 Yong Zhi   2018-12-06   986  			int input_buf_v_st_addr;
e11110a5b74487 Yong Zhi   2018-12-06   987  			int input_buf_y_line_stride;
e11110a5b74487 Yong Zhi   2018-12-06   988  			int input_buf_uv_line_stride;
e11110a5b74487 Yong Zhi   2018-12-06   989  			int output_buf_y_line_stride;
e11110a5b74487 Yong Zhi   2018-12-06   990  			int output_buf_uv_line_stride;
e11110a5b74487 Yong Zhi   2018-12-06   991  			int output_buf_nr_y_lines;
e11110a5b74487 Yong Zhi   2018-12-06   992  			int block_height;
e11110a5b74487 Yong Zhi   2018-12-06   993  			int block_width;
e11110a5b74487 Yong Zhi   2018-12-06   994  			struct imgu_abi_osys_frame_params *fr_pr;
e11110a5b74487 Yong Zhi   2018-12-06   995  
e11110a5b74487 Yong Zhi   2018-12-06   996  			fr_pr = &osys->frame[pin].param;
e11110a5b74487 Yong Zhi   2018-12-06   997  
e11110a5b74487 Yong Zhi   2018-12-06   998  			/* Frame parameters */
e11110a5b74487 Yong Zhi   2018-12-06   999  			fr_pr->enable = frame_params[pin].enable;
e11110a5b74487 Yong Zhi   2018-12-06  1000  			fr_pr->format = frame_params[pin].format;
e11110a5b74487 Yong Zhi   2018-12-06  1001  			fr_pr->mirror = frame_params[pin].mirror;
e11110a5b74487 Yong Zhi   2018-12-06  1002  			fr_pr->flip = frame_params[pin].flip;
e11110a5b74487 Yong Zhi   2018-12-06  1003  			fr_pr->tiling = frame_params[pin].tiling;
e11110a5b74487 Yong Zhi   2018-12-06  1004  			fr_pr->width = frame_params[pin].width;
e11110a5b74487 Yong Zhi   2018-12-06  1005  			fr_pr->height = frame_params[pin].height;
e11110a5b74487 Yong Zhi   2018-12-06  1006  			fr_pr->stride = frame_params[pin].stride;
e11110a5b74487 Yong Zhi   2018-12-06  1007  			fr_pr->scaled = frame_params[pin].scaled;
e11110a5b74487 Yong Zhi   2018-12-06  1008  
e11110a5b74487 Yong Zhi   2018-12-06  1009  			/* Stripe parameters */
e11110a5b74487 Yong Zhi   2018-12-06  1010  			osys->stripe[s].crop_top[pin] =
e11110a5b74487 Yong Zhi   2018-12-06  1011  				frame_params[pin].crop_top;
e11110a5b74487 Yong Zhi   2018-12-06  1012  			osys->stripe[s].input_width =
e11110a5b74487 Yong Zhi   2018-12-06  1013  				stripe_params[s].input_width;
e11110a5b74487 Yong Zhi   2018-12-06  1014  			osys->stripe[s].input_height =
e11110a5b74487 Yong Zhi   2018-12-06  1015  				stripe_params[s].input_height;
e11110a5b74487 Yong Zhi   2018-12-06  1016  			osys->stripe[s].block_height =
e11110a5b74487 Yong Zhi   2018-12-06  1017  				stripe_params[s].block_height;
e11110a5b74487 Yong Zhi   2018-12-06  1018  			osys->stripe[s].block_width =
e11110a5b74487 Yong Zhi   2018-12-06  1019  				stripe_params[s].block_width;
e11110a5b74487 Yong Zhi   2018-12-06  1020  			osys->stripe[s].output_width[pin] =
e11110a5b74487 Yong Zhi   2018-12-06  1021  				stripe_params[s].output_width[pin];
e11110a5b74487 Yong Zhi   2018-12-06  1022  			osys->stripe[s].output_height[pin] =
e11110a5b74487 Yong Zhi   2018-12-06  1023  				stripe_params[s].output_height[pin];
e11110a5b74487 Yong Zhi   2018-12-06  1024  
e11110a5b74487 Yong Zhi   2018-12-06  1025  			if (s == 0) {
e11110a5b74487 Yong Zhi   2018-12-06  1026  				/* Only first stripe should do left cropping */
e11110a5b74487 Yong Zhi   2018-12-06  1027  				osys->stripe[s].crop_left[pin] =
e11110a5b74487 Yong Zhi   2018-12-06  1028  					frame_params[pin].crop_left;
e11110a5b74487 Yong Zhi   2018-12-06  1029  				osys->stripe[s].output_offset[pin] =
e11110a5b74487 Yong Zhi   2018-12-06  1030  					stripe_params[s].output_offset[pin];
e11110a5b74487 Yong Zhi   2018-12-06  1031  			} else {
e11110a5b74487 Yong Zhi   2018-12-06  1032  				/*
e11110a5b74487 Yong Zhi   2018-12-06  1033  				 * Stripe offset for other strips should be
e11110a5b74487 Yong Zhi   2018-12-06  1034  				 * adjusted according to the cropping done
e11110a5b74487 Yong Zhi   2018-12-06  1035  				 * at the first strip
e11110a5b74487 Yong Zhi   2018-12-06  1036  				 */
e11110a5b74487 Yong Zhi   2018-12-06  1037  				osys->stripe[s].crop_left[pin] = 0;
e11110a5b74487 Yong Zhi   2018-12-06  1038  				osys->stripe[s].output_offset[pin] =
e11110a5b74487 Yong Zhi   2018-12-06  1039  					(stripe_params[s].output_offset[pin] -
e11110a5b74487 Yong Zhi   2018-12-06  1040  					 osys->stripe[0].crop_left[pin]);
e11110a5b74487 Yong Zhi   2018-12-06  1041  			}
e11110a5b74487 Yong Zhi   2018-12-06  1042  
e11110a5b74487 Yong Zhi   2018-12-06  1043  			if (!frame_params[pin].enable)
e11110a5b74487 Yong Zhi   2018-12-06  1044  				continue;
e11110a5b74487 Yong Zhi   2018-12-06  1045  
e11110a5b74487 Yong Zhi   2018-12-06  1046  			/* Formatter: configurations */
e11110a5b74487 Yong Zhi   2018-12-06  1047  
e11110a5b74487 Yong Zhi   2018-12-06  1048  			/*
e11110a5b74487 Yong Zhi   2018-12-06  1049  			 * Get the dimensions of the input blocks of the
e11110a5b74487 Yong Zhi   2018-12-06  1050  			 * formatter, which is the same as the output
e11110a5b74487 Yong Zhi   2018-12-06  1051  			 * blocks of the scaler.
e11110a5b74487 Yong Zhi   2018-12-06  1052  			 */
e11110a5b74487 Yong Zhi   2018-12-06  1053  			if (frame_params[pin].scaled) {
e11110a5b74487 Yong Zhi   2018-12-06  1054  				block_height = stripe_params[s].block_height;
e11110a5b74487 Yong Zhi   2018-12-06  1055  				block_width = stripe_params[s].block_width;
e11110a5b74487 Yong Zhi   2018-12-06  1056  			} else {
e11110a5b74487 Yong Zhi   2018-12-06  1057  				block_height = IMGU_OSYS_BLOCK_HEIGHT;
e11110a5b74487 Yong Zhi   2018-12-06  1058  				block_width = IMGU_OSYS_BLOCK_WIDTH;
e11110a5b74487 Yong Zhi   2018-12-06  1059  			}
e11110a5b74487 Yong Zhi   2018-12-06  1060  			block_width_vecs =
e11110a5b74487 Yong Zhi   2018-12-06  1061  					block_width / IMGU_VMEM1_ELEMS_PER_VEC;
e11110a5b74487 Yong Zhi   2018-12-06  1062  			/*
e11110a5b74487 Yong Zhi   2018-12-06  1063  			 * The input/output line stride depends on the
e11110a5b74487 Yong Zhi   2018-12-06  1064  			 * block size.
e11110a5b74487 Yong Zhi   2018-12-06  1065  			 */
e11110a5b74487 Yong Zhi   2018-12-06  1066  			input_buf_y_line_stride = block_width_vecs;
e11110a5b74487 Yong Zhi   2018-12-06  1067  			input_buf_uv_line_stride = block_width_vecs / 2;
e11110a5b74487 Yong Zhi   2018-12-06  1068  			output_buf_y_line_stride = block_width_vecs;
e11110a5b74487 Yong Zhi   2018-12-06  1069  			output_buf_uv_line_stride = block_width_vecs / 2;
e11110a5b74487 Yong Zhi   2018-12-06  1070  			output_buf_nr_y_lines = block_height;
e11110a5b74487 Yong Zhi   2018-12-06  1071  			if (frame_params[pin].format ==
e11110a5b74487 Yong Zhi   2018-12-06  1072  			    IMGU_ABI_OSYS_FORMAT_NV12 ||
e11110a5b74487 Yong Zhi   2018-12-06  1073  			    frame_params[pin].format ==
e11110a5b74487 Yong Zhi   2018-12-06  1074  			    IMGU_ABI_OSYS_FORMAT_NV21)
e11110a5b74487 Yong Zhi   2018-12-06  1075  				output_buf_uv_line_stride =
e11110a5b74487 Yong Zhi   2018-12-06  1076  					output_buf_y_line_stride;
e11110a5b74487 Yong Zhi   2018-12-06  1077  
e11110a5b74487 Yong Zhi   2018-12-06  1078  			/*
e11110a5b74487 Yong Zhi   2018-12-06  1079  			 * Tiled outputs use a different output buffer
e11110a5b74487 Yong Zhi   2018-12-06  1080  			 * configuration. The input (= scaler output) block
e11110a5b74487 Yong Zhi   2018-12-06  1081  			 * width translates to a tile height, and the block
e11110a5b74487 Yong Zhi   2018-12-06  1082  			 * height to the tile width. The default block size of
e11110a5b74487 Yong Zhi   2018-12-06  1083  			 * 128x32 maps exactly onto a 4kB tile (512x8) for Y.
e11110a5b74487 Yong Zhi   2018-12-06  1084  			 * For UV, the tile width is always half.
e11110a5b74487 Yong Zhi   2018-12-06  1085  			 */
e11110a5b74487 Yong Zhi   2018-12-06  1086  			if (frame_params[pin].tiling) {
e11110a5b74487 Yong Zhi   2018-12-06  1087  				output_buf_nr_y_lines = 8;
e11110a5b74487 Yong Zhi   2018-12-06  1088  				output_buf_y_line_stride = 512 /
e11110a5b74487 Yong Zhi   2018-12-06  1089  					IMGU_VMEM1_ELEMS_PER_VEC;
e11110a5b74487 Yong Zhi   2018-12-06  1090  				output_buf_uv_line_stride = 256 /
e11110a5b74487 Yong Zhi   2018-12-06  1091  					IMGU_VMEM1_ELEMS_PER_VEC;
e11110a5b74487 Yong Zhi   2018-12-06  1092  			}
e11110a5b74487 Yong Zhi   2018-12-06  1093  
e11110a5b74487 Yong Zhi   2018-12-06  1094  			/*
e11110a5b74487 Yong Zhi   2018-12-06  1095  			 * Store the output buffer line stride. Will be
e11110a5b74487 Yong Zhi   2018-12-06  1096  			 * used to compute buffer offsets in boundary
e11110a5b74487 Yong Zhi   2018-12-06  1097  			 * conditions when output blocks are partially
e11110a5b74487 Yong Zhi   2018-12-06  1098  			 * outside the image.
e11110a5b74487 Yong Zhi   2018-12-06  1099  			 */
e11110a5b74487 Yong Zhi   2018-12-06  1100  			osys->stripe[s].buf_stride[pin] =
e11110a5b74487 Yong Zhi   2018-12-06  1101  				output_buf_y_line_stride *
e11110a5b74487 Yong Zhi   2018-12-06  1102  				IMGU_HIVE_OF_SYS_OF_SYSTEM_NWAYS;
e11110a5b74487 Yong Zhi   2018-12-06  1103  			if (frame_params[pin].scaled) {
e11110a5b74487 Yong Zhi   2018-12-06  1104  				/*
e11110a5b74487 Yong Zhi   2018-12-06  1105  				 * The input buffs are the intermediate
e11110a5b74487 Yong Zhi   2018-12-06  1106  				 * buffers (scalers' output)
e11110a5b74487 Yong Zhi   2018-12-06  1107  				 */
e11110a5b74487 Yong Zhi   2018-12-06  1108  				input_buf_y_st_addr = IMGU_VMEM1_INT_BUF_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06  1109  				input_buf_u_st_addr = IMGU_VMEM1_INT_BUF_ADDR +
e11110a5b74487 Yong Zhi   2018-12-06  1110  							IMGU_VMEM1_U_OFFSET;
e11110a5b74487 Yong Zhi   2018-12-06  1111  				input_buf_v_st_addr = IMGU_VMEM1_INT_BUF_ADDR +
e11110a5b74487 Yong Zhi   2018-12-06  1112  							IMGU_VMEM1_V_OFFSET;
e11110a5b74487 Yong Zhi   2018-12-06  1113  			} else {
e11110a5b74487 Yong Zhi   2018-12-06  1114  				/*
e11110a5b74487 Yong Zhi   2018-12-06  1115  				 * The input bufferss are the buffers
e11110a5b74487 Yong Zhi   2018-12-06  1116  				 * filled by the SP
e11110a5b74487 Yong Zhi   2018-12-06  1117  				 */
e11110a5b74487 Yong Zhi   2018-12-06  1118  				input_buf_y_st_addr = IMGU_VMEM1_INP_BUF_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06  1119  				input_buf_u_st_addr = IMGU_VMEM1_INP_BUF_ADDR +
e11110a5b74487 Yong Zhi   2018-12-06  1120  							IMGU_VMEM1_U_OFFSET;
e11110a5b74487 Yong Zhi   2018-12-06  1121  				input_buf_v_st_addr = IMGU_VMEM1_INP_BUF_ADDR +
e11110a5b74487 Yong Zhi   2018-12-06  1122  							IMGU_VMEM1_V_OFFSET;
e11110a5b74487 Yong Zhi   2018-12-06  1123  			}
e11110a5b74487 Yong Zhi   2018-12-06  1124  
e11110a5b74487 Yong Zhi   2018-12-06  1125  			/*
e11110a5b74487 Yong Zhi   2018-12-06  1126  			 * The formatter input width must be rounded to
e11110a5b74487 Yong Zhi   2018-12-06  1127  			 * the block width. Otherwise the formatter will
e11110a5b74487 Yong Zhi   2018-12-06  1128  			 * not recognize the end of the line, resulting
e11110a5b74487 Yong Zhi   2018-12-06  1129  			 * in incorrect tiling (system may hang!) and
e11110a5b74487 Yong Zhi   2018-12-06  1130  			 * possibly other problems.
e11110a5b74487 Yong Zhi   2018-12-06  1131  			 */
e11110a5b74487 Yong Zhi   2018-12-06  1132  			input_width_s =
e11110a5b74487 Yong Zhi   2018-12-06  1133  				roundup(stripe_params[s].output_width[pin],
e11110a5b74487 Yong Zhi   2018-12-06  1134  					block_width);
e11110a5b74487 Yong Zhi   2018-12-06  1135  			input_width_vecs = input_width_s /
e11110a5b74487 Yong Zhi   2018-12-06  1136  					IMGU_VMEM1_ELEMS_PER_VEC;
e11110a5b74487 Yong Zhi   2018-12-06  1137  			out_fifo_addr = IMGU_FIFO_ADDR_FMT_TO_SP;
e11110a5b74487 Yong Zhi   2018-12-06  1138  			/*
e11110a5b74487 Yong Zhi   2018-12-06  1139  			 * Process-output tokens must be sent to the SP.
e11110a5b74487 Yong Zhi   2018-12-06  1140  			 * When scaling, the release-input tokens can be
e11110a5b74487 Yong Zhi   2018-12-06  1141  			 * sent directly to the scaler, otherwise the
e11110a5b74487 Yong Zhi   2018-12-06  1142  			 * formatter should send them to the SP.
e11110a5b74487 Yong Zhi   2018-12-06  1143  			 */
e11110a5b74487 Yong Zhi   2018-12-06  1144  			if (frame_params[pin].scaled)
e11110a5b74487 Yong Zhi   2018-12-06  1145  				in_fifo_addr = IMGU_FIFO_ADDR_FMT_TO_SCALER;
e11110a5b74487 Yong Zhi   2018-12-06  1146  			else
e11110a5b74487 Yong Zhi   2018-12-06  1147  				in_fifo_addr = IMGU_FIFO_ADDR_FMT_TO_SP;
e11110a5b74487 Yong Zhi   2018-12-06  1148  
e11110a5b74487 Yong Zhi   2018-12-06  1149  			/* Formatter */
e11110a5b74487 Yong Zhi   2018-12-06  1150  			param = &osys->formatter[s][pin].param;
e11110a5b74487 Yong Zhi   2018-12-06  1151  
e11110a5b74487 Yong Zhi   2018-12-06  1152  			param->format = frame_params[pin].format;
e11110a5b74487 Yong Zhi   2018-12-06  1153  			param->flip = frame_params[pin].flip;
e11110a5b74487 Yong Zhi   2018-12-06  1154  			param->mirror = frame_params[pin].mirror;
e11110a5b74487 Yong Zhi   2018-12-06  1155  			param->tiling = frame_params[pin].tiling;
e11110a5b74487 Yong Zhi   2018-12-06  1156  			param->reduce_range = frame_params[pin].reduce_range;
e11110a5b74487 Yong Zhi   2018-12-06  1157  			param->alpha_blending = 0;
e11110a5b74487 Yong Zhi   2018-12-06  1158  			param->release_inp_addr = in_fifo_addr;
e11110a5b74487 Yong Zhi   2018-12-06  1159  			param->release_inp_en = 1;
e11110a5b74487 Yong Zhi   2018-12-06  1160  			param->process_out_buf_addr = out_fifo_addr;
e11110a5b74487 Yong Zhi   2018-12-06  1161  			param->image_width_vecs = input_width_vecs;
e11110a5b74487 Yong Zhi   2018-12-06  1162  			param->image_height_lines =
e11110a5b74487 Yong Zhi   2018-12-06  1163  				stripe_params[s].output_height[pin];
e11110a5b74487 Yong Zhi   2018-12-06  1164  			param->inp_buff_y_st_addr = input_buf_y_st_addr;
e11110a5b74487 Yong Zhi   2018-12-06  1165  			param->inp_buff_y_line_stride = input_buf_y_line_stride;
e11110a5b74487 Yong Zhi   2018-12-06  1166  			param->inp_buff_y_buffer_stride = IMGU_VMEM1_BUF_SIZE;
e11110a5b74487 Yong Zhi   2018-12-06  1167  			param->int_buff_u_st_addr = input_buf_u_st_addr;
e11110a5b74487 Yong Zhi   2018-12-06  1168  			param->int_buff_v_st_addr = input_buf_v_st_addr;
e11110a5b74487 Yong Zhi   2018-12-06  1169  			param->inp_buff_uv_line_stride =
e11110a5b74487 Yong Zhi   2018-12-06  1170  				input_buf_uv_line_stride;
e11110a5b74487 Yong Zhi   2018-12-06  1171  			param->inp_buff_uv_buffer_stride = IMGU_VMEM1_BUF_SIZE;
e11110a5b74487 Yong Zhi   2018-12-06  1172  			param->out_buff_level = 0;
e11110a5b74487 Yong Zhi   2018-12-06  1173  			param->out_buff_nr_y_lines = output_buf_nr_y_lines;
e11110a5b74487 Yong Zhi   2018-12-06  1174  			param->out_buff_u_st_offset = IMGU_VMEM1_U_OFFSET;
e11110a5b74487 Yong Zhi   2018-12-06  1175  			param->out_buff_v_st_offset = IMGU_VMEM1_V_OFFSET;
e11110a5b74487 Yong Zhi   2018-12-06  1176  			param->out_buff_y_line_stride =
e11110a5b74487 Yong Zhi   2018-12-06  1177  				output_buf_y_line_stride;
e11110a5b74487 Yong Zhi   2018-12-06  1178  			param->out_buff_uv_line_stride =
e11110a5b74487 Yong Zhi   2018-12-06  1179  				output_buf_uv_line_stride;
e11110a5b74487 Yong Zhi   2018-12-06  1180  			param->hist_buff_st_addr = IMGU_VMEM1_HST_BUF_ADDR;
e11110a5b74487 Yong Zhi   2018-12-06  1181  			param->hist_buff_line_stride =
e11110a5b74487 Yong Zhi   2018-12-06  1182  				IMGU_VMEM1_HST_BUF_STRIDE;
e11110a5b74487 Yong Zhi   2018-12-06  1183  			param->hist_buff_nr_lines = IMGU_VMEM1_HST_BUF_NLINES;
e11110a5b74487 Yong Zhi   2018-12-06  1184  		}
e11110a5b74487 Yong Zhi   2018-12-06  1185  	}
e11110a5b74487 Yong Zhi   2018-12-06  1186  
e11110a5b74487 Yong Zhi   2018-12-06  1187  	block_stripes[0].offset = 0;
e11110a5b74487 Yong Zhi   2018-12-06  1188  	if (stripes <= 1) {
e11110a5b74487 Yong Zhi   2018-12-06  1189  		block_stripes[0].width = stripe_params[0].input_width;
e11110a5b74487 Yong Zhi   2018-12-06  1190  		block_stripes[0].height = stripe_params[0].input_height;
e11110a5b74487 Yong Zhi   2018-12-06  1191  	} else {
e11110a5b74487 Yong Zhi   2018-12-06  1192  		struct imgu_fw_info *bi =
51abe041c5ed56 Bingbu Cao 2018-12-06  1193  			&css->fwp->binary_header[css_pipe->bindex];
51abe041c5ed56 Bingbu Cao 2018-12-06  1194  		unsigned int sp_block_width =
51abe041c5ed56 Bingbu Cao 2018-12-06  1195  				bi->info.isp.sp.block.block_width *
51abe041c5ed56 Bingbu Cao 2018-12-06  1196  				IPU3_UAPI_ISP_VEC_ELEMS;
e11110a5b74487 Yong Zhi   2018-12-06  1197  
e11110a5b74487 Yong Zhi   2018-12-06  1198  		block_stripes[0].width = roundup(stripe_params[0].input_width,
e11110a5b74487 Yong Zhi   2018-12-06  1199  						 sp_block_width);
e11110a5b74487 Yong Zhi   2018-12-06  1200  		block_stripes[1].offset =
51abe041c5ed56 Bingbu Cao 2018-12-06  1201  			rounddown(css_pipe->rect[IPU3_CSS_RECT_GDC].width -
e11110a5b74487 Yong Zhi   2018-12-06  1202  				  stripe_params[1].input_width, sp_block_width);
e11110a5b74487 Yong Zhi   2018-12-06  1203  		block_stripes[1].width =
51abe041c5ed56 Bingbu Cao 2018-12-06  1204  			roundup(css_pipe->rect[IPU3_CSS_RECT_GDC].width -
e11110a5b74487 Yong Zhi   2018-12-06  1205  				block_stripes[1].offset, sp_block_width);
51abe041c5ed56 Bingbu Cao 2018-12-06  1206  		block_stripes[0].height = css_pipe->rect[IPU3_CSS_RECT_GDC].height;
e11110a5b74487 Yong Zhi   2018-12-06  1207  		block_stripes[1].height = block_stripes[0].height;
e11110a5b74487 Yong Zhi   2018-12-06  1208  	}
e11110a5b74487 Yong Zhi   2018-12-06  1209  
e11110a5b74487 Yong Zhi   2018-12-06  1210  	return 0;
e11110a5b74487 Yong Zhi   2018-12-06 @1211  }
e11110a5b74487 Yong Zhi   2018-12-06  1212  

:::::: The code at line 1211 was first introduced by commit
:::::: e11110a5b74487cfc99dad8a5744fe26782f5d9c media: staging/intel-ipu3: css: Compute and program ccs

:::::: TO: Yong Zhi <yong.zhi@intel.com>
:::::: CC: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VS++wcV0S1rZb1Fb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
6XxMQyDd7L2OvUzknJKSWx//A0+I0lcohwIA

--VS++wcV0S1rZb1Fb--
