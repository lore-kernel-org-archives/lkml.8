Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4803C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9119120771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgFWFIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 01:08:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:8335 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbgFWFI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 01:08:29 -0400
IronPort-SDR: 1D7Elj0jaHDY4oTVfFwTcVi8qIaLOpWWUMR6oGiAMELizN4XB4xQ4Pvj0PVteHD38QNwBfuhu0
 yCJNOACoxCjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="132378471"
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="132378471"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 22:08:28 -0700
IronPort-SDR: Q290IY4chja4vvP6+Aq1hh17GFbP1qKUGqcj6+TIVfZOkKJLwoQ46pdKcGG+okP1UhPuNdCi1t
 vp2uPA9nSIvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="478730363"
Received: from lkp-server01.sh.intel.com (HELO f484c95e4fd1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2020 22:08:27 -0700
Received: from kbuild by f484c95e4fd1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jnbAY-0000cL-Lb; Tue, 23 Jun 2020 05:08:26 +0000
Date:   Tue, 23 Jun 2020 13:08:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fsgsbase] BUILD SUCCESS
 a5d25e01c8146ad8846da4760422e12242fceafe
Message-ID: <5ef18e3a.LIR3zB4nVP0Vi8j8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/fsgsbase
branch HEAD: a5d25e01c8146ad8846da4760422e12242fceafe  selftests/x86: Add a syscall_arg_fault_64 test for negative GSBASE

elapsed time: 728m

configs tested: 126
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                           corgi_defconfig
arm                        realview_defconfig
xtensa                           allyesconfig
arm                            mmp2_defconfig
mips                malta_kvm_guest_defconfig
arm                         s3c6400_defconfig
xtensa                           alldefconfig
sh                  sh7785lcr_32bit_defconfig
parisc                           alldefconfig
mips                malta_qemu_32r6_defconfig
arc                    vdk_hs38_smp_defconfig
arm                       netwinder_defconfig
mips                          ath79_defconfig
xtensa                    xip_kc705_defconfig
arm                        keystone_defconfig
arm                       versatile_defconfig
m68k                            mac_defconfig
sh                           sh2007_defconfig
arm                           efm32_defconfig
m68k                             alldefconfig
m68k                         apollo_defconfig
powerpc                     pseries_defconfig
sh                        sh7785lcr_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200622
i386                 randconfig-a002-20200622
i386                 randconfig-a003-20200622
i386                 randconfig-a001-20200622
i386                 randconfig-a005-20200622
i386                 randconfig-a004-20200622
x86_64               randconfig-a012-20200623
x86_64               randconfig-a011-20200623
x86_64               randconfig-a013-20200623
x86_64               randconfig-a014-20200623
x86_64               randconfig-a015-20200623
x86_64               randconfig-a016-20200623
i386                 randconfig-a013-20200622
i386                 randconfig-a016-20200622
i386                 randconfig-a012-20200622
i386                 randconfig-a014-20200622
i386                 randconfig-a015-20200622
i386                 randconfig-a011-20200622
x86_64               randconfig-a004-20200622
x86_64               randconfig-a002-20200622
x86_64               randconfig-a003-20200622
x86_64               randconfig-a005-20200622
x86_64               randconfig-a001-20200622
x86_64               randconfig-a006-20200622
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
