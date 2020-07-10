Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ABCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C8932076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgGJUG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:06:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:28542 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgGJUG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:06:27 -0400
IronPort-SDR: vXZTOoLMDYgSgRepnduDJ1R2aduZJ6D1+ccSVAECxbtTpfGrRjXIt1Pq2Af5wSDsOA6LbCArtp
 UmD7YrbSx1FQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="128341438"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="gz'50?scan'50,208,50";a="128341438"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 12:19:17 -0700
IronPort-SDR: pnCj3rHUDbOq4E9GTOZWVO2HB7ALtoQZ88Q3qBfqlnfkCu692uoQuTYr4OgeSwXHdcrfQiGaNL
 dpbCx6K33peA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="gz'50?scan'50,208,50";a="269164625"
Received: from lkp-server02.sh.intel.com (HELO 0fc60ea15964) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jul 2020 12:19:15 -0700
Received: from kbuild by 0fc60ea15964 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtyYE-00010s-Tg; Fri, 10 Jul 2020 19:19:14 +0000
Date:   Sat, 11 Jul 2020 03:19:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Timothy Pearson <tpearson@raptorengineering.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error:
 implicit declaration of function 'enable_kernel_vsx'; did you mean
Message-ID: <202007110349.yRqe1JEu%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42f82040ee66db13525dc6f14b8559890b2f4c1c
commit: 16a9dea110a67d62401ffeac4828cabdedec7548 amdgpu: Enable initial DCN support on POWER
date:   7 months ago
config: powerpc64-randconfig-r016-20200710 (attached as .config)
compiler: powerpc64le-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 16a9dea110a67d62401ffeac4828cabdedec7548
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:37,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:27:
   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: In function 'dcn_bw_apply_registry_override':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error: implicit declaration of function 'enable_kernel_vsx'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
      64 |   enable_kernel_vsx(); \
         |   ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:626:2: note: in expansion of macro 'DC_FP_START'
     626 |  DC_FP_START();
         |  ^~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:67:3: error: implicit declaration of function 'enable_kernel_altivec'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
      67 |   enable_kernel_altivec(); \
         |   ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:626:2: note: in expansion of macro 'DC_FP_START'
     626 |  DC_FP_START();
         |  ^~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:75:3: error: implicit declaration of function 'disable_kernel_vsx'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
      75 |   disable_kernel_vsx(); \
         |   ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:662:2: note: in expansion of macro 'DC_FP_END'
     662 |  DC_FP_END();
         |  ^~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:78:3: error: implicit declaration of function 'disable_kernel_altivec'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
      78 |   disable_kernel_altivec(); \
         |   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:662:2: note: in expansion of macro 'DC_FP_END'
     662 |  DC_FP_END();
         |  ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:706:14: warning: no previous prototype for 'get_highest_allowed_voltage_level' [-Wmissing-prototypes]
     706 | unsigned int get_highest_allowed_voltage_level(uint32_t hw_internal_rev)
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:32:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_DVI_CONVERTER_ID_4' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:122:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
     122 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:120:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
     120 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:37,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:27:
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
   cc1: some warnings being treated as errors
