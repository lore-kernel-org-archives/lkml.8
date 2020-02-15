Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9642C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 15:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DB12082F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 15:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgBOPkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 10:40:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:26090 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgBOPkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 10:40:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2020 07:40:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,445,1574150400"; 
   d="scan'208";a="227658160"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 15 Feb 2020 07:40:04 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j2zY4-0005oV-6a; Sat, 15 Feb 2020 23:40:04 +0800
Date:   Sat, 15 Feb 2020 23:39:10 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.02.12a] BUILD REGRESSION
 35a305226917a71de1c060db96fed0520cf644d9
Message-ID: <5e48109e.Rc9lkmx8lkIIhrJV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.02.12a
branch HEAD: 35a305226917a71de1c060db96fed0520cf644d9  kcsan: Fix misreporting if concurrent races on same address

Regressions in current branch:

kernel/torture.c:239:3: error: implicit declaration of function 'rcutorture_sched_setaffinity'; did you mean '__NR_ia32_sched_setaffinity'? [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
`-- x86_64-randconfig-s0-20200215
    `-- kernel-torture.c:error:implicit-declaration-of-function-rcutorture_sched_setaffinity-did-you-mean-__NR_ia32_sched_setaffinity

TIMEOUT after 2883m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 10

ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
powerpc                             defconfig
x86_64                              fedora-25
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

configs tested: 134
configs skipped: 0

arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
sparc                            allyesconfig
microblaze                    nommu_defconfig
sh                                allnoconfig
riscv                    nommu_virt_defconfig
parisc                            allnoconfig
sh                  sh7785lcr_32bit_defconfig
um                                  defconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              allnoconfig
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
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
i386                 randconfig-a003-20200213
x86_64               randconfig-a003-20200213
i386                 randconfig-a001-20200213
x86_64               randconfig-a002-20200213
i386                 randconfig-a002-20200213
x86_64               randconfig-a001-20200213
parisc               randconfig-a001-20200213
riscv                randconfig-a001-20200213
mips                 randconfig-a001-20200213
m68k                 randconfig-a001-20200213
nds32                randconfig-a001-20200213
alpha                randconfig-a001-20200213
c6x                  randconfig-a001-20200213
sparc64              randconfig-a001-20200213
h8300                randconfig-a001-20200213
nios2                randconfig-a001-20200213
openrisc             randconfig-a001-20200213
sh                   randconfig-a001-20200213
csky                 randconfig-a001-20200213
s390                 randconfig-a001-20200213
xtensa               randconfig-a001-20200213
i386                 randconfig-c002-20200213
x86_64               randconfig-c003-20200213
i386                 randconfig-c001-20200213
x86_64               randconfig-c002-20200213
x86_64               randconfig-c001-20200213
i386                 randconfig-c003-20200213
x86_64               randconfig-d003-20200213
x86_64               randconfig-d001-20200213
i386                 randconfig-d003-20200213
x86_64               randconfig-d002-20200213
i386                 randconfig-d001-20200213
i386                 randconfig-d002-20200213
i386                 randconfig-f001-20200213
x86_64               randconfig-f002-20200213
i386                 randconfig-f002-20200213
x86_64               randconfig-f001-20200213
x86_64               randconfig-f003-20200213
i386                 randconfig-f003-20200213
i386                 randconfig-h002-20200213
x86_64               randconfig-h002-20200213
i386                 randconfig-h001-20200213
x86_64               randconfig-h001-20200213
i386                 randconfig-h003-20200213
x86_64               randconfig-h003-20200213
arc                  randconfig-a001-20200213
sparc                randconfig-a001-20200213
ia64                 randconfig-a001-20200213
arm                  randconfig-a001-20200213
arm64                randconfig-a001-20200213
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                    lkp
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
