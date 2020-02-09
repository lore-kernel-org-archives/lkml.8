Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BDFC35242
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 03:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20A12080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 03:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgBIDDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 22:03:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:31731 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgBIDDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 22:03:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 19:03:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,419,1574150400"; 
   d="scan'208";a="379788041"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Feb 2020 19:03:02 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j0cs9-00018W-Td; Sun, 09 Feb 2020 11:03:01 +0800
Date:   Sun, 09 Feb 2020 11:02:22 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.02.05a] BUILD REGRESSION
 7ce14e5d0186428062a09b295296daf5cf420d88
Message-ID: <5e3f763e.JFiVUi7T9peVoIIL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.02.05a
branch HEAD: 7ce14e5d0186428062a09b295296daf5cf420d88  EXP: rcutorture hack to force CPU hotplug onto CPU 0

Regressions in current branch:

kernel/torture.c:239:3: error: implicit declaration of function 'rcutorture_sched_setaffinity'; did you mean '__NR_sched_setaffinity'? [-Werror=implicit-function-declaration]
kernel/torture.c:239:3: error: implicit declaration of function 'rcutorture_sched_setaffinity'; did you mean 'sched_setaffinity'? [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
|-- arm64-randconfig-a001-20200207
|   `-- kernel-torture.c:error:implicit-declaration-of-function-rcutorture_sched_setaffinity-did-you-mean-__NR_sched_setaffinity
|-- i386-randconfig-a003-20200207
|   `-- kernel-torture.c:error:implicit-declaration-of-function-rcutorture_sched_setaffinity-did-you-mean-sched_setaffinity
|-- i386-randconfig-b001-20200207
|   `-- kernel-torture.c:error:implicit-declaration-of-function-rcutorture_sched_setaffinity-did-you-mean-__NR_sched_setaffinity
|-- i386-randconfig-c003-20200207
|   `-- kernel-torture.c:error:implicit-declaration-of-function-rcutorture_sched_setaffinity-did-you-mean-__NR_sched_setaffinity
|-- i386-randconfig-g001-20200207
|   `-- kernel-torture.c:error:implicit-declaration-of-function-rcutorture_sched_setaffinity-did-you-mean-__NR_sched_setaffinity
|-- i386-randconfig-h003-20200207
|   `-- kernel-torture.c:error:implicit-declaration-of-function-rcutorture_sched_setaffinity-did-you-mean-__NR_sched_setaffinity
|-- sparc64-randconfig-a001-20200207
|   `-- kernel-torture.c:error:implicit-declaration-of-function-rcutorture_sched_setaffinity-did-you-mean-__NR_sched_setaffinity
|-- x86_64-randconfig-a002-20200207
|   `-- kernel-torture.c:error:implicit-declaration-of-function-rcutorture_sched_setaffinity-did-you-mean-sched_setaffinity
|-- x86_64-randconfig-b001-20200207
|   `-- kernel-torture.c:error:implicit-declaration-of-function-rcutorture_sched_setaffinity-did-you-mean-__NR_sched_setaffinity
|-- x86_64-randconfig-d002-20200207
|   `-- kernel-torture.c:error:implicit-declaration-of-function-rcutorture_sched_setaffinity-did-you-mean-sched_setaffinity
|-- x86_64-randconfig-d003-20200206
|   `-- kernel-torture.c:error:implicit-declaration-of-function-rcutorture_sched_setaffinity-did-you-mean-sched_setaffinity
`-- x86_64-randconfig-h003-20200207
    `-- kernel-torture.c:error:implicit-declaration-of-function-rcutorture_sched_setaffinity-did-you-mean-__NR_sched_setaffinity

TIMEOUT after 3425m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 1

parisc                            allyesonfig

configs tested: 188
configs skipped: 0

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
sparc                            allyesconfig
riscv                          rv32_defconfig
s390                                defconfig
i386                              allnoconfig
um                           x86_64_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
sh                                allnoconfig
m68k                       m5475evb_defconfig
mips                      fuloong2e_defconfig
arc                                 defconfig
parisc                              defconfig
riscv                    nommu_virt_defconfig
s390                       zfcpdump_defconfig
i386                             allyesconfig
powerpc                             defconfig
riscv                               defconfig
mips                             allmodconfig
powerpc                       ppc64_defconfig
mips                             allyesconfig
s390                              allnoconfig
s390                             alldefconfig
um                                  defconfig
i386                             alldefconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                               defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      malta_kvm_defconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                            allnoconfig
x86_64               randconfig-a001-20200207
x86_64               randconfig-a002-20200207
x86_64               randconfig-a003-20200207
i386                 randconfig-a001-20200207
i386                 randconfig-a002-20200207
i386                 randconfig-a003-20200207
alpha                randconfig-a001-20200207
parisc               randconfig-a001-20200207
m68k                 randconfig-a001-20200207
nds32                randconfig-a001-20200207
mips                 randconfig-a001-20200207
riscv                randconfig-a001-20200207
h8300                randconfig-a001-20200207
nios2                randconfig-a001-20200207
sparc64              randconfig-a001-20200207
microblaze           randconfig-a001-20200207
c6x                  randconfig-a001-20200207
sh                   randconfig-a001-20200207
csky                 randconfig-a001-20200207
s390                 randconfig-a001-20200207
xtensa               randconfig-a001-20200207
openrisc             randconfig-a001-20200207
i386                 randconfig-b001-20200207
x86_64               randconfig-b002-20200207
i386                 randconfig-b002-20200207
x86_64               randconfig-b001-20200207
i386                 randconfig-b003-20200207
x86_64               randconfig-b003-20200207
x86_64               randconfig-c001-20200207
x86_64               randconfig-c002-20200207
x86_64               randconfig-c003-20200207
i386                 randconfig-c001-20200207
i386                 randconfig-c002-20200207
i386                 randconfig-c003-20200207
x86_64               randconfig-d001-20200207
x86_64               randconfig-d002-20200207
x86_64               randconfig-d003-20200207
i386                 randconfig-d001-20200207
i386                 randconfig-d002-20200207
i386                 randconfig-d003-20200207
x86_64               randconfig-d003-20200206
i386                 randconfig-d001-20200206
x86_64               randconfig-d002-20200206
x86_64               randconfig-d001-20200206
i386                 randconfig-d003-20200206
i386                 randconfig-d002-20200206
x86_64               randconfig-e001-20200207
x86_64               randconfig-e002-20200207
x86_64               randconfig-e003-20200207
i386                 randconfig-e001-20200207
i386                 randconfig-e002-20200207
i386                 randconfig-e003-20200207
x86_64               randconfig-e001-20200206
x86_64               randconfig-e002-20200206
x86_64               randconfig-e003-20200206
i386                 randconfig-e001-20200206
i386                 randconfig-e002-20200206
i386                 randconfig-e003-20200206
i386                 randconfig-f002-20200207
i386                 randconfig-f003-20200207
x86_64               randconfig-f002-20200207
i386                 randconfig-f001-20200207
x86_64               randconfig-f001-20200207
x86_64               randconfig-f003-20200207
x86_64               randconfig-g003-20200207
i386                 randconfig-g001-20200207
x86_64               randconfig-g001-20200207
x86_64               randconfig-g002-20200207
i386                 randconfig-g002-20200207
i386                 randconfig-g003-20200207
x86_64               randconfig-g001-20200206
x86_64               randconfig-g002-20200206
x86_64               randconfig-g003-20200206
i386                 randconfig-g001-20200206
i386                 randconfig-g002-20200206
i386                 randconfig-g003-20200206
x86_64               randconfig-h001-20200207
x86_64               randconfig-h002-20200207
x86_64               randconfig-h003-20200207
i386                 randconfig-h001-20200207
i386                 randconfig-h002-20200207
i386                 randconfig-h003-20200207
x86_64               randconfig-h001-20200206
i386                 randconfig-h002-20200206
x86_64               randconfig-h002-20200206
i386                 randconfig-h003-20200206
x86_64               randconfig-h003-20200206
i386                 randconfig-h001-20200206
arc                  randconfig-a001-20200207
ia64                 randconfig-a001-20200207
sparc                randconfig-a001-20200207
arm64                randconfig-a001-20200207
arm                  randconfig-a001-20200207
powerpc              randconfig-a001-20200207
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
s390                             allmodconfig
s390                             allyesconfig
s390                          debug_defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                             i386_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
