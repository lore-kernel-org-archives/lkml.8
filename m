Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E420C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6B321744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHGGac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 02:30:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:2291 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHGGac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 02:30:32 -0400
IronPort-SDR: oWVROOIFQObwPsMU9lkgLbi0KyOt+BLK6QKtb6yTMxvqcb6xMf1ddIRqWeHU9qHIpktv3voZls
 YT63EglA/U+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="152239447"
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="152239447"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 23:30:22 -0700
IronPort-SDR: U3tl5k1+Z2pb3lWNUdp2o9j2dB0nKz4IqURU44HDetFXJphy675j7VLlCU5jF8zwtyvwE5FQoL
 ERrhqw5kUiOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="367837407"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 06 Aug 2020 23:30:21 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3vtU-00027l-Uk; Fri, 07 Aug 2020 06:30:20 +0000
Date:   Fri, 07 Aug 2020 14:29:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 0099808553ad4f9c04ad7afd966f6d7f470f247f
Message-ID: <5f2cf4c3.w/1T8zrHrqiH00Uj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: 0099808553ad4f9c04ad7afd966f6d7f470f247f  x86: Select POSIX_CPU_TIMERS_TASK_WORK

elapsed time: 724m

configs tested: 112
configs skipped: 6

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
mips                  mips_paravirt_defconfig
microblaze                      mmu_defconfig
sh                          rsk7201_defconfig
powerpc                      mgcoge_defconfig
powerpc64                        alldefconfig
mips                      maltasmvp_defconfig
arm                         axm55xx_defconfig
xtensa                    xip_kc705_defconfig
m68k                       m5475evb_defconfig
powerpc                       holly_defconfig
mips                 pnx8335_stb225_defconfig
arm                       aspeed_g5_defconfig
mips                      bmips_stb_defconfig
mips                         tb0287_defconfig
sh                        dreamcast_defconfig
m68k                       m5249evb_defconfig
powerpc                  mpc885_ads_defconfig
mips                      fuloong2e_defconfig
sh                   secureedge5410_defconfig
ia64                          tiger_defconfig
arm                         mv78xx0_defconfig
mips                     loongson1b_defconfig
sh                         apsh4a3a_defconfig
mips                        bcm47xx_defconfig
arm                  colibri_pxa270_defconfig
xtensa                              defconfig
sh                               j2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                               defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
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
