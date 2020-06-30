Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D43EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1AC20722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgF3W7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:59:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:53932 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgF3W7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:59:12 -0400
IronPort-SDR: RvqgGLLB/dHZxrvsspJ2FSs63aWd8I0omQcbccMmNojI/fOHP5dEwK/vXV2H+Q0CvkfVHu5pBa
 MOCt6szNU3AQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="211465133"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="gz'50?scan'50,208,50";a="211465133"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 15:59:04 -0700
IronPort-SDR: P4lCpKwXELC0ZRIVdnBe6vBHHBeFUqGPRYPk7Pm8gGzKCS3MsQRwKwV6ZWAD2GYIsWOGgrIs+V
 KA+9LSFtmnKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="gz'50?scan'50,208,50";a="355920178"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2020 15:59:01 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jqPDQ-00027y-N1; Tue, 30 Jun 2020 22:59:00 +0000
Date:   Wed, 1 Jul 2020 06:58:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lee Jones <lee.jones@linaro.org>, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        George Zhang <georgezhang@vmware.com>
Subject: Re: [PATCH 07/30] misc: vmw_vmci_defs: 'struct vmci_handle
 VMCI_ANON_SRC_HANDLE' cannot be static
Message-ID: <202007010632.SMoao6XE%lkp@intel.com>
References: <20200630135110.2236389-8-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20200630135110.2236389-8-lee.jones@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lee,

I love your patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on soc/for-next usb/usb-testing linus/master v5.8-rc3 next-20200630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Lee-Jones/Last-batch-of-patches-to-clean-up-Misc/20200630-215625
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git ba2104c24aba1fa7e19d53f08c985526a6786d8b
config: i386-randconfig-m021-20200630 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld: drivers/misc/vmw_vmci/vmci_datagram.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_doorbell.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_driver.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_event.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_guest.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_handle_array.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_host.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_queue_pair.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_resource.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_route.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   make[4]: *** [scripts/Makefile.build:431: drivers/misc/vmw_vmci/vmw_vmci.o] Error 1
   make[4]: Target '__build' not remade because of errors.
--
>> ld: drivers/misc/vmw_vmci/vmci_datagram.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_doorbell.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_driver.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_event.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_guest.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_handle_array.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_host.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_queue_pair.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_resource.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_route.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
--
   drivers/net/ethernet/intel/e1000/e1000_hw.c:2930: warning: Excess function parameter 'data' description in 'e1000_write_phy_reg'
   drivers/net/ethernet/intel/e1000/e1000_hw.c:4788: warning: Excess function parameter 'tx_packets' description in 'e1000_update_adaptive'
   drivers/net/ethernet/intel/e1000/e1000_hw.c:4788: warning: Excess function parameter 'total_collisions' description in 'e1000_update_adaptive'
   drivers/net/ethernet/intel/e1000/e1000_hw.c:5079: warning: Excess function parameter 'downshift' description in 'e1000_check_downshift'
   In file included from drivers/gpu/drm/amd/amdgpu/atombios_dp.c:29:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:190:18: warning: 'sched_policy' defined but not used [-Wunused-const-variable=]
     190 | static const int sched_policy = KFD_SCHED_POLICY_HWS;
         |                  ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/atombios_dp.c:29:
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
   drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'spi' not described in 'spi_test_execute_msg'
   drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'test' not described in 'spi_test_execute_msg'
   drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'tx' not described in 'spi_test_execute_msg'
   drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'rx' not described in 'spi_test_execute_msg'
   drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'spi' not described in 'spi_test_run_test'
   drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'test' not described in 'spi_test_run_test'
   drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'tx' not described in 'spi_test_run_test'
   drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'rx' not described in 'spi_test_run_test'
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c:30:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:190:18: warning: 'sched_policy' defined but not used [-Wunused-const-variable=]
     190 | static const int sched_policy = KFD_SCHED_POLICY_HWS;
         |                  ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c:30:
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
   lib/decompress_unlzo.c: In function 'parse_header':
   lib/decompress_unlzo.c:46:5: warning: variable 'level' set but not used [-Wunused-but-set-variable]
      46 |  u8 level = 0;
         |     ^~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c:26:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:190:18: warning: 'sched_policy' defined but not used [-Wunused-const-variable=]
     190 | static const int sched_policy = KFD_SCHED_POLICY_HWS;
         |                  ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c:26:
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
   lib/dump_stack.c:86: warning: cannot understand function prototype: 'atomic_t dump_lock = ATOMIC_INIT(-1); '
   drivers/gpu/drm/gma500/cdv_intel_crt.c:138: warning: Function parameter or member 'connector' not described in 'cdv_intel_crt_detect_hotplug'
   drivers/gpu/drm/gma500/cdv_intel_crt.c:138: warning: Function parameter or member 'force' not described in 'cdv_intel_crt_detect_hotplug'
