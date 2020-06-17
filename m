Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F51C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC4721527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFQQmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:42:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:38135 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgFQQmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:42:00 -0400
IronPort-SDR: SiTRg6v78PksDl3Pey37ZBUWxc/hBfEIGV8dCV9nfNjVAjKU5nlUM5NpE0iwGjCnvYVv1esr0t
 Y2f/2Yn19qTA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 09:40:53 -0700
IronPort-SDR: wylssqwC8kfv8nCMebQopP/LH74YSrw1OV7NVuEtkzoF3jXvqPA+SQIvptyyh/iWZLZLJ9qlOu
 /U22ebFE+QMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="gz'50?scan'50,208,50";a="352132719"
Received: from lkp-server02.sh.intel.com (HELO cd649bb48ab3) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2020 09:40:51 -0700
Received: from kbuild by cd649bb48ab3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jlb7K-00002L-1E; Wed, 17 Jun 2020 16:40:50 +0000
Date:   Thu, 18 Jun 2020 00:40:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Eric Yang <eric.yang2@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1389:63:
 warning: comparison of unsigned expression >= 0 is always true
Message-ID: <202006180040.TJEMicB6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69119673bd50b176ded34032fadd41530fb5af21
commit: 6eb3f7da3c332f23d4591063711b2a895ec2ab0f drm/amd/display: fix rn soc bb update
date:   7 weeks ago
config: i386-randconfig-s001-20200617 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-rc1-6-g78f577f8-dirty
        git checkout 6eb3f7da3c332f23d4591063711b2a895ec2ab0f
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=i386 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:13989:111: warning: initialized field overwritten [-Woverride-init]
13989 | #define CM0_CM_SHAPER_CONTROL__CM_SHAPER_LUT_MODE_MASK                                                        0x00000003L
|                                                                                                               ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.h:38:16: note: in expansion of macro 'CM0_CM_SHAPER_CONTROL__CM_SHAPER_LUT_MODE_MASK'
38 |  .field_name = reg_name ## __ ## field_name ## post_fix
|                ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:206:2: note: in expansion of macro 'TF_SF'
206 |  TF_SF(CM0_CM_SHAPER_CONTROL, CM_SHAPER_LUT_MODE, mask_sh)
|  ^~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:548:2: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20_UPDATED'
548 |  TF_REG_LIST_SH_MASK_DCN20_UPDATED(mask_sh),          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:666:3: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20'
666 |   TF_REG_LIST_SH_MASK_DCN20(_MASK),
|   ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:13989:111: note: (near initialization for 'tf_mask.CM_SHAPER_LUT_MODE')
13989 | #define CM0_CM_SHAPER_CONTROL__CM_SHAPER_LUT_MODE_MASK                                                        0x00000003L
|                                                                                                               ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.h:38:16: note: in expansion of macro 'CM0_CM_SHAPER_CONTROL__CM_SHAPER_LUT_MODE_MASK'
38 |  .field_name = reg_name ## __ ## field_name ## post_fix
|                ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:206:2: note: in expansion of macro 'TF_SF'
206 |  TF_SF(CM0_CM_SHAPER_CONTROL, CM_SHAPER_LUT_MODE, mask_sh)
|  ^~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:548:2: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20_UPDATED'
548 |  TF_REG_LIST_SH_MASK_DCN20_UPDATED(mask_sh),          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:666:3: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20'
666 |   TF_REG_LIST_SH_MASK_DCN20(_MASK),
|   ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:33815:111: warning: initialized field overwritten [-Woverride-init]
33815 | #define DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT                                              0x1f
|                                                                                                               ^~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro 'DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT'
214 |  .field_name = reg_name ## __ ## field_name ## post_fix
|                ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:204:2: note: in expansion of macro 'AUX_SF'
204 |  AUX_SF(DP_AUX0_AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),         |  ^~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:684:2: note: in expansion of macro 'DCN_AUX_MASK_SH_LIST'
684 |  DCN_AUX_MASK_SH_LIST(__SHIFT)
|  ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:33815:111: note: (near initialization for 'aux_shift.AUX_SW_AUTOINCREMENT_DISABLE')
33815 | #define DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT                                              0x1f
|                                                                                                               ^~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro 'DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT'
214 |  .field_name = reg_name ## __ ## field_name ## post_fix
|                ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:204:2: note: in expansion of macro 'AUX_SF'
204 |  AUX_SF(DP_AUX0_AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),         |  ^~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:684:2: note: in expansion of macro 'DCN_AUX_MASK_SH_LIST'
684 |  DCN_AUX_MASK_SH_LIST(__SHIFT)
|  ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:33819:111: warning: initialized field overwritten [-Woverride-init]
33819 | #define DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK                                                0x80000000L
|                                                                                                               ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro 'DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK'
214 |  .field_name = reg_name ## __ ## field_name ## post_fix
|                ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:204:2: note: in expansion of macro 'AUX_SF'
204 |  AUX_SF(DP_AUX0_AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),         |  ^~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:688:2: note: in expansion of macro 'DCN_AUX_MASK_SH_LIST'
688 |  DCN_AUX_MASK_SH_LIST(_MASK)
|  ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:33819:111: note: (near initialization for 'aux_mask.AUX_SW_AUTOINCREMENT_DISABLE')
33819 | #define DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK                                                0x80000000L
|                                                                                                               ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro 'DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK'
214 |  .field_name = reg_name ## __ ## field_name ## post_fix
|                ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:204:2: note: in expansion of macro 'AUX_SF'
204 |  AUX_SF(DP_AUX0_AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),         |  ^~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:688:2: note: in expansion of macro 'DCN_AUX_MASK_SH_LIST'
688 |  DCN_AUX_MASK_SH_LIST(_MASK)
|  ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:777:20: warning: no previous prototype for 'dcn21_i2c_hw_create' [-Wmissing-prototypes]
777 | struct dce_i2c_hw *dcn21_i2c_hw_create(
|                    ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1078:6: warning: no previous prototype for 'dcn21_calculate_wm' [-Wmissing-prototypes]
1078 | void dcn21_calculate_wm(
|      ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1163:6: warning: no previous prototype for 'dcn21_validate_bandwidth' [-Wmissing-prototypes]
1163 | bool dcn21_validate_bandwidth(struct dc *dc, struct dc_state *context,
|      ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1293:32: warning: no previous prototype for 'dcn21_opp_create' [-Wmissing-prototypes]
1293 | struct output_pixel_processor *dcn21_opp_create(
|                                ^~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1309:26: warning: no previous prototype for 'dcn21_timing_generator_create' [-Wmissing-prototypes]
1309 | struct timing_generator *dcn21_timing_generator_create(
|                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1331:13: warning: no previous prototype for 'dcn21_mpc_create' [-Wmissing-prototypes]
1331 | struct mpc *dcn21_mpc_create(struct dc_context *ctx)
|             ^~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1358:35: warning: no previous prototype for 'dcn21_dsc_create' [-Wmissing-prototypes]
1358 | struct display_stream_compressor *dcn21_dsc_create(
|                                   ^~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: In function 'update_bw_bounding_box':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1389:63: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
1389 |    for (closest_clk_lvl = 0, j = dcn2_1_soc.num_states - 1; j >= 0; j--) {
|                                                               ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: At top level:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1502:24: warning: no previous prototype for 'dcn21_stream_encoder_create' [-Wmissing-prototypes]
1502 | struct stream_encoder *dcn21_stream_encoder_create(
|                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:70:
drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:489:52: warning: initialized field overwritten [-Woverride-init]
489 | #define DMU_BASE__INST0_SEG2                       0x000034C0
|                                                    ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:319:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
319 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
|                         ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:321:19: note: in expansion of macro 'BASE_INNER'
321 | #define BASE(seg) BASE_INNER(seg)
|                   ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:324:15: note: in expansion of macro 'BASE'
324 |   .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +           |               ^~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:157:2: note: in expansion of macro 'SR'
157 |  SR(DCFCLK_CNTL),          |  ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:280:2: note: in expansion of macro 'HWSEQ_DCN_REG_LIST'
280 |  HWSEQ_DCN_REG_LIST(),          |  ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1520:3: note: in expansion of macro 'HWSEQ_DCN21_REG_LIST'
1520 |   HWSEQ_DCN21_REG_LIST()
|   ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:489:52: note: (near initialization for 'hwseq_reg.DCFCLK_CNTL')
489 | #define DMU_BASE__INST0_SEG2                       0x000034C0
|                                                    ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:319:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
319 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
|                         ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:321:19: note: in expansion of macro 'BASE_INNER'
321 | #define BASE(seg) BASE_INNER(seg)
|                   ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:324:15: note: in expansion of macro 'BASE'
324 |   .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +           |               ^~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:157:2: note: in expansion of macro 'SR'
157 |  SR(DCFCLK_CNTL),          |  ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:280:2: note: in expansion of macro 'HWSEQ_DCN_REG_LIST'
280 |  HWSEQ_DCN_REG_LIST(),          |  ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1520:3: note: in expansion of macro 'HWSEQ_DCN21_REG_LIST'
1520 |   HWSEQ_DCN21_REG_LIST()
|   ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:72:
drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:43237:111: warning: initialized field overwritten [-Woverride-init]
43237 | #define LVTMA_PWRSEQ_CNTL__LVTMA_BLON__SHIFT                                                                  0x18
|                                                                                                               ^~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:439:28: note: in expansion of macro 'LVTMA_PWRSEQ_CNTL__LVTMA_BLON__SHIFT'
439 |  .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
|                            ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:676:2: note: in expansion of macro 'HWS_SF'
676 |  HWS_SF(, LVTMA_PWRSEQ_CNTL, LVTMA_BLON, mask_sh),          |  ^~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1524:3: note: in expansion of macro 'HWSEQ_DCN21_MASK_SH_LIST'
1524 |   HWSEQ_DCN21_MASK_SH_LIST(__SHIFT)
|   ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:43237:111: note: (near initialization for 'hwseq_shift.LVTMA_BLON')
43237 | #define LVTMA_PWRSEQ_CNTL__LVTMA_BLON__SHIFT                                                                  0x18
|                                                                                                               ^~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:439:28: note: in expansion of macro 'LVTMA_PWRSEQ_CNTL__LVTMA_BLON__SHIFT'
439 |  .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
|                            ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:676:2: note: in expansion of macro 'HWS_SF'
676 |  HWS_SF(, LVTMA_PWRSEQ_CNTL, LVTMA_BLON, mask_sh),          |  ^~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1524:3: note: in expansion of macro 'HWSEQ_DCN21_MASK_SH_LIST'
1524 |   HWSEQ_DCN21_MASK_SH_LIST(__SHIFT)
|   ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:43253:111: warning: initialized field overwritten [-Woverride-init]
43253 | #define LVTMA_PWRSEQ_STATE__LVTMA_PWRSEQ_TARGET_STATE_R__SHIFT                                                0x0
|                                                                                                               ^~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:439:28: note: in expansion of macro 'LVTMA_PWRSEQ_STATE__LVTMA_PWRSEQ_TARGET_STATE_R__SHIFT'
439 |  .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
|                            ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:677:2: note: in expansion of macro 'HWS_SF'
677 |  HWS_SF(, LVTMA_PWRSEQ_STATE, LVTMA_PWRSEQ_TARGET_STATE_R, mask_sh)
|  ^~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1524:3: note: in expansion of macro 'HWSEQ_DCN21_MASK_SH_LIST'
1524 |   HWSEQ_DCN21_MASK_SH_LIST(__SHIFT)
|   ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:43253:111: note: (near initialization for 'hwseq_shift.LVTMA_PWRSEQ_TARGET_STATE_R')
43253 | #define LVTMA_PWRSEQ_STATE__LVTMA_PWRSEQ_TARGET_STATE_R__SHIFT                                                0x0
|                                                                                                               ^~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:439:28: note: in expansion of macro 'LVTMA_PWRSEQ_STATE__LVTMA_PWRSEQ_TARGET_STATE_R__SHIFT'
439 |  .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
|                            ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:677:2: note: in expansion of macro 'HWS_SF'
677 |  HWS_SF(, LVTMA_PWRSEQ_STATE, LVTMA_PWRSEQ_TARGET_STATE_R, mask_sh)
|  ^~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1524:3: note: in expansion of macro 'HWSEQ_DCN21_MASK_SH_LIST'
1524 |   HWSEQ_DCN21_MASK_SH_LIST(__SHIFT)
|   ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:43249:111: warning: initialized field overwritten [-Woverride-init]
43249 | #define LVTMA_PWRSEQ_CNTL__LVTMA_BLON_MASK                                                                    0x01000000L

vim +1389 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c

  1330	
> 1331	struct mpc *dcn21_mpc_create(struct dc_context *ctx)
  1332	{
  1333		struct dcn20_mpc *mpc20 = kzalloc(sizeof(struct dcn20_mpc),
  1334						  GFP_KERNEL);
  1335	
  1336		if (!mpc20)
  1337			return NULL;
  1338	
  1339		dcn20_mpc_construct(mpc20, ctx,
  1340				&mpc_regs,
  1341				&mpc_shift,
  1342				&mpc_mask,
  1343				6);
  1344	
  1345		return &mpc20->base;
  1346	}
  1347	
  1348	static void read_dce_straps(
  1349		struct dc_context *ctx,
  1350		struct resource_straps *straps)
  1351	{
  1352		generic_reg_get(ctx, mmDC_PINSTRAPS + BASE(mmDC_PINSTRAPS_BASE_IDX),
  1353			FN(DC_PINSTRAPS, DC_PINSTRAPS_AUDIO), &straps->dc_pinstraps_audio);
  1354	
  1355	}
  1356	
  1357	
  1358	struct display_stream_compressor *dcn21_dsc_create(
  1359		struct dc_context *ctx, uint32_t inst)
  1360	{
  1361		struct dcn20_dsc *dsc =
  1362			kzalloc(sizeof(struct dcn20_dsc), GFP_KERNEL);
  1363	
  1364		if (!dsc) {
  1365			BREAK_TO_DEBUGGER();
  1366			return NULL;
  1367		}
  1368	
  1369		dsc2_construct(dsc, ctx, inst, &dsc_regs[inst], &dsc_shift, &dsc_mask);
  1370		return &dsc->base;
  1371	}
  1372	
  1373	static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
  1374	{
  1375		struct dcn21_resource_pool *pool = TO_DCN21_RES_POOL(dc->res_pool);
  1376		struct clk_limit_table *clk_table = &bw_params->clk_table;
  1377		struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
  1378		unsigned int i, j, closest_clk_lvl;
  1379	
  1380		// Default clock levels are used for diags, which may lead to overclocking.
  1381		if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
  1382			dcn2_1_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
  1383			dcn2_1_ip.max_num_dpp = pool->base.pipe_count;
  1384			dcn2_1_soc.num_chans = bw_params->num_channels;
  1385	
  1386			ASSERT(clk_table->num_entries);
  1387			for (i = 0; i < clk_table->num_entries; i++) {
  1388				/* loop backwards*/
> 1389				for (closest_clk_lvl = 0, j = dcn2_1_soc.num_states - 1; j >= 0; j--) {
  1390					if ((unsigned int) dcn2_1_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
  1391						closest_clk_lvl = j;
  1392						break;
  1393					}
  1394				}
  1395	
  1396				clock_limits[i].state = i;
  1397				clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
  1398				clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
  1399				clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
  1400				clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
  1401	
  1402				clock_limits[i].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
  1403				clock_limits[i].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
  1404				clock_limits[i].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
  1405				clock_limits[i].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
  1406				clock_limits[i].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
  1407				clock_limits[i].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
  1408				clock_limits[i].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
  1409			}
  1410			for (i = 0; i < clk_table->num_entries; i++)
  1411				dcn2_1_soc.clock_limits[i] = clock_limits[i];
  1412			if (clk_table->num_entries) {
  1413				dcn2_1_soc.num_states = clk_table->num_entries;
  1414				/* duplicate last level */
  1415				dcn2_1_soc.clock_limits[dcn2_1_soc.num_states] = dcn2_1_soc.clock_limits[dcn2_1_soc.num_states - 1];
  1416				dcn2_1_soc.clock_limits[dcn2_1_soc.num_states].state = dcn2_1_soc.num_states;
  1417			}
  1418		}
  1419	
  1420		dml_init_instance(&dc->dml, &dcn2_1_soc, &dcn2_1_ip, DML_PROJECT_DCN21);
  1421	}
  1422	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
IKKdpcxLHi+VWUY9/A+W5oo/tBUCAA==

--82I3+IH0IqGh5yIs--
