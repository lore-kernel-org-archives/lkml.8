Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB1FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10BAB20679
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390733AbgFYJsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:48:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:32614 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390179AbgFYJse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:48:34 -0400
IronPort-SDR: 7WJ4DdlX4qlpHM+ib+12/9U4N9CSZwjNrIOqK91ExS97JiwNyrI7dfBGgShvta/iI/po2iJTtz
 d5In+fHjwQ+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="143922490"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="143922490"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 02:48:32 -0700
IronPort-SDR: +YAsDo8TIWp1RmBsiqhWdW1dYFk10mwm17gdSRs6hH91DmsFisdmNLIHGTpn7Mfnl74wA3x1Rj
 jRIriK/hDWtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="479584855"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jun 2020 02:48:31 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1joOUg-0001Wx-CY; Thu, 25 Jun 2020 09:48:30 +0000
Date:   Thu, 25 Jun 2020 17:47:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD REGRESSION
 d2f8491368e57b6385e17c0db29d732d2f1eacaa
Message-ID: <5ef472c2.8RTRHNkZPcEYxWYV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: d2f8491368e57b6385e17c0db29d732d2f1eacaa  rcu: Fixup noinstr warnings

Error/Warning in current branch:

kernel/rcu/tree.c:251:8: error: implicit declaration of function 'arch_atomic_add_return'; did you mean 'atomic_add_return'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:281:3: error: implicit declaration of function 'arch_atomic_andnot'; did you mean 'atomic_andnot'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:314:11: error: implicit declaration of function 'arch_atomic_read'; did you mean 'atomic_read'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:314:34: sparse: sparse: not a function <noident>

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- alpha-randconfig-r016-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- arc-allyesconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- arc-defconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- ia64-randconfig-r012-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- ia64-randconfig-r013-20200624
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
|-- nds32-defconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- nds32-randconfig-r005-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- nios2-randconfig-r015-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- openrisc-allyesconfig
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- openrisc-randconfig-r002-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- openrisc-randconfig-r006-20200624
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
|-- riscv-randconfig-c022-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
|-- riscv-randconfig-r004-20200624
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
|-- s390-randconfig-r001-20200624
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
|   |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
`-- s390-randconfig-s031-20200624
    |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_add_return
    |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_andnot
    |-- kernel-rcu-tree.c:error:implicit-declaration-of-function-arch_atomic_read
    `-- kernel-rcu-tree.c:sparse:sparse:not-a-function-noident

elapsed time: 720m

configs tested: 106
configs skipped: 6

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arc                     haps_hs_smp_defconfig
s390                             allyesconfig
powerpc                          g5_defconfig
mips                        jmr3927_defconfig
sh                           se7751_defconfig
arm                       imx_v6_v7_defconfig
arm                            xcep_defconfig
arm                      pxa255-idp_defconfig
arm                          tango4_defconfig
arm                             pxa_defconfig
arm                         lpc18xx_defconfig
mips                           ip27_defconfig
arm                     eseries_pxa_defconfig
i386                             alldefconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
m68k                          amiga_defconfig
sh                         microdev_defconfig
microblaze                      mmu_defconfig
parisc                            allnoconfig
arm                            lart_defconfig
mips                      loongson3_defconfig
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
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
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
