Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1156CC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B152F206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgIDHud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:50:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:60216 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgIDHuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:50:32 -0400
IronPort-SDR: 99K7FhnBFCqbwCyCzODxQgIMv0zQ8lormByYHGbTi1as3OEY9JFEYQ04XP8SxbD0dQQhiraokT
 AZJlgJQVhXlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="156970594"
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; 
   d="gz'50?scan'50,208,50";a="156970594"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 00:50:28 -0700
IronPort-SDR: KOMvUS1DIruO5ZdGNF+cFqLM6ufpMNC2gx6EmYqFjAeMZfj8Q22ERgM7hdawa8QsSF7+FHwxac
 uH8J8p2U7pLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; 
   d="gz'50?scan'50,208,50";a="447210321"
Received: from lkp-server02.sh.intel.com (HELO c089623da072) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Sep 2020 00:50:25 -0700
Received: from kbuild by c089623da072 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kE6UK-00001u-Ld; Fri, 04 Sep 2020 07:50:24 +0000
Date:   Fri, 4 Sep 2020 15:49:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Timothy Pearson <tpearson@raptorengineering.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:67:3: error:
 implicit declaration of function 'enable_kernel_altivec'; did you mean
Message-ID: <202009041554.fLSg0jLM%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Timothy,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   59126901f200f5fc907153468b03c64e0081b6e6
commit: 16a9dea110a67d62401ffeac4828cabdedec7548 amdgpu: Enable initial DCN support on POWER
date:   9 months ago
config: powerpc-randconfig-r024-20200904 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 16a9dea110a67d62401ffeac4828cabdedec7548
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:37,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:27:
   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: In function 'dcn_bw_apply_registry_override':
   drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error: implicit declaration of function 'enable_kernel_vsx'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
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
   drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:75:3: error: implicit declaration of function 'disable_kernel_vsx'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
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
   drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error: implicit declaration of function 'enable_kernel_vsx'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
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
   drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:75:3: error: implicit declaration of function 'disable_kernel_vsx'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
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
   drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error: implicit declaration of function 'enable_kernel_vsx'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
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
   drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:75:3: error: implicit declaration of function 'disable_kernel_vsx'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
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

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=16a9dea110a67d62401ffeac4828cabdedec7548
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 16a9dea110a67d62401ffeac4828cabdedec7548
vim +67 drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h

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
    64			enable_kernel_vsx(); \
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
    75			disable_kernel_vsx(); \
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

--YiEDa0DAkWCtVeE4
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
2AEA

--YiEDa0DAkWCtVeE4--
