Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A010C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0C520772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHSAuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:50:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:33061 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgHSAuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 20:50:20 -0400
IronPort-SDR: Q8am2GJxJiQrJJu8x8oPo4QNw09jDNv9B4kQOBJUKt+/oqmm8uHjU8UowhXB3Qn/hzB30ml557
 KTL74P4MG50g==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="154290318"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="154290318"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 17:50:19 -0700
IronPort-SDR: G4B8uxAKyfIGWkYdFAo1TRJQk1LUdzgz2XWM8ZCwBuD7CF4XzvAxSOoRxftGX55Gq7Jy5RzXCD
 g7xwcYCJeENA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="279553657"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2020 17:50:18 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k8CIz-0001Wf-LL; Wed, 19 Aug 2020 00:50:17 +0000
Date:   Wed, 19 Aug 2020 08:49:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 cc172ff301d8079e941a6eb31758951a6d764084
Message-ID: <5f3c7714.w3kigECmkgSI/9R4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  sched/urgent
branch HEAD: cc172ff301d8079e941a6eb31758951a6d764084  sched/debug: Fix the alignment of the show-state debug output

elapsed time: 4042m

configs tested: 137
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
powerpc                     pq2fads_defconfig
sh                        edosk7705_defconfig
sh                           se7705_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
arm                          ep93xx_defconfig
arm                         lpc32xx_defconfig
mips                           gcw0_defconfig
powerpc                     pseries_defconfig
arm                         s5pv210_defconfig
arm                           h5000_defconfig
mips                           ip32_defconfig
um                           x86_64_defconfig
sh                           se7724_defconfig
sh                          r7780mp_defconfig
arm                           omap1_defconfig
powerpc                    gamecube_defconfig
arm                         ebsa110_defconfig
sparc                               defconfig
m68k                       m5275evb_defconfig
ia64                      gensparse_defconfig
powerpc                    adder875_defconfig
nds32                             allnoconfig
mips                          rb532_defconfig
powerpc                     mpc83xx_defconfig
ia64                             alldefconfig
mips                malta_kvm_guest_defconfig
arm                          pcm027_defconfig
ia64                            zx1_defconfig
powerpc                         ps3_defconfig
arm                        shmobile_defconfig
arm                       aspeed_g4_defconfig
arm                           tegra_defconfig
mips                          ath79_defconfig
nios2                               defconfig
arm                        spear6xx_defconfig
arc                         haps_hs_defconfig
sh                        dreamcast_defconfig
sh                          kfr2r09_defconfig
sh                          sdk7786_defconfig
arm                           spitz_defconfig
powerpc                        cell_defconfig
powerpc                      ppc44x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20200816
i386                 randconfig-a001-20200816
i386                 randconfig-a002-20200816
i386                 randconfig-a003-20200816
i386                 randconfig-a006-20200816
i386                 randconfig-a004-20200816
i386                 randconfig-a005-20200818
i386                 randconfig-a002-20200818
i386                 randconfig-a001-20200818
i386                 randconfig-a003-20200818
i386                 randconfig-a004-20200818
i386                 randconfig-a006-20200818
i386                 randconfig-a005-20200817
i386                 randconfig-a001-20200817
i386                 randconfig-a002-20200817
i386                 randconfig-a003-20200817
i386                 randconfig-a006-20200817
i386                 randconfig-a004-20200817
x86_64               randconfig-a016-20200818
x86_64               randconfig-a014-20200818
x86_64               randconfig-a015-20200818
x86_64               randconfig-a013-20200818
x86_64               randconfig-a012-20200818
x86_64               randconfig-a011-20200818
x86_64               randconfig-a013-20200816
x86_64               randconfig-a012-20200816
x86_64               randconfig-a016-20200816
x86_64               randconfig-a011-20200816
x86_64               randconfig-a014-20200816
x86_64               randconfig-a015-20200816
i386                 randconfig-a016-20200816
i386                 randconfig-a011-20200816
i386                 randconfig-a013-20200816
i386                 randconfig-a015-20200816
i386                 randconfig-a014-20200816
i386                 randconfig-a012-20200816
i386                 randconfig-a016-20200817
i386                 randconfig-a011-20200817
i386                 randconfig-a013-20200817
i386                 randconfig-a015-20200817
i386                 randconfig-a014-20200817
i386                 randconfig-a012-20200817
i386                 randconfig-a011-20200818
i386                 randconfig-a013-20200818
i386                 randconfig-a012-20200818
i386                 randconfig-a016-20200818
i386                 randconfig-a015-20200818
i386                 randconfig-a014-20200818
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
