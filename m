Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525E0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A612067B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgFHASs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:18:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:9049 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727919AbgFHASr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 20:18:47 -0400
IronPort-SDR: YmAiCcYEuXCBy3Q8vLCsR7f+S/IT6+Msb1WEbuzs3jnCHPyGqm1gG4gaONGuSBFH8ei1++FObS
 4ri8T0Z8moVw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2020 17:18:46 -0700
IronPort-SDR: x3aPsUnL2STgoJJJ/BGconMjaQJJop8EggoijkPNjxTe6/FRr8QQPRw2rIc6kP/1MXcoeRaNkI
 F1mLEXxEoWFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,486,1583222400"; 
   d="scan'208";a="288304803"
Received: from lkp-server01.sh.intel.com (HELO 3b764b36c89c) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2020 17:18:45 -0700
Received: from kbuild by 3b764b36c89c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ji5Uy-0000VT-PR; Mon, 08 Jun 2020 00:18:44 +0000
Date:   Mon, 08 Jun 2020 08:18:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 22a1c800c96c83b7f4e3e02fad767502b70124fa
Message-ID: <5edd83bb.9bzZwhQj3zN4SCkt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 22a1c800c96c83b7f4e3e02fad767502b70124fa  Merge branch 'WIP.core/headers'

elapsed time: 480m

configs tested: 173
configs skipped: 12

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
powerpc                      ep88xc_defconfig
sh                ecovec24-romimage_defconfig
sparc64                          allmodconfig
arm                          prima2_defconfig
arm                           h3600_defconfig
powerpc                    mvme5100_defconfig
openrisc                 simple_smp_defconfig
sh                           se7705_defconfig
mips                     decstation_defconfig
csky                             allyesconfig
arm                              zx_defconfig
mips                        nlm_xlr_defconfig
sh                             shx3_defconfig
c6x                        evmc6678_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        mvebu_v5_defconfig
arm                          iop32x_defconfig
arm                            mps2_defconfig
openrisc                         allyesconfig
sh                      rts7751r2d1_defconfig
m68k                       m5249evb_defconfig
powerpc                      pmac32_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          collie_defconfig
sh                 kfr2r09-romimage_defconfig
arm                          moxart_defconfig
arc                         haps_hs_defconfig
m68k                            mac_defconfig
c6x                               allnoconfig
arm                        oxnas_v6_defconfig
arm                           corgi_defconfig
mips                           ip27_defconfig
arc                      axs103_smp_defconfig
sparc64                          alldefconfig
mips                          ath25_defconfig
arm                    vt8500_v6_v7_defconfig
mips                         tb0219_defconfig
m68k                        mvme16x_defconfig
mips                          malta_defconfig
powerpc                       maple_defconfig
xtensa                         virt_defconfig
arm                           u8500_defconfig
arm                          pxa168_defconfig
arc                        nsim_700_defconfig
i386                              allnoconfig
microblaze                    nommu_defconfig
powerpc                    amigaone_defconfig
arm                          exynos_defconfig
um                                allnoconfig
arc                            hsdk_defconfig
m68k                          sun3x_defconfig
m68k                        m5272c3_defconfig
m68k                        stmark2_defconfig
powerpc                    gamecube_defconfig
arm                          pxa910_defconfig
arm                     davinci_all_defconfig
mips                  maltasmvp_eva_defconfig
arm                            xcep_defconfig
arm                         mv78xx0_defconfig
sh                     magicpanelr2_defconfig
c6x                        evmc6457_defconfig
s390                             allmodconfig
ia64                      gensparse_defconfig
arm                            zeus_defconfig
sh                           se7206_defconfig
sh                          rsk7203_defconfig
sh                          polaris_defconfig
arm                       imx_v6_v7_defconfig
mips                        jmr3927_defconfig
arm                       netwinder_defconfig
arm                         s5pv210_defconfig
mips                          ath79_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc8272_ads_defconfig
c6x                                 defconfig
mips                         cobalt_defconfig
mips                        nlm_xlp_defconfig
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
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
x86_64               randconfig-a002-20200607
x86_64               randconfig-a001-20200607
x86_64               randconfig-a006-20200607
x86_64               randconfig-a003-20200607
x86_64               randconfig-a004-20200607
x86_64               randconfig-a005-20200607
i386                 randconfig-a001-20200607
i386                 randconfig-a006-20200607
i386                 randconfig-a002-20200607
i386                 randconfig-a005-20200607
i386                 randconfig-a004-20200607
i386                 randconfig-a003-20200607
i386                 randconfig-a014-20200607
i386                 randconfig-a015-20200607
i386                 randconfig-a011-20200607
i386                 randconfig-a016-20200607
i386                 randconfig-a012-20200607
i386                 randconfig-a013-20200607
i386                 randconfig-a014-20200608
i386                 randconfig-a011-20200608
i386                 randconfig-a015-20200608
i386                 randconfig-a016-20200608
i386                 randconfig-a012-20200608
i386                 randconfig-a013-20200608
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                               allmodconfig
um                                  defconfig
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
