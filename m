Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C52C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEA52078C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbgDAPaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:30:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:19267 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732623AbgDAPaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:30:46 -0400
IronPort-SDR: flVoM31WLMBptOVR0c7Z2uxtH9LO3WKzb8xG0aHK2U56OYMfILjZ7xIGdtTpJ6O0YpPNMWQHLK
 fj5PCMaSHKAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 08:30:44 -0700
IronPort-SDR: kbU5BW6rgXzhDfKSksRTMAz5/lKyjLDPl9mXeGnDY7kK/8MIUdRXttuw+PvJV9kZgJ8KoruVxu
 OfVfYPypUnyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="267714376"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Apr 2020 08:30:43 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jJfKE-000IsL-UO; Wed, 01 Apr 2020 23:30:42 +0800
Date:   Wed, 01 Apr 2020 23:30:06 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.03.30a] BUILD REGRESSION
 3cc6f49bd92ebef95e8f98191e27b2fd2600eac0
Message-ID: <5e84b37e.rFWKmGsPXOeC53gJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.03.30a
branch HEAD: 3cc6f49bd92ebef95e8f98191e27b2fd2600eac0  kcsan: Change data_race() to no longer require marking racing accesses

Regressions in current branch:

kernel/rcu/tree.c:2948:4: error: implicit declaration of function 'vfree'; did you mean 'kfree'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:2948:4: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:2951:4: error: implicit declaration of function 'vfree'; did you mean 'kfree'? [-Werror=implicit-function-declaration]
kernel/rcu/tree.c:2951:4: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
|-- mips-32r2_defconfig
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-vfree-did-you-mean-kvfree
|-- mips-allmodconfig
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-vfree-did-you-mean-kvfree
|-- mips-allyesconfig
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-vfree-did-you-mean-kvfree
|-- sh-j2_defconfig
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-vfree-did-you-mean-kvfree
|-- sparc-allyesconfig
|   `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-vfree-did-you-mean-kfree
`-- sparc-randconfig-a001-20200401
    `-- kernel-rcu-tree.c:error:implicit-declaration-of-function-vfree-did-you-mean-kfree

elapsed time: 484m

configs tested: 152
configs skipped: 0

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200331
x86_64               randconfig-a002-20200331
x86_64               randconfig-a003-20200331
i386                 randconfig-a001-20200331
i386                 randconfig-a002-20200331
i386                 randconfig-a003-20200331
nds32                randconfig-a001-20200401
m68k                 randconfig-a001-20200401
alpha                randconfig-a001-20200401
parisc               randconfig-a001-20200401
riscv                randconfig-a001-20200401
mips                 randconfig-a001-20200401
csky                 randconfig-a001-20200331
openrisc             randconfig-a001-20200331
s390                 randconfig-a001-20200331
sh                   randconfig-a001-20200331
xtensa               randconfig-a001-20200331
csky                 randconfig-a001-20200401
openrisc             randconfig-a001-20200401
s390                 randconfig-a001-20200401
sh                   randconfig-a001-20200401
xtensa               randconfig-a001-20200401
i386                 randconfig-c001-20200401
x86_64               randconfig-d001-20200401
x86_64               randconfig-d002-20200401
x86_64               randconfig-d003-20200401
i386                 randconfig-d001-20200401
i386                 randconfig-d002-20200401
i386                 randconfig-d003-20200401
i386                 randconfig-e001-20200401
x86_64               randconfig-e002-20200401
i386                 randconfig-e003-20200401
x86_64               randconfig-e001-20200401
i386                 randconfig-e002-20200401
i386                 randconfig-f001-20200401
i386                 randconfig-f003-20200401
x86_64               randconfig-f003-20200401
x86_64               randconfig-f001-20200401
i386                 randconfig-f002-20200401
x86_64               randconfig-f002-20200401
x86_64               randconfig-g001-20200401
x86_64               randconfig-g002-20200401
x86_64               randconfig-g003-20200401
i386                 randconfig-g001-20200401
i386                 randconfig-g002-20200401
i386                 randconfig-g003-20200401
x86_64               randconfig-h002-20200401
i386                 randconfig-h002-20200401
i386                 randconfig-h003-20200401
i386                 randconfig-h001-20200401
x86_64               randconfig-h001-20200401
x86_64               randconfig-h003-20200401
arc                  randconfig-a001-20200401
arm                  randconfig-a001-20200401
arm64                randconfig-a001-20200401
ia64                 randconfig-a001-20200401
powerpc              randconfig-a001-20200401
sparc                randconfig-a001-20200401
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
