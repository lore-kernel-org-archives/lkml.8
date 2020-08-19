Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42528C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF6F207FB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHSAuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:50:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:24261 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbgHSAuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 20:50:20 -0400
IronPort-SDR: KVfiauIKacfAoCvg33mCTgrJB/TdrVF6iXplsfAWmXeyRz8fvzHHWHfEpIVp82euI5PdXeOcWX
 2drNsDOfbZLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="152647393"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="152647393"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 17:50:20 -0700
IronPort-SDR: 9mioBtq8rPtEvZYpvQ6c6FBZSVcag7D1fvDRnZahhahO5XJqQnyNY7c+itkBxOOKOwT7mNRjC6
 InmoxQ2afDyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="278192820"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Aug 2020 17:50:18 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k8CJ0-0001Wu-Az; Wed, 19 Aug 2020 00:50:18 +0000
Date:   Wed, 19 Aug 2020 08:49:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 24633d901ea44fe99bc9a2d01a3881fa097b78b3
Message-ID: <5f3c771b.WcMp6q5esY9c/ti/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/urgent
branch HEAD: 24633d901ea44fe99bc9a2d01a3881fa097b78b3  perf/x86/intel/uncore: Add BW counters for GT, IA and IO breakdown

elapsed time: 4042m

configs tested: 151
configs skipped: 85

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
sh                        apsh4ad0a_defconfig
arm                            hisi_defconfig
ia64                             allyesconfig
sh                          urquell_defconfig
sh                        edosk7760_defconfig
sh                           se7712_defconfig
arm                         s5pv210_defconfig
arm                        mvebu_v7_defconfig
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
mips                         mpc30x_defconfig
alpha                               defconfig
arm                           tegra_defconfig
arm                         s3c2410_defconfig
arm                       aspeed_g4_defconfig
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
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
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
i386                 randconfig-a006-20200818
i386                 randconfig-a003-20200818
i386                 randconfig-a004-20200818
i386                 randconfig-a005-20200817
i386                 randconfig-a001-20200817
i386                 randconfig-a002-20200817
i386                 randconfig-a003-20200817
i386                 randconfig-a006-20200817
i386                 randconfig-a004-20200817
x86_64               randconfig-a006-20200817
x86_64               randconfig-a001-20200817
x86_64               randconfig-a005-20200817
x86_64               randconfig-a003-20200817
x86_64               randconfig-a002-20200817
x86_64               randconfig-a004-20200817
x86_64               randconfig-a013-20200818
x86_64               randconfig-a016-20200818
x86_64               randconfig-a012-20200818
x86_64               randconfig-a011-20200818
x86_64               randconfig-a014-20200818
x86_64               randconfig-a015-20200818
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
i386                 randconfig-a016-20200818
i386                 randconfig-a011-20200818
i386                 randconfig-a015-20200818
i386                 randconfig-a013-20200818
i386                 randconfig-a012-20200818
i386                 randconfig-a014-20200818
i386                 randconfig-a016-20200817
i386                 randconfig-a011-20200817
i386                 randconfig-a013-20200817
i386                 randconfig-a015-20200817
i386                 randconfig-a014-20200817
i386                 randconfig-a012-20200817
x86_64               randconfig-a006-20200819
x86_64               randconfig-a001-20200819
x86_64               randconfig-a003-20200819
x86_64               randconfig-a005-20200819
x86_64               randconfig-a004-20200819
x86_64               randconfig-a002-20200819
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