>> ld: drivers/misc/vmw_vmci/vmci_datagram.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_doorbell.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_driver.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_event.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_guest.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_handle_array.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_host.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_queue_pair.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_resource.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_route.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   make[4]: *** [scripts/Makefile.build:431: drivers/misc/vmw_vmci/vmw_vmci.o] Error 1
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/misc/vmw_vmci] Error 2
   drivers/acpi/video_detect.c:486:13: warning: no previous prototype for 'acpi_video_detect_exit' [-Wmissing-prototypes]
     486 | void __exit acpi_video_detect_exit(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/gma500/cdv_intel_display.c:559: warning: Function parameter or member 'dev' not described in 'cdv_intel_panel_fitter_pipe'
   drivers/acpi/acpi_video.c:2238:6: warning: no previous prototype for 'acpi_video_unregister_backlight' [-Wmissing-prototypes]
    2238 | void acpi_video_unregister_backlight(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/atombios_encoders.c: In function 'amdgpu_atombios_encoder_init_backlight':
   drivers/gpu/drm/amd/amdgpu/atombios_encoders.c:174:5: warning: variable 'backlight_level' set but not used [-Wunused-but-set-variable]
     174 |  u8 backlight_level;
         |     ^~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/atombios_encoders.c:31:
   At top level:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:190:18: warning: 'sched_policy' defined but not used [-Wunused-const-variable=]
     190 | static const int sched_policy = KFD_SCHED_POLICY_HWS;
         |                  ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/atombios_encoders.c:31:
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
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c:45:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:190:18: warning: 'sched_policy' defined but not used [-Wunused-const-variable=]
     190 | static const int sched_policy = KFD_SCHED_POLICY_HWS;
         |                  ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c:45:
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
   In file included from drivers/gpu/drm/amd/amdgpu/atombios_i2c.c:27:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:190:18: warning: 'sched_policy' defined but not used [-Wunused-const-variable=]
     190 | static const int sched_policy = KFD_SCHED_POLICY_HWS;
         |                  ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/atombios_i2c.c:27:
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
--
     910 | void __init early_xdbc_register_console(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/early/xhci-dbc.c:10: warning: Function parameter or member 'fmt' not described in 'pr_fmt'
   drivers/net/ethernet/intel/e1000/e1000_hw.c:1907: warning: Excess function parameter 'mii_reg' description in 'e1000_config_mac_to_phy'
   drivers/net/ethernet/intel/e1000/e1000_hw.c:2930: warning: Function parameter or member 'phy_data' not described in 'e1000_write_phy_reg'
   drivers/net/ethernet/intel/e1000/e1000_hw.c:2930: warning: Excess function parameter 'data' description in 'e1000_write_phy_reg'
   drivers/net/ethernet/intel/e1000/e1000_hw.c:4788: warning: Excess function parameter 'tx_packets' description in 'e1000_update_adaptive'
   drivers/net/ethernet/intel/e1000/e1000_hw.c:4788: warning: Excess function parameter 'total_collisions' description in 'e1000_update_adaptive'
   drivers/net/ethernet/intel/e1000/e1000_hw.c:5079: warning: Excess function parameter 'downshift' description in 'e1000_check_downshift'
   In file included from drivers/gpu/drm/amd/amdgpu/atombios_dp.c:29:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:190:18: warning: 'sched_policy' defined but not used [-Wunused-const-variable=]
     190 | static const int sched_policy = KFD_SCHED_POLICY_HWS;
         |                  ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/atombios_dp.c:29:
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
   drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'spi' not described in 'spi_test_execute_msg'
   drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'test' not described in 'spi_test_execute_msg'
   drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'tx' not described in 'spi_test_execute_msg'
   drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'rx' not described in 'spi_test_execute_msg'
   drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'spi' not described in 'spi_test_run_test'
   drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'test' not described in 'spi_test_run_test'
   drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'tx' not described in 'spi_test_run_test'
   drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'rx' not described in 'spi_test_run_test'
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c:30:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:190:18: warning: 'sched_policy' defined but not used [-Wunused-const-variable=]
     190 | static const int sched_policy = KFD_SCHED_POLICY_HWS;
         |                  ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c:30:
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
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c:26:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:190:18: warning: 'sched_policy' defined but not used [-Wunused-const-variable=]
     190 | static const int sched_policy = KFD_SCHED_POLICY_HWS;
         |                  ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c:26:
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
   drivers/gpu/drm/gma500/cdv_intel_crt.c:138: warning: Function parameter or member 'connector' not described in 'cdv_intel_crt_detect_hotplug'
   drivers/gpu/drm/gma500/cdv_intel_crt.c:138: warning: Function parameter or member 'force' not described in 'cdv_intel_crt_detect_hotplug'
>> ld: drivers/misc/vmw_vmci/vmci_datagram.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_doorbell.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_driver.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_event.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_guest.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_handle_array.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_host.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_queue_pair.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_resource.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   ld: drivers/misc/vmw_vmci/vmci_route.o:include/linux/vmw_vmci_defs.h:162: multiple definition of `VMCI_ANON_SRC_HANDLE'; drivers/misc/vmw_vmci/vmci_context.o:include/linux/vmw_vmci_defs.h:162: first defined here
   make[4]: *** [scripts/Makefile.build:431: drivers/misc/vmw_vmci/vmw_vmci.o] Error 1
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/misc/vmw_vmci] Error 2
   drivers/acpi/video_detect.c:486:13: warning: no previous prototype for 'acpi_video_detect_exit' [-Wmissing-prototypes]
     486 | void __exit acpi_video_detect_exit(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/gma500/cdv_intel_display.c:559: warning: Function parameter or member 'dev' not described in 'cdv_intel_panel_fitter_pipe'
   drivers/acpi/acpi_video.c:2238:6: warning: no previous prototype for 'acpi_video_unregister_backlight' [-Wmissing-prototypes]
    2238 | void acpi_video_unregister_backlight(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/atombios_encoders.c: In function 'amdgpu_atombios_encoder_init_backlight':
   drivers/gpu/drm/amd/amdgpu/atombios_encoders.c:174:5: warning: variable 'backlight_level' set but not used [-Wunused-but-set-variable]
     174 |  u8 backlight_level;
         |     ^~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/atombios_encoders.c:31:
   At top level:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:190:18: warning: 'sched_policy' defined but not used [-Wunused-const-variable=]
     190 | static const int sched_policy = KFD_SCHED_POLICY_HWS;
         |                  ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/atombios_encoders.c:31:
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
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c:45:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:190:18: warning: 'sched_policy' defined but not used [-Wunused-const-variable=]
     190 | static const int sched_policy = KFD_SCHED_POLICY_HWS;
         |                  ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c:45:
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
   In file included from drivers/gpu/drm/amd/amdgpu/atombios_i2c.c:27:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:190:18: warning: 'sched_policy' defined but not used [-Wunused-const-variable=]
     190 | static const int sched_policy = KFD_SCHED_POLICY_HWS;
         |                  ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/atombios_i2c.c:27:
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
..

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--M9NhX3UHpAaciwkO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
wsiCaP0arA8Qju11d8pQy4a/camnmKnjAQA=

--M9NhX3UHpAaciwkO--
