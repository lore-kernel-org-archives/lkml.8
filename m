Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B630C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4800B206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgEQVKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 17:10:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:44366 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbgEQVKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 17:10:11 -0400
IronPort-SDR: rovWaLXfzCcpNxMpSHgMLP21AEhQmgq63Uwx4NmGgJo6u38EaVJQ4A5TRGRkHBjlSD9EoXkOq/
 16uc6v5WMm0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 14:10:10 -0700
IronPort-SDR: vlSObTwrir7bSCHvin/WTxAY+a8qteKzVwyVBi7o8jTQsZoybM5a8+GSIz6v74y6/l2HLQJXeA
 xnt4bTGHTgfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,404,1583222400"; 
   d="scan'208";a="299587636"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 May 2020 14:10:09 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jaQXw-000GUM-TI; Mon, 18 May 2020 05:10:08 +0800
Date:   Mon, 18 May 2020 05:09:57 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 0be11088b848774ae1f693169fdb9575e0ff06ba
Message-ID: <5ec1a825.Vn0gpHBok3s1Hn6x%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/build
branch HEAD: 0be11088b848774ae1f693169fdb9575e0ff06ba  x86/build: Use $(CONFIG_SHELL)

i386-tinyconfig vmlinux size:

+-------+-----------------------------------+---------------------------------------------+
| DELTA |              SYMBOL               |                   COMMIT                    |
+-------+-----------------------------------+---------------------------------------------+
|   +96 | TOTAL                             | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
|   +96 | TEXT                              | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
| +1355 | balance_dirty_pages()             | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
|  +615 | __setup_rt_frame()                | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
|  +113 | klist_release()                   | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
|   +93 | change_clocksource()              | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
|   +86 | release_bdi()                     | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
|   +84 | kobject_release()                 | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
|   -68 | bdi_put()                         | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
|   -77 | kobject_put()                     | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
|   -79 | timekeeping_notify()              | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
|   -99 | klist_dec_and_del()               | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
|  -555 | do_signal()                       | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
| -1383 | balance_dirty_pages_ratelimited() | 0be11088b848 x86/build: Use $(CONFIG_SHELL) |
+-------+-----------------------------------+---------------------------------------------+

elapsed time: 484m

configs tested: 143
configs skipped: 99

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
mips                             allyesconfig
m68k                             allyesconfig
sparc                            allyesconfig
m68k                          hp300_defconfig
powerpc                     pq2fads_defconfig
parisc                           alldefconfig
sh                   sh7770_generic_defconfig
arm                        mvebu_v7_defconfig
arm                            u300_defconfig
mips                  cavium_octeon_defconfig
microblaze                          defconfig
powerpc64                        alldefconfig
arm                      integrator_defconfig
arc                     nsimosci_hs_defconfig
s390                                defconfig
powerpc                     mpc5200_defconfig
arm                        clps711x_defconfig
mips                           xway_defconfig
mips                        maltaup_defconfig
arm                            hisi_defconfig
um                                  defconfig
arm                            mmp2_defconfig
mips                     loongson1c_defconfig
arm                          ep93xx_defconfig
arc                        nsimosci_defconfig
arc                      axs103_smp_defconfig
mips                        qi_lb60_defconfig
ia64                         bigsur_defconfig
openrisc                    or1ksim_defconfig
sh                          lboxre2_defconfig
arm                         lpc32xx_defconfig
mips                 decstation_r4k_defconfig
m68k                        stmark2_defconfig
mips                         tb0219_defconfig
parisc                              defconfig
s390                             allyesconfig
mips                          malta_defconfig
arm                         assabet_defconfig
arm                          exynos_defconfig
m68k                                defconfig
powerpc                         ps3_defconfig
sparc64                             defconfig
arm                        keystone_defconfig
m68k                        m5272c3_defconfig
parisc                           allyesconfig
arm                        shmobile_defconfig
sh                          r7780mp_defconfig
arm                          pcm027_defconfig
powerpc                       ppc64_defconfig
parisc                generic-32bit_defconfig
um                                allnoconfig
powerpc                    amigaone_defconfig
mips                           mtx1_defconfig
parisc                generic-64bit_defconfig
c6x                         dsk6455_defconfig
sh                           sh2007_defconfig
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
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
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
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20200517
x86_64               randconfig-a003-20200517
x86_64               randconfig-a006-20200517
x86_64               randconfig-a004-20200517
x86_64               randconfig-a001-20200517
x86_64               randconfig-a002-20200517
i386                 randconfig-a006-20200517
i386                 randconfig-a005-20200517
i386                 randconfig-a003-20200517
i386                 randconfig-a001-20200517
i386                 randconfig-a004-20200517
i386                 randconfig-a002-20200517
i386                 randconfig-a012-20200517
i386                 randconfig-a016-20200517
i386                 randconfig-a014-20200517
i386                 randconfig-a011-20200517
i386                 randconfig-a013-20200517
i386                 randconfig-a015-20200517
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                              allnoconfig
s390                             allmodconfig
x86_64                              defconfig
sparc                               defconfig
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
