Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C294C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A3F206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgIKFaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 01:30:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:59433 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgIKFap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 01:30:45 -0400
IronPort-SDR: C1ha/mHtdS8Mhk14arAOFbOKJhg6JOkTJ/uhoM9fEvNf0xcVmDXwTHmr1THK7x9jhxO2kcgQMR
 pyPQCS0hUPkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="220249921"
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="scan'208";a="220249921"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 22:30:28 -0700
IronPort-SDR: +Z5c09609o4fGLdH/hLsMaksbnKzzWwVcFhQalSoaB2aanohu2V88B7raqaoSuZHNtE/eamaos
 fBQG+YkXfiow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="scan'208";a="481188459"
Received: from lkp-server01.sh.intel.com (HELO a75722977aa5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Sep 2020 22:30:27 -0700
Received: from kbuild by a75722977aa5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kGbdi-000042-HR; Fri, 11 Sep 2020 05:30:26 +0000
Date:   Fri, 11 Sep 2020 13:30:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 0a4bb5e5507a585532cc413125b921c8546fc39f
Message-ID: <5f5b0b5b.u+Hi737FvD2zZxrZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/fpu
branch HEAD: 0a4bb5e5507a585532cc413125b921c8546fc39f  x86/fpu: Allow multiple bits in clearcpuid= parameter

elapsed time: 725m

configs tested: 203
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        qi_lb60_defconfig
mips                           rs90_defconfig
mips                       lemote2f_defconfig
riscv                          rv32_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                            lart_defconfig
powerpc                      ppc64e_defconfig
arm                           omap1_defconfig
powerpc                      acadia_defconfig
arm                        trizeps4_defconfig
arm                     davinci_all_defconfig
sh                         apsh4a3a_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                       cns3420vb_defconfig
sparc64                             defconfig
arm                             pxa_defconfig
mips                           ip28_defconfig
openrisc                         alldefconfig
arc                     haps_hs_smp_defconfig
arm                          prima2_defconfig
mips                      pistachio_defconfig
arm                           efm32_defconfig
arm                       aspeed_g4_defconfig
mips                         tb0226_defconfig
mips                          ath79_defconfig
arm                      integrator_defconfig
mips                           ip22_defconfig
mips                            e55_defconfig
powerpc                     ksi8560_defconfig
ia64                             alldefconfig
sh                          lboxre2_defconfig
mips                        workpad_defconfig
mips                           gcw0_defconfig
sh                          sdk7780_defconfig
openrisc                    or1ksim_defconfig
arm                          imote2_defconfig
mips                      pic32mzda_defconfig
riscv                            alldefconfig
arm                           h5000_defconfig
xtensa                           allyesconfig
arm                       omap2plus_defconfig
h8300                    h8300h-sim_defconfig
mips                            gpr_defconfig
mips                         bigsur_defconfig
mips                          malta_defconfig
arm                            xcep_defconfig
sh                        sh7785lcr_defconfig
sh                        sh7757lcr_defconfig
arm                         axm55xx_defconfig
sh                        edosk7760_defconfig
arc                         haps_hs_defconfig
arm                          simpad_defconfig
arm                         socfpga_defconfig
arm                     am200epdkit_defconfig
sh                           se7343_defconfig
arm                         ebsa110_defconfig
powerpc                    adder875_defconfig
powerpc                     asp8347_defconfig
arm                         s3c2410_defconfig
mips                     cu1830-neo_defconfig
arm                         lubbock_defconfig
s390                             alldefconfig
mips                          ath25_defconfig
h8300                     edosk2674_defconfig
powerpc                   bluestone_defconfig
powerpc                 mpc837x_mds_defconfig
arm                            u300_defconfig
xtensa                           alldefconfig
arc                          axs101_defconfig
nios2                         3c120_defconfig
powerpc                     powernv_defconfig
sh                ecovec24-romimage_defconfig
ia64                            zx1_defconfig
powerpc                 mpc8272_ads_defconfig
sparc                               defconfig
sh                               allmodconfig
powerpc                mpc7448_hpc2_defconfig
m68k                                defconfig
powerpc                     pseries_defconfig
arm                      pxa255-idp_defconfig
arm                         mv78xx0_defconfig
arm                          ixp4xx_defconfig
mips                 pnx8335_stb225_defconfig
c6x                        evmc6472_defconfig
arm                          lpd270_defconfig
powerpc                     ep8248e_defconfig
powerpc                     taishan_defconfig
mips                      loongson3_defconfig
microblaze                    nommu_defconfig
arc                          axs103_defconfig
xtensa                generic_kc705_defconfig
arm                         s5pv210_defconfig
arm                              alldefconfig
s390                       zfcpdump_defconfig
powerpc                  storcenter_defconfig
powerpc64                        alldefconfig
mips                         cobalt_defconfig
mips                         rt305x_defconfig
sh                          kfr2r09_defconfig
arc                        nsim_700_defconfig
arm                        mvebu_v7_defconfig
arm                           h3600_defconfig
powerpc                     rainier_defconfig
sh                        apsh4ad0a_defconfig
arm                        multi_v5_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
x86_64               randconfig-a004-20200910
x86_64               randconfig-a006-20200910
x86_64               randconfig-a003-20200910
x86_64               randconfig-a002-20200910
x86_64               randconfig-a005-20200910
x86_64               randconfig-a001-20200910
i386                 randconfig-a004-20200909
i386                 randconfig-a005-20200909
i386                 randconfig-a006-20200909
i386                 randconfig-a002-20200909
i386                 randconfig-a001-20200909
i386                 randconfig-a003-20200909
i386                 randconfig-a004-20200911
i386                 randconfig-a006-20200911
i386                 randconfig-a001-20200911
i386                 randconfig-a003-20200911
i386                 randconfig-a002-20200911
i386                 randconfig-a005-20200911
i386                 randconfig-a004-20200910
i386                 randconfig-a006-20200910
i386                 randconfig-a001-20200910
i386                 randconfig-a003-20200910
i386                 randconfig-a002-20200910
i386                 randconfig-a005-20200910
x86_64               randconfig-a014-20200911
x86_64               randconfig-a011-20200911
x86_64               randconfig-a012-20200911
x86_64               randconfig-a016-20200911
x86_64               randconfig-a015-20200911
x86_64               randconfig-a013-20200911
i386                 randconfig-a015-20200911
i386                 randconfig-a014-20200911
i386                 randconfig-a011-20200911
i386                 randconfig-a013-20200911
i386                 randconfig-a016-20200911
i386                 randconfig-a012-20200911
i386                 randconfig-a016-20200909
i386                 randconfig-a015-20200909
i386                 randconfig-a011-20200909
i386                 randconfig-a013-20200909
i386                 randconfig-a014-20200909
i386                 randconfig-a012-20200909
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20200911
x86_64               randconfig-a006-20200911
x86_64               randconfig-a003-20200911
x86_64               randconfig-a002-20200911
x86_64               randconfig-a005-20200911
x86_64               randconfig-a001-20200911
x86_64               randconfig-a013-20200909
x86_64               randconfig-a016-20200909
x86_64               randconfig-a011-20200909
x86_64               randconfig-a012-20200909
x86_64               randconfig-a015-20200909
x86_64               randconfig-a014-20200909

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
