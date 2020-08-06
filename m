Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F543C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D3120866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgHFXAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:00:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:19501 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgHFXA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:00:27 -0400
IronPort-SDR: uIt+SGUqqUhBTxST/oOC45EqfymoLzI04PFK4Vm3qfe8orrYEmlZIJp67/MaBw2wL1X8FN1st7
 O81aoz7mdb9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="152905492"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="152905492"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 16:00:25 -0700
IronPort-SDR: PGfApDRB2dP/uHSF5+ROVKWgV0sgQpaEaRrUDeFKi5ADRV32PumSHXRAJhabHymK8NzrLgXEsQ
 nlY9qMSpSSNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="275214021"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 06 Aug 2020 16:00:24 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3os3-0001qq-Si; Thu, 06 Aug 2020 23:00:23 +0000
Date:   Fri, 07 Aug 2020 06:59:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 a1bd06853ee478d37fae9435c5521e301de94c67
Message-ID: <5f2c8b5e.QGGIDCoHrRGKjsPM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  sched/urgent
branch HEAD: a1bd06853ee478d37fae9435c5521e301de94c67  sched: Fix use of count for nr_running tracepoint

elapsed time: 725m

configs tested: 105
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      mgcoge_defconfig
sh                   sh7770_generic_defconfig
powerpc64                        alldefconfig
mips                      maltasmvp_defconfig
mips                         tb0287_defconfig
sh                        dreamcast_defconfig
arc                              allyesconfig
m68k                       m5249evb_defconfig
powerpc                    amigaone_defconfig
powerpc                      pasemi_defconfig
arm                             rpc_defconfig
m68k                        mvme147_defconfig
m68k                          multi_defconfig
powerpc                  mpc885_ads_defconfig
mips                      fuloong2e_defconfig
sh                   secureedge5410_defconfig
ia64                          tiger_defconfig
arm                         mv78xx0_defconfig
microblaze                      mmu_defconfig
s390                          debug_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
i386                 randconfig-a004-20200805
i386                 randconfig-a001-20200805
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
