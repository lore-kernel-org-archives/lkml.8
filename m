Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198DAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62A420760
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFQHwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:52:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:49173 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgFQHwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:52:19 -0400
IronPort-SDR: glLIg22U4jdprgS8+iW8vkliTB/ZEkKhCgZVLTyN098HzIIn3sNtkRToiAqQD/7/t9Z/jg2ZVP
 Zf+G1DBg5vJg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 00:51:12 -0700
IronPort-SDR: LG6WgTACd+wqY4FpbY7lywAAegAvJZnqfT0Z5R9uBALtnCgiF2BqpCie0SoJHGjxo2GtPhGbUV
 24c8F0PZ60Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,521,1583222400"; 
   d="gz'50?scan'50,208,50";a="261670869"
Received: from lkp-server02.sh.intel.com (HELO 19cb4f8aa5d7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jun 2020 00:51:09 -0700
Received: from kbuild by 19cb4f8aa5d7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jlSqi-00004K-TI; Wed, 17 Jun 2020 07:51:08 +0000
Date:   Wed, 17 Jun 2020 15:50:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.c:350:11:
 warning: variable 'pixel_width' set but not used
Message-ID: <202006171556.s9CptEmE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69119673bd50b176ded34032fadd41530fb5af21
commit: 476e955dd679673c81c35f383ffff8f7dbd70d97 drm/amd/display: Hook DCN2 into amdgpu_dm and expose as config (v2)
date:   12 months ago
config: i386-randconfig-m021-20200617 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.c:233:6: warning: no previous prototype for 'dpp2_cnv_set_bias_scale' [-Wmissing-prototypes]
233 | void dpp2_cnv_set_bias_scale(
|      ^~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.c: In function 'dpp2_get_optimal_number_of_taps':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.c:350:11: warning: variable 'pixel_width' set but not used [-Wunused-but-set-variable]
350 |  uint32_t pixel_width;
|           ^~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.c:28:
At top level:
drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:120:22: warning: 'DP_DVI_CONVERTER_ID_4' defined but not used [-Wunused-const-variable=]
120 | static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
|                      ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:118:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
118 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
|                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:116:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
116 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
|                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:29,
from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:37,
from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.c:26:
drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
|                                ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
|                                ^~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
|                                ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
|                                ^~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
|                                ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:67:32: warning: 'dc_fixpt_zero' defined but not used [-Wunused-const-variable=]
67 | static const struct fixed31_32 dc_fixpt_zero = { 0 };
|                                ^~~~~~~~~~~~~
--
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dwb_scl.c:530:17: warning: no previous prototype for 'wbscl_get_filter_3tap_16p' [-Wmissing-prototypes]
530 | const uint16_t *wbscl_get_filter_3tap_16p(struct fixed31_32 ratio)
|                 ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dwb_scl.c:542:17: warning: no previous prototype for 'wbscl_get_filter_4tap_16p' [-Wmissing-prototypes]
542 | const uint16_t *wbscl_get_filter_4tap_16p(struct fixed31_32 ratio)
|                 ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dwb_scl.c: In function 'dwb_program_horz_scalar':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dwb_scl.c:725:11: warning: variable 'h_ratio_chroma' set but not used [-Wunused-but-set-variable]
725 |  uint32_t h_ratio_chroma = 1;
|           ^~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dwb_scl.c: In function 'dwb_program_vert_scalar':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dwb_scl.c:806:11: warning: variable 'v_ratio_chroma' set but not used [-Wunused-but-set-variable]
806 |  uint32_t v_ratio_chroma = 1;
|           ^~~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dwb_scl.c:28:
At top level:
drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:120:22: warning: 'DP_DVI_CONVERTER_ID_4' defined but not used [-Wunused-const-variable=]
120 | static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
|                      ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:118:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
118 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
|                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:116:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
116 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
|                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:29,
from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:37,
from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/reg_helper.h:28,
from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dwb_scl.c:26:
drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
|                                ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
|                                ^~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
|                                ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
|                                ^~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
|                                ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:67:32: warning: 'dc_fixpt_zero' defined but not used [-Wunused-const-variable=]
67 | static const struct fixed31_32 dc_fixpt_zero = { 0 };
|                                ^~~~~~~~~~~~~

vim +/pixel_width +350 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.c

f7de96ee8b5f4d Harry Wentland 2019-02-22  232  
f7de96ee8b5f4d Harry Wentland 2019-02-22 @233  void dpp2_cnv_set_bias_scale(
f7de96ee8b5f4d Harry Wentland 2019-02-22  234  		struct dpp *dpp_base,
f7de96ee8b5f4d Harry Wentland 2019-02-22  235  		struct  dc_bias_and_scale *bias_and_scale)
f7de96ee8b5f4d Harry Wentland 2019-02-22  236  {
f7de96ee8b5f4d Harry Wentland 2019-02-22  237  	struct dcn20_dpp *dpp = TO_DCN20_DPP(dpp_base);
f7de96ee8b5f4d Harry Wentland 2019-02-22  238  
f7de96ee8b5f4d Harry Wentland 2019-02-22  239  	REG_UPDATE(FCNV_FP_BIAS_R, FCNV_FP_BIAS_R, bias_and_scale->bias_red);
f7de96ee8b5f4d Harry Wentland 2019-02-22  240  	REG_UPDATE(FCNV_FP_BIAS_G, FCNV_FP_BIAS_G, bias_and_scale->bias_green);
f7de96ee8b5f4d Harry Wentland 2019-02-22  241  	REG_UPDATE(FCNV_FP_BIAS_B, FCNV_FP_BIAS_B, bias_and_scale->bias_blue);
f7de96ee8b5f4d Harry Wentland 2019-02-22  242  	REG_UPDATE(FCNV_FP_SCALE_R, FCNV_FP_SCALE_R, bias_and_scale->scale_red);
f7de96ee8b5f4d Harry Wentland 2019-02-22  243  	REG_UPDATE(FCNV_FP_SCALE_G, FCNV_FP_SCALE_G, bias_and_scale->scale_green);
f7de96ee8b5f4d Harry Wentland 2019-02-22  244  	REG_UPDATE(FCNV_FP_SCALE_B, FCNV_FP_SCALE_B, bias_and_scale->scale_blue);
f7de96ee8b5f4d Harry Wentland 2019-02-22  245  }
f7de96ee8b5f4d Harry Wentland 2019-02-22  246  
f7de96ee8b5f4d Harry Wentland 2019-02-22  247  /*compute the maximum number of lines that we can fit in the line buffer*/
f7de96ee8b5f4d Harry Wentland 2019-02-22  248  void dscl2_calc_lb_num_partitions(
f7de96ee8b5f4d Harry Wentland 2019-02-22  249  		const struct scaler_data *scl_data,
f7de96ee8b5f4d Harry Wentland 2019-02-22  250  		enum lb_memory_config lb_config,
f7de96ee8b5f4d Harry Wentland 2019-02-22  251  		int *num_part_y,
f7de96ee8b5f4d Harry Wentland 2019-02-22  252  		int *num_part_c)
f7de96ee8b5f4d Harry Wentland 2019-02-22  253  {
f7de96ee8b5f4d Harry Wentland 2019-02-22  254  	int line_size = scl_data->viewport.width < scl_data->recout.width ?
f7de96ee8b5f4d Harry Wentland 2019-02-22  255  			scl_data->viewport.width : scl_data->recout.width;
f7de96ee8b5f4d Harry Wentland 2019-02-22  256  	int line_size_c = scl_data->viewport_c.width < scl_data->recout.width ?
f7de96ee8b5f4d Harry Wentland 2019-02-22  257  			scl_data->viewport_c.width : scl_data->recout.width;
f7de96ee8b5f4d Harry Wentland 2019-02-22  258  	int memory_line_size_y = (line_size + 5) / 6; /* +5 to ceil */
f7de96ee8b5f4d Harry Wentland 2019-02-22  259  	int memory_line_size_c = (line_size_c + 5) / 6; /* +5 to ceil */
f7de96ee8b5f4d Harry Wentland 2019-02-22  260  	int memory_line_size_a = (line_size + 5) / 6; /* +5 to ceil */
f7de96ee8b5f4d Harry Wentland 2019-02-22  261  	int lb_memory_size, lb_memory_size_c, lb_memory_size_a, num_partitions_a;
f7de96ee8b5f4d Harry Wentland 2019-02-22  262  
f7de96ee8b5f4d Harry Wentland 2019-02-22  263  	if (lb_config == LB_MEMORY_CONFIG_1) {
f7de96ee8b5f4d Harry Wentland 2019-02-22  264  		lb_memory_size = 970;
f7de96ee8b5f4d Harry Wentland 2019-02-22  265  		lb_memory_size_c = 970;
f7de96ee8b5f4d Harry Wentland 2019-02-22  266  		lb_memory_size_a = 970;
f7de96ee8b5f4d Harry Wentland 2019-02-22  267  	} else if (lb_config == LB_MEMORY_CONFIG_2) {
f7de96ee8b5f4d Harry Wentland 2019-02-22  268  		lb_memory_size = 1290;
f7de96ee8b5f4d Harry Wentland 2019-02-22  269  		lb_memory_size_c = 1290;
f7de96ee8b5f4d Harry Wentland 2019-02-22  270  		lb_memory_size_a = 1290;
f7de96ee8b5f4d Harry Wentland 2019-02-22  271  	} else if (lb_config == LB_MEMORY_CONFIG_3) {
f7de96ee8b5f4d Harry Wentland 2019-02-22  272  		/* 420 mode: using 3rd mem from Y, Cr and Cb */
f7de96ee8b5f4d Harry Wentland 2019-02-22  273  		lb_memory_size = 970 + 1290 + 484 + 484 + 484;
f7de96ee8b5f4d Harry Wentland 2019-02-22  274  		lb_memory_size_c = 970 + 1290;
f7de96ee8b5f4d Harry Wentland 2019-02-22  275  		lb_memory_size_a = 970 + 1290 + 484;
f7de96ee8b5f4d Harry Wentland 2019-02-22  276  	} else {
f7de96ee8b5f4d Harry Wentland 2019-02-22  277  		lb_memory_size = 970 + 1290 + 484;
f7de96ee8b5f4d Harry Wentland 2019-02-22  278  		lb_memory_size_c = 970 + 1290 + 484;
f7de96ee8b5f4d Harry Wentland 2019-02-22  279  		lb_memory_size_a = 970 + 1290 + 484;
f7de96ee8b5f4d Harry Wentland 2019-02-22  280  	}
f7de96ee8b5f4d Harry Wentland 2019-02-22  281  	*num_part_y = lb_memory_size / memory_line_size_y;
f7de96ee8b5f4d Harry Wentland 2019-02-22  282  	*num_part_c = lb_memory_size_c / memory_line_size_c;
f7de96ee8b5f4d Harry Wentland 2019-02-22  283  	num_partitions_a = lb_memory_size_a / memory_line_size_a;
f7de96ee8b5f4d Harry Wentland 2019-02-22  284  
f7de96ee8b5f4d Harry Wentland 2019-02-22  285  	if (scl_data->lb_params.alpha_en
f7de96ee8b5f4d Harry Wentland 2019-02-22  286  			&& (num_partitions_a < *num_part_y))
f7de96ee8b5f4d Harry Wentland 2019-02-22  287  		*num_part_y = num_partitions_a;
f7de96ee8b5f4d Harry Wentland 2019-02-22  288  
f7de96ee8b5f4d Harry Wentland 2019-02-22  289  	if (*num_part_y > 64)
f7de96ee8b5f4d Harry Wentland 2019-02-22  290  		*num_part_y = 64;
f7de96ee8b5f4d Harry Wentland 2019-02-22  291  	if (*num_part_c > 64)
f7de96ee8b5f4d Harry Wentland 2019-02-22  292  		*num_part_c = 64;
f7de96ee8b5f4d Harry Wentland 2019-02-22  293  }
f7de96ee8b5f4d Harry Wentland 2019-02-22  294  
f7de96ee8b5f4d Harry Wentland 2019-02-22  295  void dpp2_cnv_set_alpha_keyer(
f7de96ee8b5f4d Harry Wentland 2019-02-22  296  		struct dpp *dpp_base,
f7de96ee8b5f4d Harry Wentland 2019-02-22  297  		struct cnv_color_keyer_params *color_keyer)
f7de96ee8b5f4d Harry Wentland 2019-02-22  298  {
f7de96ee8b5f4d Harry Wentland 2019-02-22  299  	struct dcn20_dpp *dpp = TO_DCN20_DPP(dpp_base);
f7de96ee8b5f4d Harry Wentland 2019-02-22  300  
f7de96ee8b5f4d Harry Wentland 2019-02-22  301  	REG_UPDATE(COLOR_KEYER_CONTROL, COLOR_KEYER_EN, color_keyer->color_keyer_en);
f7de96ee8b5f4d Harry Wentland 2019-02-22  302  
f7de96ee8b5f4d Harry Wentland 2019-02-22  303  	REG_UPDATE(COLOR_KEYER_CONTROL, COLOR_KEYER_MODE, color_keyer->color_keyer_mode);
f7de96ee8b5f4d Harry Wentland 2019-02-22  304  
f7de96ee8b5f4d Harry Wentland 2019-02-22  305  	REG_UPDATE(COLOR_KEYER_ALPHA, COLOR_KEYER_ALPHA_LOW, color_keyer->color_keyer_alpha_low);
f7de96ee8b5f4d Harry Wentland 2019-02-22  306  	REG_UPDATE(COLOR_KEYER_ALPHA, COLOR_KEYER_ALPHA_HIGH, color_keyer->color_keyer_alpha_high);
f7de96ee8b5f4d Harry Wentland 2019-02-22  307  
f7de96ee8b5f4d Harry Wentland 2019-02-22  308  	REG_UPDATE(COLOR_KEYER_RED, COLOR_KEYER_RED_LOW, color_keyer->color_keyer_red_low);
f7de96ee8b5f4d Harry Wentland 2019-02-22  309  	REG_UPDATE(COLOR_KEYER_RED, COLOR_KEYER_RED_HIGH, color_keyer->color_keyer_red_high);
f7de96ee8b5f4d Harry Wentland 2019-02-22  310  
f7de96ee8b5f4d Harry Wentland 2019-02-22  311  	REG_UPDATE(COLOR_KEYER_GREEN, COLOR_KEYER_GREEN_LOW, color_keyer->color_keyer_green_low);
f7de96ee8b5f4d Harry Wentland 2019-02-22  312  	REG_UPDATE(COLOR_KEYER_GREEN, COLOR_KEYER_GREEN_HIGH, color_keyer->color_keyer_green_high);
f7de96ee8b5f4d Harry Wentland 2019-02-22  313  
f7de96ee8b5f4d Harry Wentland 2019-02-22  314  	REG_UPDATE(COLOR_KEYER_BLUE, COLOR_KEYER_BLUE_LOW, color_keyer->color_keyer_blue_low);
f7de96ee8b5f4d Harry Wentland 2019-02-22  315  	REG_UPDATE(COLOR_KEYER_BLUE, COLOR_KEYER_BLUE_HIGH, color_keyer->color_keyer_blue_high);
f7de96ee8b5f4d Harry Wentland 2019-02-22  316  }
f7de96ee8b5f4d Harry Wentland 2019-02-22  317  
f7de96ee8b5f4d Harry Wentland 2019-02-22  318  void dpp2_set_cursor_attributes(
f7de96ee8b5f4d Harry Wentland 2019-02-22  319  		struct dpp *dpp_base,
f7de96ee8b5f4d Harry Wentland 2019-02-22  320  		enum dc_cursor_color_format color_format)
f7de96ee8b5f4d Harry Wentland 2019-02-22  321  {
f7de96ee8b5f4d Harry Wentland 2019-02-22  322  	struct dcn20_dpp *dpp = TO_DCN20_DPP(dpp_base);
f7de96ee8b5f4d Harry Wentland 2019-02-22  323  	int cur_rom_en = 0;
f7de96ee8b5f4d Harry Wentland 2019-02-22  324  
f7de96ee8b5f4d Harry Wentland 2019-02-22  325  	if (color_format == CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA ||
f7de96ee8b5f4d Harry Wentland 2019-02-22  326  		color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA)
f7de96ee8b5f4d Harry Wentland 2019-02-22  327  		cur_rom_en = 1;
f7de96ee8b5f4d Harry Wentland 2019-02-22  328  
f7de96ee8b5f4d Harry Wentland 2019-02-22  329  	REG_UPDATE_3(CURSOR0_CONTROL,
f7de96ee8b5f4d Harry Wentland 2019-02-22  330  			CUR0_MODE, color_format,
f7de96ee8b5f4d Harry Wentland 2019-02-22  331  			CUR0_EXPANSION_MODE, 0,
f7de96ee8b5f4d Harry Wentland 2019-02-22  332  			CUR0_ROM_EN, cur_rom_en);
f7de96ee8b5f4d Harry Wentland 2019-02-22  333  
f7de96ee8b5f4d Harry Wentland 2019-02-22  334  	if (color_format == CURSOR_MODE_MONO) {
f7de96ee8b5f4d Harry Wentland 2019-02-22  335  		/* todo: clarify what to program these to */
f7de96ee8b5f4d Harry Wentland 2019-02-22  336  		REG_UPDATE(CURSOR0_COLOR0,
f7de96ee8b5f4d Harry Wentland 2019-02-22  337  				CUR0_COLOR0, 0x00000000);
f7de96ee8b5f4d Harry Wentland 2019-02-22  338  		REG_UPDATE(CURSOR0_COLOR1,
f7de96ee8b5f4d Harry Wentland 2019-02-22  339  				CUR0_COLOR1, 0xFFFFFFFF);
f7de96ee8b5f4d Harry Wentland 2019-02-22  340  	}
f7de96ee8b5f4d Harry Wentland 2019-02-22  341  }
f7de96ee8b5f4d Harry Wentland 2019-02-22  342  
f7de96ee8b5f4d Harry Wentland 2019-02-22  343  #define IDENTITY_RATIO(ratio) (dc_fixpt_u3d19(ratio) == (1 << 19))
f7de96ee8b5f4d Harry Wentland 2019-02-22  344  
f7de96ee8b5f4d Harry Wentland 2019-02-22  345  bool dpp2_get_optimal_number_of_taps(
f7de96ee8b5f4d Harry Wentland 2019-02-22  346  		struct dpp *dpp,
f7de96ee8b5f4d Harry Wentland 2019-02-22  347  		struct scaler_data *scl_data,
f7de96ee8b5f4d Harry Wentland 2019-02-22  348  		const struct scaling_taps *in_taps)
f7de96ee8b5f4d Harry Wentland 2019-02-22  349  {
f7de96ee8b5f4d Harry Wentland 2019-02-22 @350  	uint32_t pixel_width;
f7de96ee8b5f4d Harry Wentland 2019-02-22  351  
f7de96ee8b5f4d Harry Wentland 2019-02-22  352  	if (scl_data->viewport.width > scl_data->recout.width)
f7de96ee8b5f4d Harry Wentland 2019-02-22  353  		pixel_width = scl_data->recout.width;
f7de96ee8b5f4d Harry Wentland 2019-02-22  354  	else
f7de96ee8b5f4d Harry Wentland 2019-02-22  355  		pixel_width = scl_data->viewport.width;
f7de96ee8b5f4d Harry Wentland 2019-02-22  356  
f7de96ee8b5f4d Harry Wentland 2019-02-22  357  	/* Some ASICs does not support  FP16 scaling, so we reject modes require this*/
f7de96ee8b5f4d Harry Wentland 2019-02-22  358  	if (scl_data->viewport.width  != scl_data->h_active &&
f7de96ee8b5f4d Harry Wentland 2019-02-22  359  		scl_data->viewport.height != scl_data->v_active &&
f7de96ee8b5f4d Harry Wentland 2019-02-22  360  		dpp->caps->dscl_data_proc_format == DSCL_DATA_PRCESSING_FIXED_FORMAT &&
f7de96ee8b5f4d Harry Wentland 2019-02-22  361  		scl_data->format == PIXEL_FORMAT_FP16)
f7de96ee8b5f4d Harry Wentland 2019-02-22  362  		return false;
f7de96ee8b5f4d Harry Wentland 2019-02-22  363  
f7de96ee8b5f4d Harry Wentland 2019-02-22  364  	if (scl_data->viewport.width > scl_data->h_active &&
f7de96ee8b5f4d Harry Wentland 2019-02-22  365  		dpp->ctx->dc->debug.max_downscale_src_width != 0 &&
f7de96ee8b5f4d Harry Wentland 2019-02-22  366  		scl_data->viewport.width > dpp->ctx->dc->debug.max_downscale_src_width)
f7de96ee8b5f4d Harry Wentland 2019-02-22  367  		return false;
f7de96ee8b5f4d Harry Wentland 2019-02-22  368  
f7de96ee8b5f4d Harry Wentland 2019-02-22  369  	/* TODO: add lb check */
f7de96ee8b5f4d Harry Wentland 2019-02-22  370  
f7de96ee8b5f4d Harry Wentland 2019-02-22  371  	/* No support for programming ratio of 8, drop to 7.99999.. */
f7de96ee8b5f4d Harry Wentland 2019-02-22  372  	if (scl_data->ratios.horz.value == (8ll << 32))
f7de96ee8b5f4d Harry Wentland 2019-02-22  373  		scl_data->ratios.horz.value--;
f7de96ee8b5f4d Harry Wentland 2019-02-22  374  	if (scl_data->ratios.vert.value == (8ll << 32))
f7de96ee8b5f4d Harry Wentland 2019-02-22  375  		scl_data->ratios.vert.value--;
f7de96ee8b5f4d Harry Wentland 2019-02-22  376  	if (scl_data->ratios.horz_c.value == (8ll << 32))
f7de96ee8b5f4d Harry Wentland 2019-02-22  377  		scl_data->ratios.horz_c.value--;
f7de96ee8b5f4d Harry Wentland 2019-02-22  378  	if (scl_data->ratios.vert_c.value == (8ll << 32))
f7de96ee8b5f4d Harry Wentland 2019-02-22  379  		scl_data->ratios.vert_c.value--;
f7de96ee8b5f4d Harry Wentland 2019-02-22  380  
f7de96ee8b5f4d Harry Wentland 2019-02-22  381  	/* Set default taps if none are provided */
f7de96ee8b5f4d Harry Wentland 2019-02-22  382  	if (in_taps->h_taps == 0) {
f7de96ee8b5f4d Harry Wentland 2019-02-22  383  		if (dc_fixpt_ceil(scl_data->ratios.horz) > 4)
f7de96ee8b5f4d Harry Wentland 2019-02-22  384  			scl_data->taps.h_taps = 8;
f7de96ee8b5f4d Harry Wentland 2019-02-22  385  		else
f7de96ee8b5f4d Harry Wentland 2019-02-22  386  			scl_data->taps.h_taps = 4;
f7de96ee8b5f4d Harry Wentland 2019-02-22  387  	} else
f7de96ee8b5f4d Harry Wentland 2019-02-22  388  		scl_data->taps.h_taps = in_taps->h_taps;
f7de96ee8b5f4d Harry Wentland 2019-02-22  389  	if (in_taps->v_taps == 0) {
f7de96ee8b5f4d Harry Wentland 2019-02-22  390  		if (dc_fixpt_ceil(scl_data->ratios.vert) > 4)
f7de96ee8b5f4d Harry Wentland 2019-02-22  391  			scl_data->taps.v_taps = 8;
f7de96ee8b5f4d Harry Wentland 2019-02-22  392  		else
f7de96ee8b5f4d Harry Wentland 2019-02-22  393  			scl_data->taps.v_taps = 4;
f7de96ee8b5f4d Harry Wentland 2019-02-22  394  	} else
f7de96ee8b5f4d Harry Wentland 2019-02-22  395  		scl_data->taps.v_taps = in_taps->v_taps;
f7de96ee8b5f4d Harry Wentland 2019-02-22  396  	if (in_taps->v_taps_c == 0) {
f7de96ee8b5f4d Harry Wentland 2019-02-22  397  		if (dc_fixpt_ceil(scl_data->ratios.vert_c) > 4)
f7de96ee8b5f4d Harry Wentland 2019-02-22  398  			scl_data->taps.v_taps_c = 4;
f7de96ee8b5f4d Harry Wentland 2019-02-22  399  		else
f7de96ee8b5f4d Harry Wentland 2019-02-22  400  			scl_data->taps.v_taps_c = 2;
f7de96ee8b5f4d Harry Wentland 2019-02-22  401  	} else
f7de96ee8b5f4d Harry Wentland 2019-02-22  402  		scl_data->taps.v_taps_c = in_taps->v_taps_c;
f7de96ee8b5f4d Harry Wentland 2019-02-22  403  	if (in_taps->h_taps_c == 0) {
f7de96ee8b5f4d Harry Wentland 2019-02-22  404  		if (dc_fixpt_ceil(scl_data->ratios.horz_c) > 4)
f7de96ee8b5f4d Harry Wentland 2019-02-22  405  			scl_data->taps.h_taps_c = 4;
f7de96ee8b5f4d Harry Wentland 2019-02-22  406  		else
f7de96ee8b5f4d Harry Wentland 2019-02-22  407  			scl_data->taps.h_taps_c = 2;
f7de96ee8b5f4d Harry Wentland 2019-02-22  408  	} else if ((in_taps->h_taps_c % 2) != 0 && in_taps->h_taps_c != 1)
f7de96ee8b5f4d Harry Wentland 2019-02-22  409  		/* Only 1 and even h_taps_c are supported by hw */
f7de96ee8b5f4d Harry Wentland 2019-02-22  410  		scl_data->taps.h_taps_c = in_taps->h_taps_c - 1;
f7de96ee8b5f4d Harry Wentland 2019-02-22  411  	else
f7de96ee8b5f4d Harry Wentland 2019-02-22  412  		scl_data->taps.h_taps_c = in_taps->h_taps_c;
f7de96ee8b5f4d Harry Wentland 2019-02-22  413  
f7de96ee8b5f4d Harry Wentland 2019-02-22  414  	if (!dpp->ctx->dc->debug.always_scale) {
f7de96ee8b5f4d Harry Wentland 2019-02-22  415  		if (IDENTITY_RATIO(scl_data->ratios.horz))
f7de96ee8b5f4d Harry Wentland 2019-02-22  416  			scl_data->taps.h_taps = 1;
f7de96ee8b5f4d Harry Wentland 2019-02-22  417  		if (IDENTITY_RATIO(scl_data->ratios.vert))
f7de96ee8b5f4d Harry Wentland 2019-02-22  418  			scl_data->taps.v_taps = 1;
f7de96ee8b5f4d Harry Wentland 2019-02-22  419  		if (IDENTITY_RATIO(scl_data->ratios.horz_c))
f7de96ee8b5f4d Harry Wentland 2019-02-22  420  			scl_data->taps.h_taps_c = 1;
f7de96ee8b5f4d Harry Wentland 2019-02-22  421  		if (IDENTITY_RATIO(scl_data->ratios.vert_c))
f7de96ee8b5f4d Harry Wentland 2019-02-22  422  			scl_data->taps.v_taps_c = 1;
f7de96ee8b5f4d Harry Wentland 2019-02-22  423  	}
f7de96ee8b5f4d Harry Wentland 2019-02-22  424  
f7de96ee8b5f4d Harry Wentland 2019-02-22  425  	return true;
f7de96ee8b5f4d Harry Wentland 2019-02-22  426  }
f7de96ee8b5f4d Harry Wentland 2019-02-22  427  

:::::: The code at line 350 was first introduced by commit
:::::: f7de96ee8b5f4d0d4ef7b00b8868049a6869a10f drm/amd/display: Add DCN2 DPP

:::::: TO: Harry Wentland <harry.wentland@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LZvS9be/3tNcYl/X
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
MuOg3NDaAQA=

--LZvS9be/3tNcYl/X--
