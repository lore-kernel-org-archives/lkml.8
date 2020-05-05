Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ECEC3A5A9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 01:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51718206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 01:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgEEBdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 21:33:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:41925 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgEEBdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 21:33:31 -0400
IronPort-SDR: u6le6Gu0enShTnEvOYai8fQFgVksqLd2enS2R7v2Ds7oeGYxQmTdpcUFmSo3XxE5eEks89nynx
 RXo2tvULVc8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 18:33:30 -0700
IronPort-SDR: 4N4nPLTR3IECcgu57CCgwXl0XHonIVkNr1olGUY5nqIVxwfB6fd49GPC8ZuTptIp3Q8qD7oduk
 AYO0mtFVLeNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="461209217"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 May 2020 18:33:28 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jVmSe-000BsS-70; Tue, 05 May 2020 09:33:28 +0800
Date:   Tue, 05 May 2020 09:33:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:for-mingo] BUILD SUCCESS
 b6c10df0dbfe25b53c3ebb0d6f7dc45c364fa841
Message-ID: <5eb0c24e.F/bdZc/cLhSNqKgz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  for-mingo
branch HEAD: b6c10df0dbfe25b53c3ebb0d6f7dc45c364fa841  Merge branches 'fixes.2020.04.27a', 'kfree_rcu.2020.04.27a', 'rcu-tasks.2020.04.27a', 'stall.2020.04.27a' and 'torture.2020.04.27a' into HEAD

elapsed time: 4417m

