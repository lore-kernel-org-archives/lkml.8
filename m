Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6012BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 13:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396A0206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 13:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgEPNve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 09:51:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:43658 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgEPNve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 09:51:34 -0400
IronPort-SDR: t2vOOtlfK93eCD5jRJCTEjuJgb37OWvntGCCwNo3DqsxqJibp2RasOF+QGilirlNCTMjSerNto
 eHfx0GiqCxKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 06:51:33 -0700
IronPort-SDR: B2NMPlYoN13JQVn3yZpSm/iL+k+v/W+qrMi9Wq1YLA0OAJM8wZuuaiBOi2brTmPYthm99JSWCo
 NZtHMueRmHrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="252643606"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 May 2020 06:51:32 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZxDv-000CPx-W3; Sat, 16 May 2020 21:51:31 +0800
Date:   Sat, 16 May 2020 21:51:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 6255c161a08564e4f3995db31f3d64a5fd24738b
Message-ID: <5ebfefcd.4Ef69QACONsCSbNB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 6255c161a08564e4f3995db31f3d64a5fd24738b  x86/nmi: Remove edac.h include leftover

elapsed time: 480m

configs tested: 140
configs skipped: 9

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
arm                           u8500_defconfig
arm                           spitz_defconfig
microblaze                          defconfig
arm                         at91_dt_defconfig
sh                          sdk7786_defconfig
powerpc                    gamecube_defconfig
ia64                         bigsur_defconfig
sh                        sh7757lcr_defconfig
powerpc                          allyesconfig
arm                        spear6xx_defconfig
m68k                        m5407c3_defconfig
x86_64                              defconfig
m68k                             alldefconfig
arm                          gemini_defconfig
ia64                          tiger_defconfig
arm                         lpc32xx_defconfig
sh                 kfr2r09-romimage_defconfig
mips                      fuloong2e_defconfig
arm                         s3c6400_defconfig
powerpc                     skiroot_defconfig
sh                           se7751_defconfig
arm                  colibri_pxa270_defconfig
openrisc                    or1ksim_defconfig
arm                        spear3xx_defconfig
arm                           omap1_defconfig
arm                         lubbock_defconfig
arm                          badge4_defconfig
arm                         hackkit_defconfig
mips                            e55_defconfig
sh                                allnoconfig
nds32                            alldefconfig
nds32                             allnoconfig
arm                          ep93xx_defconfig
mips                       rbtx49xx_defconfig
arc                          axs103_defconfig
arm                              zx_defconfig
i386                              allnoconfig
arm                         lpc18xx_defconfig
arm                       cns3420vb_defconfig
riscv                    nommu_virt_defconfig
microblaze                    nommu_defconfig
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
sh                               allmodconfig
microblaze                        allnoconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200515
i386                 randconfig-a005-20200515
i386                 randconfig-a003-20200515
i386                 randconfig-a001-20200515
i386                 randconfig-a004-20200515
i386                 randconfig-a002-20200515
i386                 randconfig-a006-20200516
i386                 randconfig-a005-20200516
i386                 randconfig-a003-20200516
i386                 randconfig-a001-20200516
i386                 randconfig-a004-20200516
i386                 randconfig-a002-20200516
i386                 randconfig-a012-20200515
i386                 randconfig-a016-20200515
i386                 randconfig-a014-20200515
i386                 randconfig-a011-20200515
i386                 randconfig-a013-20200515
i386                 randconfig-a015-20200515
x86_64               randconfig-a005-20200515
x86_64               randconfig-a003-20200515
x86_64               randconfig-a006-20200515
x86_64               randconfig-a004-20200515
x86_64               randconfig-a001-20200515
x86_64               randconfig-a002-20200515
riscv                            allyesconfig
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
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
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
