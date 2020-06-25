Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FA7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AEF620709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390999AbgFYJst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:48:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:29041 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390400AbgFYJss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:48:48 -0400
IronPort-SDR: XgNTbabQIT471Qrh4uVNpPOuq1d1Za6leSmfDkF4KoTW+EBjwIowVQnGpYgJCdIDrlcG5HBYSa
 WjikPv1JavwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="132260065"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="132260065"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 02:48:32 -0700
IronPort-SDR: 8wx9e1eEOOTXQ4P6r6V9Afp+8O9xPFNWGjDnwRE4Oki38F1vS47D/XmkTW0VbzhHzHbraGfje/
 EmmjV1E6/3Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="311054991"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Jun 2020 02:48:30 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1joOUg-0001Wu-8g; Thu, 25 Jun 2020 09:48:30 +0000
Date:   Thu, 25 Jun 2020 17:47:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/urgent] BUILD REGRESSION
 239341154165cec3676955bab4cc1d61852257ed
Message-ID: <5ef472b9.5Jxxgaydszvpulxx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/urgent
branch HEAD: 239341154165cec3676955bab4cc1d61852257ed  rcu: Fixup noinstr warnings

Error/Warning in current branch:

kernel/rcu/tree.c:240:8: error: implicit declaration of function 'arch_atomic_add_return'; did you mean 'atomic_add_return'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:251:8: error: implicit declaration of function 'arch_atomic_add_return'; did you mean 'atomic_add_return'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:253:8: error: implicit declaration of function 'arch_atomic_add_return'; did you mean 'atomic_add_return'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:270:3: error: implicit declaration of function 'arch_atomic_andnot'; did you mean 'atomic_andnot'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:281:3: error: implicit declaration of function 'arch_atomic_andnot'; did you mean 'atomic_andnot'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:283:3: error: implicit declaration of function 'arch_atomic_andnot'; did you mean 'atomic_andnot'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:303:11: error: implicit declaration of function 'arch_atomic_read'; did you mean 'atomic_read'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:314:11: error: implicit declaration of function 'arch_atomic_read'; did you mean 'atomic_read'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:316:11: error: implicit declaration of function 'arch_atomic_read'; did you mean 'atomic_read'? [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arc-allyesconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- arc-defconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- arc-randconfig-c003-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- arc-randconfig-c021-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- arm-allmodconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- arm-allyesconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- arm-defconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- h8300-randconfig-r031-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- ia64-allmodconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- ia64-allnoconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- ia64-allyesconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- ia64-defconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- ia64-randconfig-c004-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- m68k-randconfig-r016-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- mips-allmodconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- mips-allyesconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- mips-loongson1b_defconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- nds32-randconfig-c022-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- openrisc-allyesconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- openrisc-randconfig-c021-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- parisc-allmodconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- parisc-allyesconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- parisc-defconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- parisc-randconfig-r003-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- parisc-randconfig-r035-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- riscv-allmodconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- riscv-allyesconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- riscv-defconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- riscv-randconfig-c023-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- riscv-randconfig-r033-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- s390-allmodconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- s390-allnoconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- s390-allyesconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- s390-defconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- s390-randconfig-r003-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- s390-randconfig-r006-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- s390-randconfig-r034-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- s390-randconfig-s031-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- s390-randconfig-s032-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- sparc-allmodconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- sparc-allyesconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- sparc64-allmodconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- sparc64-allyesconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- sparc64-defconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
`-- xtensa-randconfig-r023-20200624
    |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
    |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
    `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read

elapsed time: 720m

configs tested: 106
configs skipped: 3

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arc                     haps_hs_smp_defconfig
s390                             allyesconfig
powerpc                          g5_defconfig
mips                        jmr3927_defconfig
i386                             alldefconfig
nds32                             allnoconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
parisc                            allnoconfig
arm                            lart_defconfig
mips                      loongson3_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
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
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
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
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200624
i386                 randconfig-a006-20200624
i386                 randconfig-a003-20200624
i386                 randconfig-a001-20200624
i386                 randconfig-a005-20200624
i386                 randconfig-a004-20200624
x86_64               randconfig-a004-20200624
x86_64               randconfig-a002-20200624
x86_64               randconfig-a003-20200624
x86_64               randconfig-a005-20200624
x86_64               randconfig-a001-20200624
x86_64               randconfig-a006-20200624
i386                 randconfig-a013-20200624
i386                 randconfig-a016-20200624
i386                 randconfig-a012-20200624
i386                 randconfig-a014-20200624
i386                 randconfig-a011-20200624
i386                 randconfig-a015-20200624
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
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
