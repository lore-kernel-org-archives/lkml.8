Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BA3C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 23:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736372064C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 23:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgBVXU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 18:20:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:52508 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbgBVXU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 18:20:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2020 15:20:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,473,1574150400"; 
   d="scan'208";a="316403318"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Feb 2020 15:20:54 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j5e4s-000503-13; Sun, 23 Feb 2020 07:20:54 +0800
Date:   Sun, 23 Feb 2020 07:20:01 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 8aa63de65a79bd8c5c1c2b19452e35f58b043ac7
Message-ID: <5e51b721.7v6Z0Qwhoaoy1b+W%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 8aa63de65a79bd8c5c1c2b19452e35f58b043ac7  kcsan: Add option for verbose reporting

elapsed time: 1088m

configs tested: 195
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
riscv                             allnoconfig
h8300                    h8300h-sim_defconfig
openrisc                 simple_smp_defconfig
microblaze                    nommu_defconfig
riscv                            allmodconfig
ia64                                defconfig
riscv                            allyesconfig
m68k                       m5475evb_defconfig
i386                                defconfig
parisc                generic-32bit_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                      fuloong2e_defconfig
mips                             allyesconfig
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                             allmodconfig
mips                              allnoconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200223
x86_64               randconfig-a002-20200223
x86_64               randconfig-a003-20200223
i386                 randconfig-a001-20200223
i386                 randconfig-a002-20200223
i386                 randconfig-a003-20200223
alpha                randconfig-a001-20200222
m68k                 randconfig-a001-20200222
mips                 randconfig-a001-20200222
nds32                randconfig-a001-20200222
parisc               randconfig-a001-20200222
riscv                randconfig-a001-20200222
alpha                randconfig-a001-20200223
m68k                 randconfig-a001-20200223
mips                 randconfig-a001-20200223
nds32                randconfig-a001-20200223
parisc               randconfig-a001-20200223
c6x                  randconfig-a001-20200222
h8300                randconfig-a001-20200222
microblaze           randconfig-a001-20200222
nios2                randconfig-a001-20200222
sparc64              randconfig-a001-20200222
c6x                  randconfig-a001-20200223
h8300                randconfig-a001-20200223
microblaze           randconfig-a001-20200223
nios2                randconfig-a001-20200223
sparc64              randconfig-a001-20200223
csky                 randconfig-a001-20200223
openrisc             randconfig-a001-20200223
s390                 randconfig-a001-20200223
sh                   randconfig-a001-20200223
xtensa               randconfig-a001-20200223
openrisc             randconfig-a001-20200222
sh                   randconfig-a001-20200222
s390                 randconfig-a001-20200222
xtensa               randconfig-a001-20200222
csky                 randconfig-a001-20200222
x86_64               randconfig-b001-20200222
x86_64               randconfig-b002-20200222
x86_64               randconfig-b003-20200222
i386                 randconfig-b001-20200222
i386                 randconfig-b002-20200222
i386                 randconfig-b003-20200222
x86_64               randconfig-b001-20200223
x86_64               randconfig-b002-20200223
x86_64               randconfig-b003-20200223
i386                 randconfig-b001-20200223
i386                 randconfig-b002-20200223
i386                 randconfig-b003-20200223
x86_64               randconfig-e001-20200223
x86_64               randconfig-e002-20200223
x86_64               randconfig-e003-20200223
i386                 randconfig-e001-20200223
i386                 randconfig-e002-20200223
i386                 randconfig-e003-20200223
x86_64               randconfig-e002-20200222
i386                 randconfig-e001-20200222
x86_64               randconfig-e003-20200222
x86_64               randconfig-e001-20200222
x86_64               randconfig-f001-20200222
x86_64               randconfig-f002-20200222
x86_64               randconfig-f003-20200222
i386                 randconfig-f001-20200222
i386                 randconfig-f002-20200222
i386                 randconfig-f003-20200222
x86_64               randconfig-f001-20200223
x86_64               randconfig-f002-20200223
x86_64               randconfig-f003-20200223
i386                 randconfig-f001-20200223
i386                 randconfig-f002-20200223
i386                 randconfig-f003-20200223
x86_64               randconfig-g001-20200222
i386                 randconfig-g002-20200222
i386                 randconfig-g003-20200222
i386                 randconfig-g001-20200222
x86_64               randconfig-g003-20200222
x86_64               randconfig-g002-20200222
x86_64               randconfig-g001-20200223
x86_64               randconfig-g002-20200223
x86_64               randconfig-g003-20200223
i386                 randconfig-g001-20200223
i386                 randconfig-g002-20200223
i386                 randconfig-g003-20200223
x86_64               randconfig-h001-20200222
x86_64               randconfig-h002-20200222
x86_64               randconfig-h003-20200222
i386                 randconfig-h001-20200222
i386                 randconfig-h002-20200222
i386                 randconfig-h003-20200222
x86_64               randconfig-h001-20200223
x86_64               randconfig-h002-20200223
x86_64               randconfig-h003-20200223
i386                 randconfig-h001-20200223
i386                 randconfig-h002-20200223
i386                 randconfig-h003-20200223
arc                  randconfig-a001-20200223
arm                  randconfig-a001-20200223
arm64                randconfig-a001-20200223
ia64                 randconfig-a001-20200223
powerpc              randconfig-a001-20200223
sparc                randconfig-a001-20200223
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
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
