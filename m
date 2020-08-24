Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286D7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 01:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D02206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 01:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgHXBBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 21:01:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:21328 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgHXBBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 21:01:02 -0400
IronPort-SDR: mOtPa4itc0Z7FoS2QEG3ConlUAeOP+4/CIxdbjrzskFnt6KtIOnf9uHe/JDfnMXDJx3buUqBSL
 gWnRppGHWG5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="143601094"
X-IronPort-AV: E=Sophos;i="5.76,346,1592895600"; 
   d="scan'208";a="143601094"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2020 18:01:01 -0700
IronPort-SDR: HOPLytdi0qSD8Jze/GbUv39Vf2XajDfoBGzWg4Z9I9OL2JoF+tC59rJVtZlFrmqWkFlLxL1Jxh
 5Opu6MMbKq+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,346,1592895600"; 
   d="scan'208";a="442997058"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2020 18:01:00 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kA0r6-0002Jl-1n; Mon, 24 Aug 2020 01:01:00 +0000
Date:   Mon, 24 Aug 2020 09:00:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 e2d977c9f1abd1d199b412f8f83c1727808b794d
Message-ID: <5f431121.zbsoi9DC7D9Ftwsg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: e2d977c9f1abd1d199b412f8f83c1727808b794d  timekeeping: Provide multi-timestamp accessor to NMI safe timekeeper

elapsed time: 723m

configs tested: 87
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                       m5475evb_defconfig
m68k                       bvme6000_defconfig
m68k                           sun3_defconfig
arc                            hsdk_defconfig
csky                             alldefconfig
riscv                    nommu_virt_defconfig
arm                        neponset_defconfig
h8300                            allyesconfig
sh                          polaris_defconfig
sh                          urquell_defconfig
powerpc                             defconfig
m68k                         apollo_defconfig
mips                      malta_kvm_defconfig
powerpc                          g5_defconfig
x86_64                           alldefconfig
arm                          ep93xx_defconfig
arm                         lpc32xx_defconfig
sh                             shx3_defconfig
powerpc                    amigaone_defconfig
arm                          tango4_defconfig
sh                            shmin_defconfig
arm                           tegra_defconfig
arm                            mps2_defconfig
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
x86_64               randconfig-a002-20200823
x86_64               randconfig-a003-20200823
x86_64               randconfig-a005-20200823
x86_64               randconfig-a001-20200823
x86_64               randconfig-a006-20200823
x86_64               randconfig-a004-20200823
i386                 randconfig-a002-20200823
i386                 randconfig-a004-20200823
i386                 randconfig-a003-20200823
i386                 randconfig-a005-20200823
i386                 randconfig-a006-20200823
i386                 randconfig-a001-20200823
i386                 randconfig-a013-20200823
i386                 randconfig-a012-20200823
i386                 randconfig-a011-20200823
i386                 randconfig-a016-20200823
i386                 randconfig-a014-20200823
i386                 randconfig-a015-20200823
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
