Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4CCC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB8C206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCRByu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:54:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:20396 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgCRByu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:54:50 -0400
IronPort-SDR: D9Caq0MxUQi9MEDMEQOBWlwr43wk0XncmDsHRy9fdJxPGojMfq8892y4Lvf5thJ6kM+KRerQlY
 mKY2iBf4ODxg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 18:54:48 -0700
IronPort-SDR: dtd0P7il7UZlqTh4aPRn5QpejzS4R0/KBLnQzx+Pt+V3R611oK16dSF3SPqd46E0dSbq+LMMtN
 fGt9mGw9cvmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="248023779"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2020 18:54:47 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jENuw-00054d-9k; Wed, 18 Mar 2020 09:54:46 +0800
Date:   Wed, 18 Mar 2020 09:54:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.03.16a] BUILD REGRESSION
 ad7a7c12b09555e7c488ee3be512d549cd78a2c0
Message-ID: <5e717f50.Vg+fzwTrjHcEb84X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.03.16a
branch HEAD: ad7a7c12b09555e7c488ee3be512d549cd78a2c0  fixup! rcu-tasks: Make RCU Tasks Trace make use of RCU scheduler hooks

Regressions in current branch:

kernel/rcu/tasks.h:1000:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_qs'?
kernel/rcu/tasks.h:1070:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_qs'?

Error ids grouped by kconfigs:

recent_errors
|-- arc-defconfig
|   `-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_qs
|-- arm-efm32_defconfig
|   `-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_qs
|-- arm-exynos_defconfig
|   `-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_qs
|-- arm-multi_v5_defconfig
|   `-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_qs
|-- arm-tegra_defconfig
|   `-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_qs
|-- arm64-defconfig
|   `-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_qs
|-- arm64-randconfig-a001-20200317
|   `-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_qs
|-- i386-randconfig-d003-20200317
|   `-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_qs
|-- i386-randconfig-f002-20200317
|   `-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_qs
|-- openrisc-randconfig-a001-20200317
|   `-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_qs
`-- x86_64-randconfig-f001-20200317
    `-- kernel-rcu-tasks.h:error:rcu_tasks_rude-undeclared-(first-use-in-this-function)-did-you-mean-rcu_tasks_qs

elapsed time: 481m

configs tested: 178
configs skipped: 0

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
m68k                          multi_defconfig
mips                      malta_kvm_defconfig
s390                              allnoconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200317
x86_64               randconfig-a002-20200317
x86_64               randconfig-a003-20200317
i386                 randconfig-a001-20200317
i386                 randconfig-a002-20200317
i386                 randconfig-a003-20200317
x86_64               randconfig-a001-20200318
x86_64               randconfig-a002-20200318
x86_64               randconfig-a003-20200318
i386                 randconfig-a001-20200318
i386                 randconfig-a002-20200318
i386                 randconfig-a003-20200318
alpha                randconfig-a001-20200317
m68k                 randconfig-a001-20200317
mips                 randconfig-a001-20200317
nds32                randconfig-a001-20200317
parisc               randconfig-a001-20200317
h8300                randconfig-a001-20200317
sparc64              randconfig-a001-20200317
c6x                  randconfig-a001-20200317
nios2                randconfig-a001-20200317
microblaze           randconfig-a001-20200317
c6x                  randconfig-a001-20200318
h8300                randconfig-a001-20200318
microblaze           randconfig-a001-20200318
nios2                randconfig-a001-20200318
sparc64              randconfig-a001-20200318
xtensa               randconfig-a001-20200318
csky                 randconfig-a001-20200318
openrisc             randconfig-a001-20200318
sh                   randconfig-a001-20200318
s390                 randconfig-a001-20200318
csky                 randconfig-a001-20200317
openrisc             randconfig-a001-20200317
s390                 randconfig-a001-20200317
sh                   randconfig-a001-20200317
xtensa               randconfig-a001-20200317
x86_64               randconfig-b001-20200317
x86_64               randconfig-b002-20200317
x86_64               randconfig-b003-20200317
i386                 randconfig-b001-20200317
i386                 randconfig-b002-20200317
i386                 randconfig-b003-20200317
x86_64               randconfig-b001-20200318
x86_64               randconfig-b002-20200318
x86_64               randconfig-b003-20200318
i386                 randconfig-b001-20200318
i386                 randconfig-b002-20200318
i386                 randconfig-b003-20200318
x86_64               randconfig-c001-20200317
x86_64               randconfig-c002-20200317
x86_64               randconfig-c003-20200317
i386                 randconfig-c001-20200317
i386                 randconfig-c002-20200317
i386                 randconfig-c003-20200317
x86_64               randconfig-d001-20200317
x86_64               randconfig-d002-20200317
x86_64               randconfig-d003-20200317
i386                 randconfig-d001-20200317
i386                 randconfig-d002-20200317
i386                 randconfig-d003-20200317
x86_64               randconfig-f001-20200317
i386                 randconfig-f002-20200317
i386                 randconfig-f003-20200317
i386                 randconfig-f001-20200317
x86_64               randconfig-f002-20200317
x86_64               randconfig-f003-20200317
x86_64               randconfig-g001-20200317
x86_64               randconfig-g002-20200317
x86_64               randconfig-g003-20200317
i386                 randconfig-g001-20200317
i386                 randconfig-g002-20200317
i386                 randconfig-g003-20200317
arc                  randconfig-a001-20200317
ia64                 randconfig-a001-20200317
arm                  randconfig-a001-20200317
arm64                randconfig-a001-20200317
sparc                randconfig-a001-20200317
arc                  randconfig-a001-20200318
arm                  randconfig-a001-20200318
arm64                randconfig-a001-20200318
ia64                 randconfig-a001-20200318
powerpc              randconfig-a001-20200318
sparc                randconfig-a001-20200318
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             alldefconfig
s390                             allmodconfig
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
