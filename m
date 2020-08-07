Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B385C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F8322C9F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgHGOEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:04:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:10122 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgHGN6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:58:15 -0400
IronPort-SDR: IR4XiRxW9ObKYBuDUr16EPQaYkFp2b5noWcfFrHSlsjt/46H2DkVHblnj5Ceg53Pgma5Ppo5Z/
 1fmRN7ZbDBwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="132638377"
X-IronPort-AV: E=Sophos;i="5.75,445,1589266800"; 
   d="scan'208";a="132638377"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 06:58:08 -0700
IronPort-SDR: HIw8EkictUtAcXrAoSt+uZAHW08pVZvuL+pgxULsOJiC7VeFMGHDQ/IWGx+tECiLTevAaCuwZS
 geCspFXkdXKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,445,1589266800"; 
   d="scan'208";a="333547143"
Received: from lkp-server02.sh.intel.com (HELO 090e49ab5480) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2020 06:58:05 -0700
Received: from kbuild by 090e49ab5480 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k42sU-0000J7-SM; Fri, 07 Aug 2020 13:57:46 +0000
Date:   Fri, 07 Aug 2020 21:57:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/kaslr] BUILD SUCCESS
 76167e5c5457aee8fba3edc5b8554183696fc94d
Message-ID: <5f2d5dcc.GACXkTKne0jV4HcO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/kaslr
branch HEAD: 76167e5c5457aee8fba3edc5b8554183696fc94d  x86/kaslr: Replace strlen() with strnlen()

elapsed time: 1173m

configs tested: 140
configs skipped: 73

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       mainstone_defconfig
sh                   sh7770_generic_defconfig
mips                       rbtx49xx_defconfig
ia64                         bigsur_defconfig
arm                          simpad_defconfig
sh                          polaris_defconfig
powerpc64                           defconfig
microblaze                      mmu_defconfig
arm                         axm55xx_defconfig
xtensa                    xip_kc705_defconfig
m68k                       m5475evb_defconfig
powerpc                       holly_defconfig
powerpc                     pq2fads_defconfig
c6x                                 defconfig
arm                           u8500_defconfig
mips                 pnx8335_stb225_defconfig
arm                       aspeed_g5_defconfig
mips                      bmips_stb_defconfig
powerpc                    amigaone_defconfig
sh                           se7712_defconfig
arc                           tb10x_defconfig
sh                           se7780_defconfig
mips                   sb1250_swarm_defconfig
sh                          r7780mp_defconfig
arm                        realview_defconfig
arm                           sunxi_defconfig
microblaze                    nommu_defconfig
mips                      fuloong2e_defconfig
mips                     loongson1c_defconfig
arm                          lpd270_defconfig
mips                        jmr3927_defconfig
arm                          ep93xx_defconfig
mips                            e55_defconfig
m68k                       m5249evb_defconfig
sh                        dreamcast_defconfig
alpha                               defconfig
powerpc                  mpc885_ads_defconfig
sh                   secureedge5410_defconfig
ia64                          tiger_defconfig
arm                         mv78xx0_defconfig
mips                     loongson1b_defconfig
sh                         apsh4a3a_defconfig
sh                            hp6xx_defconfig
s390                          debug_defconfig
powerpc                     powernv_defconfig
arm                        spear6xx_defconfig
mips                         db1xxx_defconfig
mips                            gpr_defconfig
arm                       imx_v4_v5_defconfig
arm                     eseries_pxa_defconfig
arm                            pleb_defconfig
arm                        keystone_defconfig
arm                          collie_defconfig
sh                           se7722_defconfig
ia64                            zx1_defconfig
mips                 decstation_r4k_defconfig
openrisc                    or1ksim_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
x86_64               randconfig-a006-20200806
x86_64               randconfig-a001-20200806
x86_64               randconfig-a004-20200806
x86_64               randconfig-a005-20200806
x86_64               randconfig-a003-20200806
x86_64               randconfig-a002-20200806
i386                 randconfig-a005-20200806
i386                 randconfig-a004-20200806
i386                 randconfig-a001-20200806
i386                 randconfig-a002-20200806
i386                 randconfig-a003-20200806
i386                 randconfig-a006-20200806
i386                 randconfig-a005-20200805
i386                 randconfig-a004-20200805
i386                 randconfig-a001-20200805
i386                 randconfig-a003-20200805
i386                 randconfig-a002-20200805
i386                 randconfig-a006-20200805
x86_64               randconfig-a013-20200805
x86_64               randconfig-a011-20200805
x86_64               randconfig-a012-20200805
x86_64               randconfig-a016-20200805
x86_64               randconfig-a015-20200805
x86_64               randconfig-a014-20200805
i386                 randconfig-a011-20200805
i386                 randconfig-a012-20200805
i386                 randconfig-a013-20200805
i386                 randconfig-a014-20200805
i386                 randconfig-a015-20200805
i386                 randconfig-a016-20200805
i386                 randconfig-a011-20200806
i386                 randconfig-a012-20200806
i386                 randconfig-a013-20200806
i386                 randconfig-a015-20200806
i386                 randconfig-a014-20200806
i386                 randconfig-a016-20200806
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
