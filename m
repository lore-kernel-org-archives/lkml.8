Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13735C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA50020825
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHZQ5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:57:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:8336 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgHZQ5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:57:05 -0400
IronPort-SDR: HH42wWVLEwLMOPKy9jMb5wPUpLnvXjUNG/trYsyxesv/JckILB0sPTsTHBruJNLOY0bs6L4bAp
 tAlDP0SlDLKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="174384798"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="174384798"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:57:03 -0700
IronPort-SDR: 644ng+cGDIiJL1dAxcCzrMhLT7KqS64NSJRQLteM2eDXbuz/11z3ppaLTD4MvGTyARVAP8wFuv
 /m6Ok6VGYoEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="339228764"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2020 09:57:01 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kAyjM-0001XC-In; Wed, 26 Aug 2020 16:57:00 +0000
Date:   Thu, 27 Aug 2020 00:56:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 ceb2465c51195967f11f6507538579816ac67cb8
Message-ID: <5f469431.Afp5bopbRyJM3nzC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/urgent
branch HEAD: ceb2465c51195967f11f6507538579816ac67cb8  Merge tag 'irqchip-fixes-5.9-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

elapsed time: 721m

configs tested: 144
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           corgi_defconfig
h8300                               defconfig
m68k                        stmark2_defconfig
microblaze                    nommu_defconfig
sh                          urquell_defconfig
powerpc                      ep88xc_defconfig
arm                         s3c6400_defconfig
arm                            pleb_defconfig
sh                            shmin_defconfig
powerpc                          alldefconfig
mips                    maltaup_xpa_defconfig
h8300                    h8300h-sim_defconfig
xtensa                generic_kc705_defconfig
mips                      bmips_stb_defconfig
mips                      maltasmvp_defconfig
arm                       aspeed_g4_defconfig
m68k                          sun3x_defconfig
m68k                       bvme6000_defconfig
ia64                                defconfig
sh                           se7712_defconfig
mips                        nlm_xlr_defconfig
xtensa                       common_defconfig
powerpc                     skiroot_defconfig
sh                          rsk7201_defconfig
mips                       rbtx49xx_defconfig
arm                            u300_defconfig
h8300                            alldefconfig
mips                        vocore2_defconfig
arm                            zeus_defconfig
i386                             allyesconfig
powerpc                    adder875_defconfig
sh                           se7751_defconfig
powerpc                          g5_defconfig
mips                     loongson1c_defconfig
sh                             espt_defconfig
powerpc                       holly_defconfig
arm                         palmz72_defconfig
arm                          moxart_defconfig
powerpc                 linkstation_defconfig
arc                        nsim_700_defconfig
openrisc                 simple_smp_defconfig
mips                        nlm_xlp_defconfig
arm                        shmobile_defconfig
sh                         microdev_defconfig
arm                          exynos_defconfig
mips                         tb0226_defconfig
arm                         s3c2410_defconfig
powerpc                         ps3_defconfig
arm                         hackkit_defconfig
arm                            qcom_defconfig
mips                         tb0287_defconfig
mips                       bmips_be_defconfig
arm                          tango4_defconfig
mips                        workpad_defconfig
mips                            ar7_defconfig
arm                          ixp4xx_defconfig
arm                       multi_v4t_defconfig
arm                            mps2_defconfig
arm                          collie_defconfig
mips                           ip28_defconfig
powerpc                     powernv_defconfig
nios2                         10m50_defconfig
xtensa                              defconfig
sh                        edosk7705_defconfig
arm                    vt8500_v6_v7_defconfig
arc                      axs103_smp_defconfig
c6x                              allyesconfig
powerpc                           allnoconfig
powerpc64                           defconfig
sh                          r7785rp_defconfig
mips                           rs90_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                           se7780_defconfig
arm                     eseries_pxa_defconfig
m68k                       m5475evb_defconfig
mips                  decstation_64_defconfig
sh                        sh7757lcr_defconfig
arc                          axs101_defconfig
mips                         tb0219_defconfig
sparc64                             defconfig
arm                          imote2_defconfig
arm                              alldefconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a002-20200826
i386                 randconfig-a004-20200826
i386                 randconfig-a003-20200826
i386                 randconfig-a005-20200826
i386                 randconfig-a006-20200826
i386                 randconfig-a001-20200826
x86_64               randconfig-a015-20200826
x86_64               randconfig-a016-20200826
x86_64               randconfig-a012-20200826
x86_64               randconfig-a014-20200826
x86_64               randconfig-a011-20200826
x86_64               randconfig-a013-20200826
i386                 randconfig-a013-20200826
i386                 randconfig-a012-20200826
i386                 randconfig-a011-20200826
i386                 randconfig-a016-20200826
i386                 randconfig-a015-20200826
i386                 randconfig-a014-20200826
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
