Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D7DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577072074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgGACYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:24:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:49619 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgGACYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:24:14 -0400
IronPort-SDR: gc0SX2He3yxN1ITHL+xwa4oZq+752+7aVWDsJJF8ij0VFpLgVCfd7d0PfBj0/DbPeeAbNVx9KN
 XytpkkP06gJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="147992808"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="147992808"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 19:24:12 -0700
IronPort-SDR: Sgp81RKLPMZ4/nH1D7ZciI8ToGHFOJTS/nzbTgyqqZ4H+xAR1OpnYBcch+QZ/gTKCdrAKN7mHE
 S/CMs4cpjUEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="321605461"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2020 19:24:11 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jqSPy-0002L1-K7; Wed, 01 Jul 2020 02:24:10 +0000
Date:   Wed, 01 Jul 2020 10:22:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 4185b3b92792eaec5869266e594338343421ffb0
Message-ID: <5efbf365.NV6HoYoBazd1zeAD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/fpu
branch HEAD: 4185b3b92792eaec5869266e594338343421ffb0  selftests/fpu: Add an FPU selftest

elapsed time: 2529m

configs tested: 186
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
mips                         tb0287_defconfig
powerpc                  mpc866_ads_defconfig
mips                      pistachio_defconfig
sparc64                          allyesconfig
s390                             alldefconfig
riscv                          rv32_defconfig
m68k                             alldefconfig
arm                         socfpga_defconfig
mips                              allnoconfig
arm                         s3c2410_defconfig
openrisc                 simple_smp_defconfig
m68k                          hp300_defconfig
sh                             espt_defconfig
arm                           stm32_defconfig
sparc                       sparc64_defconfig
m68k                              allnoconfig
arm                    vt8500_v6_v7_defconfig
arm                           corgi_defconfig
m68k                        m5307c3_defconfig
powerpc                          g5_defconfig
arm                           u8500_defconfig
sparc                       sparc32_defconfig
sh                          landisk_defconfig
sh                         apsh4a3a_defconfig
arm                          badge4_defconfig
arm                          lpd270_defconfig
sh                           se7724_defconfig
mips                  maltasmvp_eva_defconfig
mips                 pnx8335_stb225_defconfig
s390                              allnoconfig
mips                         tb0219_defconfig
powerpc                      mgcoge_defconfig
nds32                             allnoconfig
arm                          pcm027_defconfig
mips                         mpc30x_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                             pxa_defconfig
mips                      pic32mzda_defconfig
mips                           xway_defconfig
sh                      rts7751r2d1_defconfig
arm                           viper_defconfig
powerpc                      ppc44x_defconfig
arm                          moxart_defconfig
sh                        sh7763rdp_defconfig
arm                        mvebu_v7_defconfig
arm                          exynos_defconfig
c6x                        evmc6474_defconfig
arm                            pleb_defconfig
arm                             ezx_defconfig
xtensa                       common_defconfig
powerpc                          allyesconfig
arm                         orion5x_defconfig
arm                         nhk8815_defconfig
sh                                  defconfig
m68k                          amiga_defconfig
m68k                          sun3x_defconfig
mips                  mips_paravirt_defconfig
sh                     sh7710voipgw_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                                allnoconfig
microblaze                        allnoconfig
sh                               allmodconfig
mips                             allyesconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200630
i386                 randconfig-a003-20200630
i386                 randconfig-a002-20200630
i386                 randconfig-a004-20200630
i386                 randconfig-a005-20200630
i386                 randconfig-a006-20200630
i386                 randconfig-a002-20200701
i386                 randconfig-a001-20200701
i386                 randconfig-a006-20200701
i386                 randconfig-a005-20200701
i386                 randconfig-a004-20200701
i386                 randconfig-a003-20200701
i386                 randconfig-a006-20200629
i386                 randconfig-a002-20200629
i386                 randconfig-a003-20200629
i386                 randconfig-a001-20200629
i386                 randconfig-a005-20200629
i386                 randconfig-a004-20200629
x86_64               randconfig-a011-20200629
x86_64               randconfig-a012-20200629
x86_64               randconfig-a013-20200629
x86_64               randconfig-a014-20200629
x86_64               randconfig-a015-20200629
x86_64               randconfig-a016-20200629
x86_64               randconfig-a011-20200630
x86_64               randconfig-a014-20200630
x86_64               randconfig-a013-20200630
x86_64               randconfig-a015-20200630
x86_64               randconfig-a016-20200630
x86_64               randconfig-a012-20200630
x86_64               randconfig-a012-20200701
x86_64               randconfig-a016-20200701
x86_64               randconfig-a014-20200701
x86_64               randconfig-a011-20200701
x86_64               randconfig-a015-20200701
x86_64               randconfig-a013-20200701
i386                 randconfig-a013-20200629
i386                 randconfig-a016-20200629
i386                 randconfig-a014-20200629
i386                 randconfig-a012-20200629
i386                 randconfig-a015-20200629
i386                 randconfig-a011-20200629
i386                 randconfig-a011-20200630
i386                 randconfig-a016-20200630
i386                 randconfig-a015-20200630
i386                 randconfig-a014-20200630
i386                 randconfig-a013-20200630
i386                 randconfig-a012-20200630
i386                 randconfig-a011-20200701
i386                 randconfig-a015-20200701
i386                 randconfig-a014-20200701
i386                 randconfig-a016-20200701
i386                 randconfig-a012-20200701
i386                 randconfig-a013-20200701
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