configs tested: 245
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

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
sparc                            allyesconfig
arc                              allyesconfig
powerpc                       holly_defconfig
powerpc                      chrp32_defconfig
m68k                           sun3_defconfig
powerpc                             defconfig
ia64                                defconfig
i386                             alldefconfig
openrisc                 simple_smp_defconfig
parisc                           allyesconfig
riscv                             allnoconfig
s390                                defconfig
mips                      fuloong2e_defconfig
arc                                 defconfig
mips                            ar7_defconfig
s390                              allnoconfig
mips                              allnoconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                       capcella_defconfig
riscv                    nommu_virt_defconfig
mips                             allmodconfig
um                                  defconfig
s390                       zfcpdump_defconfig
mips                      loongson3_defconfig
ia64                          tiger_defconfig
powerpc                     ep8248e_defconfig
parisc                           allmodconfig
sparc64                             defconfig
csky                                defconfig
sh                          rsk7269_defconfig
ia64                              allnoconfig
powerpc                     mpc512x_defconfig
xtensa                          iss_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                        generic_defconfig
ia64                         bigsur_defconfig
ia64                             allyesconfig
ia64                             alldefconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
m68k                       bvme6000_defconfig
m68k                          multi_defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
xtensa                       common_defconfig
microblaze                    nommu_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                malta_kvm_guest_defconfig
mips                         tb0287_defconfig
mips                           ip32_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
mips                        bcm63xx_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
powerpc                  mpc866_ads_defconfig
powerpc                    amigaone_defconfig
powerpc                    adder875_defconfig
powerpc                          g5_defconfig
m68k                 randconfig-a001-20200502
mips                 randconfig-a001-20200502
nds32                randconfig-a001-20200502
alpha                randconfig-a001-20200502
parisc               randconfig-a001-20200502
riscv                randconfig-a001-20200502
m68k                 randconfig-a001-20200503
mips                 randconfig-a001-20200503
nds32                randconfig-a001-20200503
alpha                randconfig-a001-20200503
parisc               randconfig-a001-20200503
riscv                randconfig-a001-20200503
h8300                randconfig-a001-20200503
nios2                randconfig-a001-20200503
microblaze           randconfig-a001-20200503
c6x                  randconfig-a001-20200503
sparc64              randconfig-a001-20200503
h8300                randconfig-a001-20200502
nios2                randconfig-a001-20200502
microblaze           randconfig-a001-20200502
c6x                  randconfig-a001-20200502
sparc64              randconfig-a001-20200502
s390                 randconfig-a001-20200502
xtensa               randconfig-a001-20200502
sh                   randconfig-a001-20200502
openrisc             randconfig-a001-20200502
csky                 randconfig-a001-20200502
s390                 randconfig-a001-20200430
xtensa               randconfig-a001-20200430
csky                 randconfig-a001-20200430
openrisc             randconfig-a001-20200430
sh                   randconfig-a001-20200430
xtensa               randconfig-a001-20200503
openrisc             randconfig-a001-20200503
csky                 randconfig-a001-20200503
i386                 randconfig-b003-20200503
x86_64               randconfig-b002-20200503
i386                 randconfig-b001-20200503
x86_64               randconfig-b003-20200503
x86_64               randconfig-b001-20200503
i386                 randconfig-b002-20200503
i386                 randconfig-b003-20200501
x86_64               randconfig-b002-20200501
i386                 randconfig-b001-20200501
x86_64               randconfig-b003-20200501
x86_64               randconfig-b001-20200501
i386                 randconfig-b002-20200501
x86_64               randconfig-c002-20200502
i386                 randconfig-c002-20200502
i386                 randconfig-c001-20200502
i386                 randconfig-c003-20200502
x86_64               randconfig-c001-20200503
x86_64               randconfig-c002-20200503
i386                 randconfig-c002-20200503
x86_64               randconfig-c003-20200503
i386                 randconfig-c001-20200503
i386                 randconfig-c003-20200503
x86_64               randconfig-d001-20200503
i386                 randconfig-d003-20200503
x86_64               randconfig-d003-20200503
i386                 randconfig-d001-20200503
x86_64               randconfig-d002-20200503
i386                 randconfig-d002-20200503
x86_64               randconfig-e003-20200503
x86_64               randconfig-e002-20200503
i386                 randconfig-e003-20200503
x86_64               randconfig-e001-20200503
i386                 randconfig-e002-20200503
i386                 randconfig-e001-20200503
i386                 randconfig-f003-20200503
x86_64               randconfig-f002-20200503
i386                 randconfig-f001-20200503
i386                 randconfig-f002-20200503
x86_64               randconfig-g003-20200503
i386                 randconfig-g003-20200503
i386                 randconfig-g002-20200503
x86_64               randconfig-g001-20200503
i386                 randconfig-g001-20200503
x86_64               randconfig-g003-20200502
i386                 randconfig-g003-20200502
i386                 randconfig-g002-20200502
x86_64               randconfig-g001-20200502
x86_64               randconfig-g002-20200502
i386                 randconfig-g001-20200502
x86_64               randconfig-a003-20200502
x86_64               randconfig-a001-20200502
x86_64               randconfig-a002-20200502
i386                 randconfig-a002-20200502
i386                 randconfig-a003-20200502
i386                 randconfig-a001-20200502
i386                 randconfig-h001-20200502
i386                 randconfig-h002-20200502
i386                 randconfig-h003-20200502
x86_64               randconfig-h002-20200502
x86_64               randconfig-h001-20200502
x86_64               randconfig-h003-20200502
i386                 randconfig-h002-20200504
i386                 randconfig-h001-20200504
i386                 randconfig-h003-20200504
x86_64               randconfig-h002-20200504
x86_64               randconfig-h003-20200504
x86_64               randconfig-h001-20200504
x86_64               randconfig-a002-20200503
i386                 randconfig-a002-20200503
i386                 randconfig-a003-20200503
i386                 randconfig-a001-20200503
ia64                 randconfig-a001-20200502
arm64                randconfig-a001-20200502
arc                  randconfig-a001-20200502
powerpc              randconfig-a001-20200502
arm                  randconfig-a001-20200502
sparc                randconfig-a001-20200502
ia64                 randconfig-a001-20200501
arc                  randconfig-a001-20200501
powerpc              randconfig-a001-20200501
arm                  randconfig-a001-20200501
sparc                randconfig-a001-20200501
ia64                 randconfig-a001-20200505
arc                  randconfig-a001-20200505
powerpc              randconfig-a001-20200505
arm                  randconfig-a001-20200505
sparc                randconfig-a001-20200505
ia64                 randconfig-a001-20200503
arm64                randconfig-a001-20200503
arc                  randconfig-a001-20200503
arm                  randconfig-a001-20200503
sparc                randconfig-a001-20200503
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                             alldefconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
