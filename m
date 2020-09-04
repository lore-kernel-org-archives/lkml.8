Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B764C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 23:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4722078E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 23:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgIDXBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 19:01:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:31237 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbgIDXBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 19:01:12 -0400
IronPort-SDR: aOvZiXYYWAAM9RzBPFcK/lorYHx1PZYGMklQnX5ioa8VVT0E0SL+T9vaSbMWxrmAVXgxrBq6Pd
 yLVSBmmjGAqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="145528279"
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="145528279"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 16:01:09 -0700
IronPort-SDR: RCgIArn/F5LnEEqgTeAOh2yQawR8zq1SQwhvD8bmWFCMLner/pCRE5XHTD77RueaCC7ut8S3jX
 iEf5Hn29OTxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="332314347"
Received: from lkp-server02.sh.intel.com (HELO c089623da072) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 16:01:07 -0700
Received: from kbuild by c089623da072 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kEKhe-00009z-Ic; Fri, 04 Sep 2020 23:01:06 +0000
Date:   Sat, 05 Sep 2020 07:00:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 eb3621798bcdd34ba480109bac357ba6a784d3e2
Message-ID: <5f52c6f8.n8YL1k4vn3ielAEt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: eb3621798bcdd34ba480109bac357ba6a784d3e2  x86/entry/64: Do not include inst.h in calling.h

elapsed time: 724m

configs tested: 108
configs skipped: 61

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     mpc5200_defconfig
arm                         hackkit_defconfig
mips                            ar7_defconfig
arm                           h5000_defconfig
mips                 decstation_r4k_defconfig
i386                             alldefconfig
powerpc                      pasemi_defconfig
powerpc                       ppc64_defconfig
parisc                generic-32bit_defconfig
arm                         assabet_defconfig
powerpc                  mpc866_ads_defconfig
nds32                             allnoconfig
parisc                generic-64bit_defconfig
arm                         lpc32xx_defconfig
arm                          moxart_defconfig
arm                            lart_defconfig
sh                            shmin_defconfig
ia64                            zx1_defconfig
arc                     nsimosci_hs_defconfig
arm                           h3600_defconfig
h8300                               defconfig
arm                       spear13xx_defconfig
arm                         orion5x_defconfig
arm                              alldefconfig
sh                          kfr2r09_defconfig
arm64                            alldefconfig
sh                        apsh4ad0a_defconfig
mips                  decstation_64_defconfig
powerpc                      mgcoge_defconfig
mips                malta_qemu_32r6_defconfig
arm                           omap1_defconfig
arm                        mini2440_defconfig
mips                           ci20_defconfig
m68k                             alldefconfig
powerpc64                           defconfig
sh                               j2_defconfig
microblaze                          defconfig
s390                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
i386                 randconfig-a004-20200904
i386                 randconfig-a005-20200904
i386                 randconfig-a006-20200904
i386                 randconfig-a002-20200904
i386                 randconfig-a003-20200904
i386                 randconfig-a001-20200904
x86_64               randconfig-a013-20200904
x86_64               randconfig-a011-20200904
x86_64               randconfig-a016-20200904
x86_64               randconfig-a012-20200904
x86_64               randconfig-a015-20200904
x86_64               randconfig-a014-20200904
i386                 randconfig-a016-20200904
i386                 randconfig-a015-20200904
i386                 randconfig-a011-20200904
i386                 randconfig-a013-20200904
i386                 randconfig-a014-20200904
i386                 randconfig-a012-20200904
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
x86_64               randconfig-a006-20200904
x86_64               randconfig-a004-20200904
x86_64               randconfig-a003-20200904
x86_64               randconfig-a005-20200904
x86_64               randconfig-a001-20200904
x86_64               randconfig-a002-20200904

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
