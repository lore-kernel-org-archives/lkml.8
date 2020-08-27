Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76DDC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42DA20848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgH0WMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:12:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:40473 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgH0WMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:12:41 -0400
IronPort-SDR: cHmzA88ZwN5xbMI7d7WHGbq/XoZl4WIrzJarVkzMP+9321pz7uD2dBY2nWhUe3H5wCBYb7A+TD
 T3IqbXsCtU/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="155832772"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="155832772"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 15:12:38 -0700
IronPort-SDR: GtT75zGTDFWlqVBGqzWkzzdQwwZYsU3HXIXuUIZOmXLIS6mMGG+akMQuX+EmQWldpFv6PBYVkQ
 iBwH0J4irINQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="475407299"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Aug 2020 15:12:36 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kBQ8K-0002KX-4I; Thu, 27 Aug 2020 22:12:36 +0000
Date:   Fri, 28 Aug 2020 06:12:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 e33ab2064836600603289ad2ed0ca3424f395fa8
Message-ID: <5f482fd0.r3kpibebHCzkURSs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: e33ab2064836600603289ad2ed0ca3424f395fa8  x86/mpparse: Remove duplicate io_apic.h include

elapsed time: 723m

configs tested: 132
configs skipped: 73

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                    nommu_k210_defconfig
mips                     decstation_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                              ul2_defconfig
sh                ecovec24-romimage_defconfig
arm                      pxa255-idp_defconfig
mips                           ip32_defconfig
sh                           se7721_defconfig
powerpc                         ps3_defconfig
arm                             rpc_defconfig
sh                            shmin_defconfig
arm                         s3c2410_defconfig
m68k                        m5272c3_defconfig
sh                            migor_defconfig
arm                        multi_v7_defconfig
sparc64                          alldefconfig
arm                          pxa168_defconfig
ia64                             allmodconfig
sh                        sh7763rdp_defconfig
arm                         orion5x_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                     pq2fads_defconfig
mips                           xway_defconfig
m68k                          sun3x_defconfig
mips                          malta_defconfig
arm                           spitz_defconfig
mips                       rbtx49xx_defconfig
powerpc                     mpc5200_defconfig
mips                           ip22_defconfig
sh                         apsh4a3a_defconfig
microblaze                      mmu_defconfig
microblaze                          defconfig
arc                           tb10x_defconfig
sh                        sh7757lcr_defconfig
mips                      maltaaprp_defconfig
arm                    vt8500_v6_v7_defconfig
sh                             sh03_defconfig
arm                         mv78xx0_defconfig
arc                              allyesconfig
sh                          sdk7780_defconfig
c6x                         dsk6455_defconfig
arc                              alldefconfig
arm                  colibri_pxa270_defconfig
mips                       lemote2f_defconfig
m68k                         apollo_defconfig
sh                        edosk7760_defconfig
sh                           sh2007_defconfig
sh                          urquell_defconfig
sparc                            allyesconfig
sh                         microdev_defconfig
sh                           se7712_defconfig
arm                        magician_defconfig
c6x                        evmc6678_defconfig
sparc                               defconfig
arc                    vdk_hs38_smp_defconfig
sh                        apsh4ad0a_defconfig
arm                         bcm2835_defconfig
mips                     loongson1b_defconfig
mips                            ar7_defconfig
arc                            hsdk_defconfig
alpha                               defconfig
arm                          exynos_defconfig
powerpc                      tqm8xx_defconfig
arm                       aspeed_g4_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20200827
x86_64               randconfig-a002-20200827
x86_64               randconfig-a001-20200827
x86_64               randconfig-a005-20200827
x86_64               randconfig-a006-20200827
x86_64               randconfig-a004-20200827
i386                 randconfig-a002-20200828
i386                 randconfig-a005-20200828
i386                 randconfig-a003-20200828
i386                 randconfig-a004-20200828
i386                 randconfig-a001-20200828
i386                 randconfig-a006-20200828
i386                 randconfig-a002-20200827
i386                 randconfig-a004-20200827
i386                 randconfig-a003-20200827
i386                 randconfig-a005-20200827
i386                 randconfig-a006-20200827
i386                 randconfig-a001-20200827
i386                 randconfig-a013-20200827
i386                 randconfig-a012-20200827
i386                 randconfig-a011-20200827
i386                 randconfig-a016-20200827
i386                 randconfig-a015-20200827
i386                 randconfig-a014-20200827
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
