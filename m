Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8977C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 05:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD7C206CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 05:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgDDFzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 01:55:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:50512 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgDDFzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 01:55:50 -0400
IronPort-SDR: etPNhnc6HKAJZgQtS+x5GbMXbBxmtZwKf8vlyTVjvQIVGCNBftA4p9UoPdhpxv8U3CHYIFUtnZ
 O3l6maiMSPSA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 22:55:49 -0700
IronPort-SDR: Eq4SyEw4Bmyc6LHn2YN/ti7Q2wz/+QVx8bS6bYUAmIAEezubwYF0jwTj+2YhbYyCNRdPdXZaR3
 Netmkspauh4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,342,1580803200"; 
   d="scan'208";a="285337244"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Apr 2020 22:55:48 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKbmV-00060c-E0; Sat, 04 Apr 2020 13:55:47 +0800
Date:   Sat, 04 Apr 2020 13:55:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.04.01a] BUILD REGRESSION
 ffebabde5e80e76612fd06a934cd2a147128054c
Message-ID: <5e882154.k5Wg7DONTR/ADXus%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.04.01a
branch HEAD: ffebabde5e80e76612fd06a934cd2a147128054c  rcu: Remove self-stack-trace when all quiescent states seen

Regressions in current branch:

ftrace.c:(.text+0x3ccc): undefined reference to `synchronize_rcu_tasks_rude'
kernel/trace/ftrace.c:238:2: error: implicit declaration of function 'synchronize_rcu_tasks_rude'; did you mean 'synchronize_rcu_tasks'? [-Werror=implicit-function-declaration]
kernel/trace/ftrace.c:2914:3: error: implicit declaration of function 'synchronize_rcu_tasks_rude'; did you mean 'synchronize_rcu_tasks'? [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
|-- arm-pxa_defconfig
|   `-- ftrace.c:(.text):undefined-reference-to-synchronize_rcu_tasks_rude
|-- powerpc-ppc64_defconfig
|   `-- kernel-trace-ftrace.c:error:implicit-declaration-of-function-synchronize_rcu_tasks_rude
|-- powerpc-rhel-kconfig
|   `-- kernel-trace-ftrace.c:error:implicit-declaration-of-function-synchronize_rcu_tasks_rude
|-- s390-randconfig-a001-20200403
|   `-- kernel-trace-ftrace.c:error:implicit-declaration-of-function-synchronize_rcu_tasks_rude
`-- x86_64-randconfig-d003-20200404
    `-- kernel-trace-ftrace.c:error:implicit-declaration-of-function-synchronize_rcu_tasks_rude

elapsed time: 509m

configs tested: 135
configs skipped: 0

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
riscv                    nommu_virt_defconfig
mips                             allyesconfig
riscv                            allmodconfig
ia64                                defconfig
powerpc                             defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
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
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
c6x                  randconfig-a001-20200403
h8300                randconfig-a001-20200403
microblaze           randconfig-a001-20200403
nios2                randconfig-a001-20200403
sparc64              randconfig-a001-20200403
csky                 randconfig-a001-20200403
openrisc             randconfig-a001-20200403
s390                 randconfig-a001-20200403
sh                   randconfig-a001-20200403
xtensa               randconfig-a001-20200403
csky                 randconfig-a001-20200404
openrisc             randconfig-a001-20200404
s390                 randconfig-a001-20200404
sh                   randconfig-a001-20200404
xtensa               randconfig-a001-20200404
x86_64               randconfig-d003-20200404
x86_64               randconfig-d001-20200404
i386                 randconfig-d003-20200404
i386                 randconfig-d001-20200404
x86_64               randconfig-d002-20200404
i386                 randconfig-d002-20200404
i386                 randconfig-f001-20200404
x86_64               randconfig-f003-20200404
i386                 randconfig-f003-20200404
x86_64               randconfig-f002-20200404
i386                 randconfig-f002-20200404
i386                 randconfig-g003-20200404
x86_64               randconfig-g002-20200404
i386                 randconfig-g001-20200404
i386                 randconfig-g002-20200404
x86_64               randconfig-g001-20200404
x86_64               randconfig-h002-20200404
i386                 randconfig-h002-20200404
i386                 randconfig-h003-20200404
i386                 randconfig-h001-20200404
arm64                randconfig-a001-20200403
sparc                randconfig-a001-20200403
ia64                 randconfig-a001-20200403
arc                  randconfig-a001-20200403
arm                  randconfig-a001-20200403
powerpc              randconfig-a001-20200403
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
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
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
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
