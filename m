Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04325C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB49821D94
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgDFNOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:14:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:32779 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbgDFNOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:14:36 -0400
IronPort-SDR: 5FzChdVo7o/1FF87DrLbuGF9xgNINKjLV+0bPjzAi++vAGDqwLPSxciBdhmAbTd5oYI57z0PIG
 eXFLoe8Aqt1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 06:14:35 -0700
IronPort-SDR: WWjClO7zYoqarpOyzS7jgt1WUxjeeU/hMqCsrKKAnFxRBLCIJg4W9t9aCWr7vmykfyqofhw9c4
 Y1/hPpyshXwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,351,1580803200"; 
   d="scan'208";a="296654204"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2020 06:14:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jLRaE-0002YV-0w; Mon, 06 Apr 2020 21:14:34 +0800
Date:   Mon, 06 Apr 2020 21:14:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.04.03a] BUILD REGRESSION
 8c64539e2d8fbd96ad4bb60a96c5d9c1ef823572
Message-ID: <5e8b2b2a.tLKsAcVWdyasf98l%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.04.03a
branch HEAD: 8c64539e2d8fbd96ad4bb60a96c5d9c1ef823572  squash! ftrace: Use synchronize_rcu_tasks_rude() instead of ftrace_sync()

Error/Warning in current branch:

kernel/rcu/tasks.h:251:9: error: 'struct task_struct' has no member named 'rcu_tasks_idx'

Error/Warning ids grouped by kconfigs:

recent_errors
`-- powerpc-defconfig
    `-- kernel-rcu-tasks.h:error:struct-task_struct-has-no-member-named-rcu_tasks_idx

elapsed time: 945m

configs tested: 160
configs skipped: 0

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
sh                                allnoconfig
sh                            titan_defconfig
csky                                defconfig
mips                             allyesconfig
c6x                        evmc6678_defconfig
s390                             allmodconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
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
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a003-20200405
i386                 randconfig-a002-20200405
x86_64               randconfig-a002-20200405
x86_64               randconfig-a001-20200405
i386                 randconfig-a001-20200405
i386                 randconfig-a003-20200405
mips                 randconfig-a001-20200405
nds32                randconfig-a001-20200405
m68k                 randconfig-a001-20200405
parisc               randconfig-a001-20200405
alpha                randconfig-a001-20200405
riscv                randconfig-a001-20200405
sparc64              randconfig-a001-20200405
h8300                randconfig-a001-20200405
nios2                randconfig-a001-20200405
microblaze           randconfig-a001-20200405
c6x                  randconfig-a001-20200405
s390                 randconfig-a001-20200405
xtensa               randconfig-a001-20200405
csky                 randconfig-a001-20200405
openrisc             randconfig-a001-20200405
sh                   randconfig-a001-20200405
i386                 randconfig-b003-20200406
x86_64               randconfig-b002-20200406
x86_64               randconfig-b001-20200406
i386                 randconfig-b001-20200406
x86_64               randconfig-b003-20200406
i386                 randconfig-b002-20200406
i386                 randconfig-c003-20200405
i386                 randconfig-c001-20200405
x86_64               randconfig-c002-20200405
x86_64               randconfig-c003-20200405
i386                 randconfig-c002-20200405
x86_64               randconfig-c001-20200405
x86_64               randconfig-d003-20200406
x86_64               randconfig-d001-20200406
i386                 randconfig-d003-20200406
i386                 randconfig-d001-20200406
x86_64               randconfig-d002-20200406
i386                 randconfig-d002-20200406
i386                 randconfig-e001-20200406
i386                 randconfig-e003-20200406
x86_64               randconfig-e002-20200406
x86_64               randconfig-e001-20200406
i386                 randconfig-e002-20200406
x86_64               randconfig-e003-20200406
i386                 randconfig-f001-20200405
x86_64               randconfig-f003-20200405
i386                 randconfig-f003-20200405
x86_64               randconfig-f001-20200405
x86_64               randconfig-f002-20200405
i386                 randconfig-f002-20200405
x86_64               randconfig-g003-20200405
i386                 randconfig-g003-20200405
x86_64               randconfig-g002-20200405
i386                 randconfig-g001-20200405
i386                 randconfig-g002-20200405
x86_64               randconfig-g001-20200405
x86_64               randconfig-h002-20200405
i386                 randconfig-h002-20200405
i386                 randconfig-h003-20200405
i386                 randconfig-h001-20200405
x86_64               randconfig-h003-20200405
x86_64               randconfig-h001-20200405
arm64                randconfig-a001-20200406
sparc                randconfig-a001-20200406
ia64                 randconfig-a001-20200406
arc                  randconfig-a001-20200406
arm                  randconfig-a001-20200406
powerpc              randconfig-a001-20200406
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                  sh7785lcr_32bit_defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
