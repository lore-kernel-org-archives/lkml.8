Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8E2C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14FA020709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgICVzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:55:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:11232 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgICVzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:55:39 -0400
IronPort-SDR: z4xGDIq0ktzLAjvSM7NCUNHM2QOP3oIhZORvPv+7Kn61y+dcKfM0KLqzULsyF+c0N9HEZwUsAq
 faM/LIKaQd/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="219217286"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="219217286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 14:55:38 -0700
IronPort-SDR: jSghI+3LnhkT+hIFwIE3ZMrfazmo8jRckscL2RlEGF/vuwqRbK1VjfaVzKc8tX634u8pa3eTu7
 g7zM30xT8ulA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="478215989"
Received: from lkp-server01.sh.intel.com (HELO f1af165c0d27) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Sep 2020 14:55:37 -0700
Received: from kbuild by f1af165c0d27 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kDxCi-0000Fr-FP; Thu, 03 Sep 2020 21:55:36 +0000
Date:   Fri, 04 Sep 2020 05:54:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 23870f1227680d2aacff6f79c3ab2222bd04e86e
Message-ID: <5f516628.KuNJgFl8ZKt6QXIt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/urgent
branch HEAD: 23870f1227680d2aacff6f79c3ab2222bd04e86e  locking/lockdep: Fix "USED" <- "IN-NMI" inversions

elapsed time: 722m

configs tested: 171
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                         ps3_defconfig
arm                             mxs_defconfig
powerpc                      ppc6xx_defconfig
mips                         rt305x_defconfig
nios2                            alldefconfig
sh                          polaris_defconfig
arm                          gemini_defconfig
arc                        nsim_700_defconfig
arm                       cns3420vb_defconfig
arm                         vf610m4_defconfig
ia64                         bigsur_defconfig
xtensa                           alldefconfig
arm                              zx_defconfig
microblaze                          defconfig
mips                        vocore2_defconfig
mips                      maltasmvp_defconfig
powerpc                      ppc44x_defconfig
m68k                            q40_defconfig
m68k                       m5475evb_defconfig
mips                 pnx8335_stb225_defconfig
arm                          badge4_defconfig
mips                             allyesconfig
arm                       imx_v4_v5_defconfig
sh                           se7712_defconfig
mips                          rb532_defconfig
sh                            hp6xx_defconfig
arm                           h5000_defconfig
arm                           sunxi_defconfig
sh                           se7721_defconfig
powerpc                             defconfig
arm                      tct_hammer_defconfig
arm                        mini2440_defconfig
powerpc                          allmodconfig
arm                        shmobile_defconfig
nds32                             allnoconfig
arm                           omap1_defconfig
mips                  decstation_64_defconfig
c6x                        evmc6474_defconfig
sh                      rts7751r2d1_defconfig
arm                        mvebu_v5_defconfig
arm                         nhk8815_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
arm                          moxart_defconfig
powerpc                    adder875_defconfig
mips                           ip28_defconfig
openrisc                         alldefconfig
arm                          iop32x_defconfig
sh                        sh7785lcr_defconfig
i386                             allyesconfig
sh                   sh7770_generic_defconfig
mips                      loongson3_defconfig
arm                     eseries_pxa_defconfig
arm                           sama5_defconfig
sparc64                             defconfig
powerpc                      pmac32_defconfig
sh                         microdev_defconfig
mips                          malta_defconfig
arm                         axm55xx_defconfig
arm                         s3c6400_defconfig
arm                          ep93xx_defconfig
arm                          pxa168_defconfig
arm                      integrator_defconfig
mips                        workpad_defconfig
c6x                        evmc6457_defconfig
mips                          rm200_defconfig
h8300                            alldefconfig
mips                     cu1830-neo_defconfig
mips                        omega2p_defconfig
mips                        nlm_xlp_defconfig
sh                   sh7724_generic_defconfig
mips                           mtx1_defconfig
arm                           stm32_defconfig
arm                            hisi_defconfig
microblaze                    nommu_defconfig
sh                          lboxre2_defconfig
sh                           se7724_defconfig
arm                         mv78xx0_defconfig
microblaze                      mmu_defconfig
riscv                          rv32_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200903
x86_64               randconfig-a006-20200903
x86_64               randconfig-a003-20200903
x86_64               randconfig-a005-20200903
x86_64               randconfig-a001-20200903
x86_64               randconfig-a002-20200903
i386                 randconfig-a004-20200902
i386                 randconfig-a005-20200902
i386                 randconfig-a006-20200902
i386                 randconfig-a002-20200902
i386                 randconfig-a001-20200902
i386                 randconfig-a003-20200902
i386                 randconfig-a004-20200903
i386                 randconfig-a005-20200903
i386                 randconfig-a006-20200903
i386                 randconfig-a002-20200903
i386                 randconfig-a001-20200903
i386                 randconfig-a003-20200903
x86_64               randconfig-a013-20200902
x86_64               randconfig-a016-20200902
x86_64               randconfig-a011-20200902
x86_64               randconfig-a012-20200902
x86_64               randconfig-a015-20200902
x86_64               randconfig-a014-20200902
i386                 randconfig-a016-20200902
i386                 randconfig-a015-20200902
i386                 randconfig-a011-20200902
i386                 randconfig-a013-20200902
i386                 randconfig-a014-20200902
i386                 randconfig-a012-20200902
i386                 randconfig-a016-20200903
i386                 randconfig-a015-20200903
i386                 randconfig-a011-20200903
i386                 randconfig-a013-20200903
i386                 randconfig-a014-20200903
i386                 randconfig-a012-20200903
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
x86_64               randconfig-a004-20200902
x86_64               randconfig-a006-20200902
x86_64               randconfig-a003-20200902
x86_64               randconfig-a005-20200902
x86_64               randconfig-a001-20200902
x86_64               randconfig-a002-20200902
x86_64               randconfig-a013-20200903
x86_64               randconfig-a016-20200903
x86_64               randconfig-a011-20200903
x86_64               randconfig-a012-20200903
x86_64               randconfig-a015-20200903
x86_64               randconfig-a014-20200903

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
