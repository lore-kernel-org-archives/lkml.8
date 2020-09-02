Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1581C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8C9206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgIBTzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:55:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:5081 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBTzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:55:40 -0400
IronPort-SDR: dWtrcEGzZjGMK2p8m73Iz5I6Dpd+IY21AwSkSM77ZgtBjpJtNIq8R3ByO5cWcuLbsOGs4LmH4h
 0bJxCm8NdN1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="158459595"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="158459595"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 12:55:39 -0700
IronPort-SDR: pyACf0hifdEriOosAyegyYaYTLM8kHn2njOpPgzYmvUE749X8COgSfAmo0b3idH6BreFaZTkBl
 p3fzGslT3ZYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="446636116"
Received: from lkp-server02.sh.intel.com (HELO eb469fda2af7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Sep 2020 12:55:38 -0700
Received: from kbuild by eb469fda2af7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kDYr3-0000EH-GC; Wed, 02 Sep 2020 19:55:37 +0000
Date:   Thu, 03 Sep 2020 03:55:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 10690df7fc4a529605c4d72508567ad25a93d406
Message-ID: <5f4ff8a8.IGuE+lG3UlH5Z+ct%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 10690df7fc4a529605c4d72508567ad25a93d406  Merge branch 'linus'

elapsed time: 720m

configs tested: 149
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                     davinci_all_defconfig
arm                      pxa255-idp_defconfig
sh                           sh2007_defconfig
mips                           ci20_defconfig
mips                         rt305x_defconfig
nios2                            alldefconfig
sh                          polaris_defconfig
arm                          gemini_defconfig
arc                        nsim_700_defconfig
sh                             sh03_defconfig
arm                       imx_v6_v7_defconfig
arm                         s3c2410_defconfig
sh                          lboxre2_defconfig
arm                           h5000_defconfig
arm                           sunxi_defconfig
sh                           se7721_defconfig
mips                 pnx8335_stb225_defconfig
ia64                        generic_defconfig
mips                        qi_lb60_defconfig
m68k                         amcore_defconfig
mips                         tb0287_defconfig
mips                     cu1000-neo_defconfig
mips                          malta_defconfig
powerpc                    gamecube_defconfig
mips                           ip28_defconfig
openrisc                         alldefconfig
arm                          iop32x_defconfig
sh                        sh7785lcr_defconfig
m68k                             alldefconfig
mips                      malta_kvm_defconfig
m68k                       m5249evb_defconfig
i386                             allyesconfig
arm                             mxs_defconfig
sh                   sh7770_generic_defconfig
mips                      loongson3_defconfig
arm                     eseries_pxa_defconfig
arm                           sama5_defconfig
sparc64                             defconfig
powerpc                      pmac32_defconfig
nds32                            alldefconfig
mips                    maltaup_xpa_defconfig
powerpc                  mpc866_ads_defconfig
arm                          moxart_defconfig
arm                       netwinder_defconfig
sh                            hp6xx_defconfig
mips                            gpr_defconfig
sh                      rts7751r2d1_defconfig
mips                     cu1830-neo_defconfig
mips                        omega2p_defconfig
mips                        nlm_xlp_defconfig
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
nds32                             allnoconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200901
x86_64               randconfig-a006-20200901
x86_64               randconfig-a003-20200901
x86_64               randconfig-a005-20200901
x86_64               randconfig-a001-20200901
x86_64               randconfig-a002-20200901
i386                 randconfig-a004-20200901
i386                 randconfig-a005-20200901
i386                 randconfig-a006-20200901
i386                 randconfig-a002-20200901
i386                 randconfig-a001-20200901
i386                 randconfig-a003-20200901
i386                 randconfig-a004-20200902
i386                 randconfig-a005-20200902
i386                 randconfig-a006-20200902
i386                 randconfig-a002-20200902
i386                 randconfig-a001-20200902
i386                 randconfig-a003-20200902
i386                 randconfig-a016-20200902
i386                 randconfig-a015-20200902
i386                 randconfig-a011-20200902
i386                 randconfig-a013-20200902
i386                 randconfig-a014-20200902
i386                 randconfig-a012-20200902
i386                 randconfig-a016-20200901
i386                 randconfig-a015-20200901
i386                 randconfig-a011-20200901
i386                 randconfig-a013-20200901
i386                 randconfig-a014-20200901
i386                 randconfig-a012-20200901
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
x86_64               randconfig-a013-20200901
x86_64               randconfig-a016-20200901
x86_64               randconfig-a011-20200901
x86_64               randconfig-a012-20200901
x86_64               randconfig-a015-20200901
x86_64               randconfig-a014-20200901
x86_64               randconfig-a004-20200902
x86_64               randconfig-a006-20200902
x86_64               randconfig-a003-20200902
x86_64               randconfig-a005-20200902
x86_64               randconfig-a001-20200902
x86_64               randconfig-a002-20200902

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
