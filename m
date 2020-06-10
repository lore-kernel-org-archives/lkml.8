Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19A8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A332D2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgFJOH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:07:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:42098 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgFJOH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:07:28 -0400
IronPort-SDR: 0nAcJEptTMBpPQEMyfGxcBVEZHkIFK6LsUudRitNlVBQnFIfo8AeFxTuza6YwR4Q/tOd+XjFXi
 zlkwWZAO9k8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 07:07:27 -0700
IronPort-SDR: Baj6diGcO0fx/r2Xu5F4EXm1O4UWqqEGMWuCrDgWfdc0u8lJeaxo0O6dOiD6l9gogJ7l1Zr4ER
 MnwmMalYUiXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,496,1583222400"; 
   d="scan'208";a="473348595"
Received: from lkp-server01.sh.intel.com (HELO 19cb45ee048e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2020 07:07:26 -0700
Received: from kbuild by 19cb45ee048e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jj1O1-0000Dg-Ny; Wed, 10 Jun 2020 14:07:25 +0000
Date:   Wed, 10 Jun 2020 22:07:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 b91c8c42ffdd5c983923edb38b3c3e112bfe6263
Message-ID: <5ee0e911.FYslSSl0ZvNWRQLg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  timers/urgent
branch HEAD: b91c8c42ffdd5c983923edb38b3c3e112bfe6263  lib/vdso: Force inlining of __cvdso_clock_gettime_common()

elapsed time: 9794m

configs tested: 191
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
m68k                         amcore_defconfig
mips                       rbtx49xx_defconfig
um                                  defconfig
sh                     magicpanelr2_defconfig
powerpc                  mpc885_ads_defconfig
mips                           xway_defconfig
arm                       cns3420vb_defconfig
m68k                          sun3x_defconfig
sparc                       sparc32_defconfig
riscv                          rv32_defconfig
arm                           h3600_defconfig
sparc                            allyesconfig
powerpc                    mvme5100_defconfig
openrisc                 simple_smp_defconfig
arm                           efm32_defconfig
arm                        vexpress_defconfig
xtensa                          iss_defconfig
mips                  decstation_64_defconfig
sh                           cayman_defconfig
sh                           se7705_defconfig
mips                     decstation_defconfig
arm                       aspeed_g4_defconfig
arc                          axs101_defconfig
arc                        vdk_hs38_defconfig
parisc                           allyesconfig
arc                        nsimosci_defconfig
nios2                               defconfig
openrisc                            defconfig
sh                           se7619_defconfig
arm                         hackkit_defconfig
sh                         apsh4a3a_defconfig
arm                            mmp2_defconfig
arm                        neponset_defconfig
arm                         orion5x_defconfig
arm                    vt8500_v6_v7_defconfig
mips                         tb0219_defconfig
m68k                        mvme16x_defconfig
mips                          malta_defconfig
sh                          r7780mp_defconfig
riscv                            allyesconfig
mips                        bcm47xx_defconfig
arm                           tegra_defconfig
mips                           ci20_defconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
arm                            dove_defconfig
xtensa                           alldefconfig
arm                         shannon_defconfig
um                                allnoconfig
arm                         socfpga_defconfig
arc                                 defconfig
sh                   sh7724_generic_defconfig
powerpc                    amigaone_defconfig
arc                        nsim_700_defconfig
arm                          exynos_defconfig
arm                         ebsa110_defconfig
arm                          moxart_defconfig
arm                     eseries_pxa_defconfig
arm                           stm32_defconfig
arm                     am200epdkit_defconfig
powerpc                    gamecube_defconfig
arm                     davinci_all_defconfig
mips                  maltasmvp_eva_defconfig
arm                            xcep_defconfig
arm                         mv78xx0_defconfig
arm                       imx_v4_v5_defconfig
arm                          prima2_defconfig
sh                           se7343_defconfig
arm                         nhk8815_defconfig
nios2                            alldefconfig
arm                              zx_defconfig
microblaze                    nommu_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                            allyesconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a001-20200607
i386                 randconfig-a006-20200607
i386                 randconfig-a002-20200607
i386                 randconfig-a005-20200607
i386                 randconfig-a004-20200607
i386                 randconfig-a003-20200607
i386                 randconfig-a001-20200604
i386                 randconfig-a006-20200604
i386                 randconfig-a002-20200604
i386                 randconfig-a005-20200604
i386                 randconfig-a004-20200604
i386                 randconfig-a003-20200604
i386                 randconfig-a001-20200605
i386                 randconfig-a006-20200605
i386                 randconfig-a002-20200605
i386                 randconfig-a005-20200605
i386                 randconfig-a004-20200605
i386                 randconfig-a003-20200605
x86_64               randconfig-a002-20200605
x86_64               randconfig-a001-20200605
x86_64               randconfig-a006-20200605
x86_64               randconfig-a003-20200605
x86_64               randconfig-a004-20200605
x86_64               randconfig-a005-20200605
x86_64               randconfig-a011-20200604
x86_64               randconfig-a016-20200604
x86_64               randconfig-a013-20200604
x86_64               randconfig-a014-20200604
x86_64               randconfig-a012-20200604
x86_64               randconfig-a015-20200604
x86_64               randconfig-a002-20200607
x86_64               randconfig-a001-20200607
x86_64               randconfig-a006-20200607
x86_64               randconfig-a003-20200607
x86_64               randconfig-a004-20200607
x86_64               randconfig-a005-20200607
i386                 randconfig-a014-20200607
i386                 randconfig-a015-20200607
i386                 randconfig-a011-20200607
i386                 randconfig-a016-20200607
i386                 randconfig-a012-20200607
i386                 randconfig-a013-20200607
i386                 randconfig-a014-20200604
i386                 randconfig-a015-20200604
i386                 randconfig-a011-20200604
i386                 randconfig-a016-20200604
i386                 randconfig-a012-20200604
i386                 randconfig-a013-20200604
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