--
     852 |  DSC_REG_LIST_SH_MASK_DCN20(__SHIFT)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_0_sh_mask.h:50949:111: warning: initialized field overwritten [-Woverride-init]
   50949 | #define DSCCIF0_DSCCIF_CONFIG1__PIC_WIDTH_MASK                                                                0x0000FFFFL
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dsc.h:88:16: note: in expansion of macro 'DSCCIF0_DSCCIF_CONFIG1__PIC_WIDTH_MASK'
      88 |  .field_name = reg_name ## __ ## field_name ## post_fix
         |                ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dsc.h:262:2: note: in expansion of macro 'DSC_SF'
     262 |  DSC_SF(DSCCIF0_DSCCIF_CONFIG1, PIC_WIDTH, mask_sh), \
         |  ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:856:2: note: in expansion of macro 'DSC_REG_LIST_SH_MASK_DCN20'
     856 |  DSC_REG_LIST_SH_MASK_DCN20(_MASK)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_0_sh_mask.h:50949:111: note: (near initialization for 'dsc_mask.PIC_WIDTH')
   50949 | #define DSCCIF0_DSCCIF_CONFIG1__PIC_WIDTH_MASK                                                                0x0000FFFFL
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dsc.h:88:16: note: in expansion of macro 'DSCCIF0_DSCCIF_CONFIG1__PIC_WIDTH_MASK'
      88 |  .field_name = reg_name ## __ ## field_name ## post_fix
         |                ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dsc.h:262:2: note: in expansion of macro 'DSC_SF'
     262 |  DSC_SF(DSCCIF0_DSCCIF_CONFIG1, PIC_WIDTH, mask_sh), \
         |  ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:856:2: note: in expansion of macro 'DSC_REG_LIST_SH_MASK_DCN20'
     856 |  DSC_REG_LIST_SH_MASK_DCN20(_MASK)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_0_sh_mask.h:50950:111: warning: initialized field overwritten [-Woverride-init]
   50950 | #define DSCCIF0_DSCCIF_CONFIG1__PIC_HEIGHT_MASK                                                               0xFFFF0000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dsc.h:88:16: note: in expansion of macro 'DSCCIF0_DSCCIF_CONFIG1__PIC_HEIGHT_MASK'
      88 |  .field_name = reg_name ## __ ## field_name ## post_fix
         |                ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dsc.h:263:2: note: in expansion of macro 'DSC_SF'
     263 |  DSC_SF(DSCCIF0_DSCCIF_CONFIG1, PIC_HEIGHT, mask_sh), \
         |  ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:856:2: note: in expansion of macro 'DSC_REG_LIST_SH_MASK_DCN20'
     856 |  DSC_REG_LIST_SH_MASK_DCN20(_MASK)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_0_sh_mask.h:50950:111: note: (near initialization for 'dsc_mask.PIC_HEIGHT')
   50950 | #define DSCCIF0_DSCCIF_CONFIG1__PIC_HEIGHT_MASK                                                               0xFFFF0000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dsc.h:88:16: note: in expansion of macro 'DSCCIF0_DSCCIF_CONFIG1__PIC_HEIGHT_MASK'
      88 |  .field_name = reg_name ## __ ## field_name ## post_fix
         |                ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dsc.h:263:2: note: in expansion of macro 'DSC_SF'
     263 |  DSC_SF(DSCCIF0_DSCCIF_CONFIG1, PIC_HEIGHT, mask_sh), \
         |  ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:856:2: note: in expansion of macro 'DSC_REG_LIST_SH_MASK_DCN20'
     856 |  DSC_REG_LIST_SH_MASK_DCN20(_MASK)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:1168:22: warning: no previous prototype for 'dcn20_clock_source_create' [-Wmissing-prototypes]
    1168 | struct clock_source *dcn20_clock_source_create(
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:65:
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:269:52: warning: initialized field overwritten [-Woverride-init]
     269 | #define DCN_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:372:25: note: in expansion of macro 'DCN_BASE__INST0_SEG2'
     372 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:374:19: note: in expansion of macro 'BASE_INNER'
     374 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:377:15: note: in expansion of macro 'BASE'
     377 |   .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |               ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:157:2: note: in expansion of macro 'SR'
     157 |  SR(DCFCLK_CNTL), \
         |  ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:214:2: note: in expansion of macro 'HWSEQ_DCN_REG_LIST'
     214 |  HWSEQ_DCN_REG_LIST(), \
         |  ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:1230:3: note: in expansion of macro 'HWSEQ_DCN2_REG_LIST'
    1230 |   HWSEQ_DCN2_REG_LIST()
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:269:52: note: (near initialization for 'hwseq_reg.DCFCLK_CNTL')
     269 | #define DCN_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:372:25: note: in expansion of macro 'DCN_BASE__INST0_SEG2'
     372 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:374:19: note: in expansion of macro 'BASE_INNER'
     374 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:377:15: note: in expansion of macro 'BASE'
     377 |   .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |               ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:157:2: note: in expansion of macro 'SR'
     157 |  SR(DCFCLK_CNTL), \
         |  ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:214:2: note: in expansion of macro 'HWSEQ_DCN_REG_LIST'
     214 |  HWSEQ_DCN_REG_LIST(), \
         |  ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:1230:3: note: in expansion of macro 'HWSEQ_DCN2_REG_LIST'
    1230 |   HWSEQ_DCN2_REG_LIST()
         |   ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:37,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:29:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: In function 'dcn20_patch_bounding_box':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error: implicit declaration of function 'enable_kernel_vsx'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
      64 |   enable_kernel_vsx(); \
         |   ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:3215:2: note: in expansion of macro 'DC_FP_START'
    3215 |  DC_FP_START();
         |  ^~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:67:3: error: implicit declaration of function 'enable_kernel_altivec'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
      67 |   enable_kernel_altivec(); \
         |   ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:3215:2: note: in expansion of macro 'DC_FP_START'
    3215 |  DC_FP_START();
         |  ^~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:75:3: error: implicit declaration of function 'disable_kernel_vsx'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
      75 |   disable_kernel_vsx(); \
         |   ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:3239:2: note: in expansion of macro 'DC_FP_END'
    3239 |  DC_FP_END();
         |  ^~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:78:3: error: implicit declaration of function 'disable_kernel_altivec'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
      78 |   disable_kernel_altivec(); \
         |   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:3239:2: note: in expansion of macro 'DC_FP_END'
    3239 |  DC_FP_END();
         |  ^~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:80:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:283:23: warning: 'abm_gain_stepsize' defined but not used [-Wunused-const-variable=]
     283 | static const uint32_t abm_gain_stepsize = 0x0060;
         |                       ^~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:65:
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:133:29: warning: 'VCN_BASE' defined but not used [-Wunused-const-variable=]
     133 | static const struct IP_BASE VCN_BASE            ={ { { { 0x00007800, 0x00007E00, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:127:29: warning: 'UMC_BASE' defined but not used [-Wunused-const-variable=]
     127 | static const struct IP_BASE UMC_BASE            ={ { { { 0x00014000, 0, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:121:29: warning: 'THM_BASE' defined but not used [-Wunused-const-variable=]
     121 | static const struct IP_BASE THM_BASE            ={ { { { 0x00016600, 0, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:115:29: warning: 'SMUIO_BASE' defined but not used [-Wunused-const-variable=]
     115 | static const struct IP_BASE SMUIO_BASE            ={ { { { 0x00016800, 0x00016A00, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:109:29: warning: 'RSMU_BASE' defined but not used [-Wunused-const-variable=]
     109 | static const struct IP_BASE RSMU_BASE   = { { { { 0x00012000, 0, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:103:29: warning: 'OSSSYS_BASE' defined but not used [-Wunused-const-variable=]
     103 | static const struct IP_BASE OSSSYS_BASE            ={ { { { 0x000010A0, 0, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:97:29: warning: 'NBIO_BASE' defined but not used [-Wunused-const-variable=]
      97 | static const struct IP_BASE NBIO_BASE            ={ { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:91:29: warning: 'MP1_BASE' defined but not used [-Wunused-const-variable=]
      91 | static const struct IP_BASE MP1_BASE            ={ { { { 0x00016000, 0, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:85:29: warning: 'MP0_BASE' defined but not used [-Wunused-const-variable=]
      85 | static const struct IP_BASE MP0_BASE            ={ { { { 0x00016000, 0, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:79:29: warning: 'MMHUB_BASE' defined but not used [-Wunused-const-variable=]
      79 | static const struct IP_BASE MMHUB_BASE            ={ { { { 0x0001A000, 0, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:73:29: warning: 'HDP_BASE' defined but not used [-Wunused-const-variable=]
      73 | static const struct IP_BASE HDP_BASE            ={ { { { 0x00000F20, 0, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:67:29: warning: 'GC_BASE' defined but not used [-Wunused-const-variable=]
      67 | static const struct IP_BASE GC_BASE            ={ { { { 0x00001260, 0x0000A000, 0, 0, 0, 0 } },
         |                             ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:61:29: warning: 'FUSE_BASE' defined but not used [-Wunused-const-variable=]
      61 | static const struct IP_BASE FUSE_BASE            ={ { { { 0x00017400, 0, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:55:29: warning: 'DCN_BASE' defined but not used [-Wunused-const-variable=]
      55 | static const struct IP_BASE DCN_BASE            ={ { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:49:29: warning: 'DF_BASE' defined but not used [-Wunused-const-variable=]
      49 | static const struct IP_BASE DF_BASE            ={ { { { 0x00007000, 0, 0, 0, 0, 0 } },
         |                             ^~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:65:
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:43:29: warning: 'CLK_BASE' defined but not used [-Wunused-const-variable=]
      43 | static const struct IP_BASE CLK_BASE            ={ { { { 0x00016C00, 0x00016E00, 0x00017000, 0x00017200, 0x00017E00, 0x0001B000 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:37:29: warning: 'ATHUB_BASE' defined but not used [-Wunused-const-variable=]
      37 | static const struct IP_BASE ATHUB_BASE            ={ { { { 0x00000C00, 0, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:34:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_DVI_CONVERTER_ID_4' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:122:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
     122 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:120:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
     120 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:37,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:29:
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
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:14403:111: note: (near initialization for 'tf_mask.CM_3DLUT_MODE')
   14403 | #define CM0_CM_3DLUT_MODE__CM_3DLUT_MODE_MASK                                                                 0x00000003L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.h:38:16: note: in expansion of macro 'CM0_CM_3DLUT_MODE__CM_3DLUT_MODE_MASK'
      38 |  .field_name = reg_name ## __ ## field_name ## post_fix
         |                ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:358:2: note: in expansion of macro 'TF_SF'
     358 |  TF_SF(CM0_CM_3DLUT_MODE, CM_3DLUT_MODE, mask_sh), \
         |  ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:537:2: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20_COMMON'
     537 |  TF_REG_LIST_SH_MASK_DCN20_COMMON(mask_sh), \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:623:3: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20'
     623 |   TF_REG_LIST_SH_MASK_DCN20(_MASK)
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:13989:111: warning: initialized field overwritten [-Woverride-init]
   13989 | #define CM0_CM_SHAPER_CONTROL__CM_SHAPER_LUT_MODE_MASK                                                        0x00000003L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.h:38:16: note: in expansion of macro 'CM0_CM_SHAPER_CONTROL__CM_SHAPER_LUT_MODE_MASK'
      38 |  .field_name = reg_name ## __ ## field_name ## post_fix
         |                ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:196:2: note: in expansion of macro 'TF_SF'
     196 |  TF_SF(CM0_CM_SHAPER_CONTROL, CM_SHAPER_LUT_MODE, mask_sh)
         |  ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:538:2: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20_UPDATED'
     538 |  TF_REG_LIST_SH_MASK_DCN20_UPDATED(mask_sh), \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:623:3: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20'
     623 |   TF_REG_LIST_SH_MASK_DCN20(_MASK)
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:13989:111: note: (near initialization for 'tf_mask.CM_SHAPER_LUT_MODE')
   13989 | #define CM0_CM_SHAPER_CONTROL__CM_SHAPER_LUT_MODE_MASK                                                        0x00000003L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.h:38:16: note: in expansion of macro 'CM0_CM_SHAPER_CONTROL__CM_SHAPER_LUT_MODE_MASK'
      38 |  .field_name = reg_name ## __ ## field_name ## post_fix
         |                ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:196:2: note: in expansion of macro 'TF_SF'
     196 |  TF_SF(CM0_CM_SHAPER_CONTROL, CM_SHAPER_LUT_MODE, mask_sh)
         |  ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:538:2: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20_UPDATED'
     538 |  TF_REG_LIST_SH_MASK_DCN20_UPDATED(mask_sh), \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:623:3: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20'
     623 |   TF_REG_LIST_SH_MASK_DCN20(_MASK)
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:33815:111: warning: initialized field overwritten [-Woverride-init]
   33815 | #define DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT                                              0x1f
         |                                                                                                               ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro 'DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT'
     214 |  .field_name = reg_name ## __ ## field_name ## post_fix
         |                ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:204:2: note: in expansion of macro 'AUX_SF'
     204 |  AUX_SF(DP_AUX0_AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
         |  ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:640:2: note: in expansion of macro 'DCN_AUX_MASK_SH_LIST'
     640 |  DCN_AUX_MASK_SH_LIST(__SHIFT)
         |  ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:33815:111: note: (near initialization for 'aux_shift.AUX_SW_AUTOINCREMENT_DISABLE')
   33815 | #define DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT                                              0x1f
         |                                                                                                               ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro 'DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT'
     214 |  .field_name = reg_name ## __ ## field_name ## post_fix
         |                ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:204:2: note: in expansion of macro 'AUX_SF'
     204 |  AUX_SF(DP_AUX0_AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
         |  ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:640:2: note: in expansion of macro 'DCN_AUX_MASK_SH_LIST'
     640 |  DCN_AUX_MASK_SH_LIST(__SHIFT)
         |  ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:33819:111: warning: initialized field overwritten [-Woverride-init]
   33819 | #define DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK                                                0x80000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro 'DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK'
     214 |  .field_name = reg_name ## __ ## field_name ## post_fix
         |                ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:204:2: note: in expansion of macro 'AUX_SF'
     204 |  AUX_SF(DP_AUX0_AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
         |  ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:644:2: note: in expansion of macro 'DCN_AUX_MASK_SH_LIST'
     644 |  DCN_AUX_MASK_SH_LIST(_MASK)
         |  ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:33819:111: note: (near initialization for 'aux_mask.AUX_SW_AUTOINCREMENT_DISABLE')
   33819 | #define DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK                                                0x80000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro 'DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK'
     214 |  .field_name = reg_name ## __ ## field_name ## post_fix
         |                ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:204:2: note: in expansion of macro 'AUX_SF'
     204 |  AUX_SF(DP_AUX0_AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
         |  ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:644:2: note: in expansion of macro 'DCN_AUX_MASK_SH_LIST'
     644 |  DCN_AUX_MASK_SH_LIST(_MASK)
         |  ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:733:20: warning: no previous prototype for 'dcn21_i2c_hw_create' [-Wmissing-prototypes]
     733 | struct dce_i2c_hw *dcn21_i2c_hw_create(
         |                    ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:37,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:29:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: In function 'patch_bounding_box':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error: implicit declaration of function 'enable_kernel_vsx'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
      64 |   enable_kernel_vsx(); \
         |   ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:997:2: note: in expansion of macro 'DC_FP_START'
     997 |  DC_FP_START();
         |  ^~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:67:3: error: implicit declaration of function 'enable_kernel_altivec'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
      67 |   enable_kernel_altivec(); \
         |   ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:997:2: note: in expansion of macro 'DC_FP_START'
     997 |  DC_FP_START();
         |  ^~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:75:3: error: implicit declaration of function 'disable_kernel_vsx'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
      75 |   disable_kernel_vsx(); \
         |   ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1024:2: note: in expansion of macro 'DC_FP_END'
    1024 |  DC_FP_END();
         |  ^~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:78:3: error: implicit declaration of function 'disable_kernel_altivec'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
      78 |   disable_kernel_altivec(); \
         |   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1024:2: note: in expansion of macro 'DC_FP_END'
    1024 |  DC_FP_END();
         |  ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1027:6: warning: no previous prototype for 'dcn21_calculate_wm' [-Wmissing-prototypes]
    1027 | void dcn21_calculate_wm(
         |      ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1112:6: warning: no previous prototype for 'dcn21_validate_bandwidth' [-Wmissing-prototypes]
    1112 | bool dcn21_validate_bandwidth(struct dc *dc, struct dc_state *context,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1242:32: warning: no previous prototype for 'dcn21_opp_create' [-Wmissing-prototypes]
    1242 | struct output_pixel_processor *dcn21_opp_create(
         |                                ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1258:26: warning: no previous prototype for 'dcn21_timing_generator_create' [-Wmissing-prototypes]
    1258 | struct timing_generator *dcn21_timing_generator_create(
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1280:13: warning: no previous prototype for 'dcn21_mpc_create' [-Wmissing-prototypes]
    1280 | struct mpc *dcn21_mpc_create(struct dc_context *ctx)
         |             ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1307:35: warning: no previous prototype for 'dcn21_dsc_create' [-Wmissing-prototypes]
    1307 | struct display_stream_compressor *dcn21_dsc_create(
         |                                   ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1430:24: warning: no previous prototype for 'dcn21_stream_encoder_create' [-Wmissing-prototypes]
    1430 | struct stream_encoder *dcn21_stream_encoder_create(
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:67:
   drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:489:52: warning: initialized field overwritten [-Woverride-init]
     489 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:281:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     281 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:283:19: note: in expansion of macro 'BASE_INNER'
     283 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:286:15: note: in expansion of macro 'BASE'
     286 |   .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |               ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:157:2: note: in expansion of macro 'SR'
     157 |  SR(DCFCLK_CNTL), \
         |  ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:280:2: note: in expansion of macro 'HWSEQ_DCN_REG_LIST'
     280 |  HWSEQ_DCN_REG_LIST(), \
         |  ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1448:3: note: in expansion of macro 'HWSEQ_DCN21_REG_LIST'
    1448 |   HWSEQ_DCN21_REG_LIST()
         |   ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:489:52: note: (near initialization for 'hwseq_reg.DCFCLK_CNTL')
     489 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:281:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     281 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:283:19: note: in expansion of macro 'BASE_INNER'
     283 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:286:15: note: in expansion of macro 'BASE'
     286 |   .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |               ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:157:2: note: in expansion of macro 'SR'
     157 |  SR(DCFCLK_CNTL), \
         |  ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:280:2: note: in expansion of macro 'HWSEQ_DCN_REG_LIST'
     280 |  HWSEQ_DCN_REG_LIST(), \
         |  ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1448:3: note: in expansion of macro 'HWSEQ_DCN21_REG_LIST'
    1448 |   HWSEQ_DCN21_REG_LIST()
         |   ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:69:
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:43237:111: warning: initialized field overwritten [-Woverride-init]
   43237 | #define LVTMA_PWRSEQ_CNTL__LVTMA_BLON__SHIFT                                                                  0x18
         |                                                                                                               ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:439:28: note: in expansion of macro 'LVTMA_PWRSEQ_CNTL__LVTMA_BLON__SHIFT'
     439 |  .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                            ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:676:2: note: in expansion of macro 'HWS_SF'
     676 |  HWS_SF(, LVTMA_PWRSEQ_CNTL, LVTMA_BLON, mask_sh), \
         |  ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1452:3: note: in expansion of macro 'HWSEQ_DCN21_MASK_SH_LIST'
    1452 |   HWSEQ_DCN21_MASK_SH_LIST(__SHIFT)
         |   ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:43237:111: note: (near initialization for 'hwseq_shift.LVTMA_BLON')
   43237 | #define LVTMA_PWRSEQ_CNTL__LVTMA_BLON__SHIFT                                                                  0x18
         |                                                                                                               ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:439:28: note: in expansion of macro 'LVTMA_PWRSEQ_CNTL__LVTMA_BLON__SHIFT'
     439 |  .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                            ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:676:2: note: in expansion of macro 'HWS_SF'
     676 |  HWS_SF(, LVTMA_PWRSEQ_CNTL, LVTMA_BLON, mask_sh), \
         |  ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:1452:3: note: in expansion of macro 'HWSEQ_DCN21_MASK_SH_LIST'
    1452 |   HWSEQ_DCN21_MASK_SH_LIST(__SHIFT)
         |   ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h:43253:111: warning: initialized field overwritten [-Woverride-init]
   43253 | #define LVTMA_PWRSEQ_STATE__LVTMA_PWRSEQ_TARGET_STATE_R__SHIFT                                                0x0
         |                                                                                                               ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:439:28: note: in expansion of macro 'LVTMA_PWRSEQ_STATE__LVTMA_PWRSEQ_TARGET_STATE_R__SHIFT'
     439 |  .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix

vim +64 drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h

    52	
    53	#if defined(CONFIG_DRM_AMD_DC_DCN)
    54	#if defined(CONFIG_X86)
    55	#include <asm/fpu/api.h>
    56	#define DC_FP_START() kernel_fpu_begin()
    57	#define DC_FP_END() kernel_fpu_end()
    58	#elif defined(CONFIG_PPC64)
    59	#include <asm/switch_to.h>
    60	#include <asm/cputable.h>
    61	#define DC_FP_START() { \
    62		if (cpu_has_feature(CPU_FTR_VSX_COMP)) { \
    63			preempt_disable(); \
  > 64			enable_kernel_vsx(); \
    65		} else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) { \
    66			preempt_disable(); \
  > 67			enable_kernel_altivec(); \
    68		} else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE)) { \
    69			preempt_disable(); \
    70			enable_kernel_fp(); \
    71		} \
    72	}
    73	#define DC_FP_END() { \
    74		if (cpu_has_feature(CPU_FTR_VSX_COMP)) { \
  > 75			disable_kernel_vsx(); \
    76			preempt_enable(); \
    77		} else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) { \
  > 78			disable_kernel_altivec(); \
    79			preempt_enable(); \
    80		} else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE)) { \
    81			disable_kernel_fp(); \
    82			preempt_enable(); \
    83		} \
    84	}
    85	#endif
    86	#endif
    87	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--OXfL5xGRrasGEqWY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
4g2MXtEhuTexNTzGTjLx/wfv4IDgOcoBAA==

--OXfL5xGRrasGEqWY--
