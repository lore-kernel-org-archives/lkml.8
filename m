Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EC5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 19:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C04206D4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 19:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgHATF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 15:05:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:28451 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHATF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 15:05:58 -0400
IronPort-SDR: JBYJzdquF35WTtmwjHxHTpA7+/KmyCc+ooVEDcjPY6DIXGsAPJOL71hz0u3xDRjQ/HXl8c9o4U
 JB+jnVIERxcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9700"; a="236818900"
X-IronPort-AV: E=Sophos;i="5.75,423,1589266800"; 
   d="gz'50?scan'50,208,50";a="236818900"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2020 11:30:43 -0700
IronPort-SDR: DbGve76ng0kkgeK0VVGpXc9AfXs/RWFea6ArUBToMaXoSetXqw+lE8D0EhfzwaypNPOnxeS6Q8
 7VL0TnCAJ9+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,423,1589266800"; 
   d="gz'50?scan'50,208,50";a="365897833"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Aug 2020 11:30:40 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1wHH-0000aI-SB; Sat, 01 Aug 2020 18:30:39 +0000
Date:   Sun, 2 Aug 2020 02:30:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Timothy Pearson <tpearson@raptorengineering.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error:
 implicit declaration of function 'enable_kernel_vsx'; did you mean
Message-ID: <202008020202.bWzHZUOk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Timothy,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7dc6fd0f3b8404542718039f5de19fe56e474578
commit: 16a9dea110a67d62401ffeac4828cabdedec7548 amdgpu: Enable initial DCN support on POWER
date:   8 months ago
config: powerpc64-randconfig-r015-20200801 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
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
   drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:62:6: error: implicit declaration of function 'cpu_has_feature'; did you mean 'mmu_has_feature'? [-Werror=implicit-function-declaration]
      62 |  if (cpu_has_feature(CPU_FTR_VSX_COMP)) { \
         |      ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:626:2: note: in expansion of macro 'DC_FP_START'
     626 |  DC_FP_START();
         |  ^~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error: implicit declaration of function 'enable_kernel_vsx'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
      64 |   enable_kernel_vsx(); \
         |   ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:626:2: note: in expansion of macro 'DC_FP_START'
     626 |  DC_FP_START();
         |  ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:67:3: error: implicit declaration of function 'enable_kernel_altivec'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
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
   drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:78:3: error: implicit declaration of function 'disable_kernel_altivec'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
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
   drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:67:3: error: implicit declaration of function 'enable_kernel_altivec'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
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
   drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:78:3: error: implicit declaration of function 'disable_kernel_altivec'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
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
   drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:67:3: error: implicit declaration of function 'enable_kernel_altivec'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
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
   drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:78:3: error: implicit declaration of function 'disable_kernel_altivec'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
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
    78			disable_kernel_altivec(); \
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

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--C7zPtVaVf+AK4Oqc--
