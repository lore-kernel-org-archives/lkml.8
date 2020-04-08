Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA4BC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46777206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgDHGtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:49:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:57680 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgDHGtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 02:49:22 -0400
IronPort-SDR: CO4aCdYAie1DHAxzh4hQVQsNAdz4OapS//42+0VtbPvZG1WReYYPAG6mv3YPjvxK/TAJCL7naB
 /bq1vFDOAc+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 23:49:21 -0700
IronPort-SDR: VATxvfgCsugRZgYg4bUr9e8l3RUNAix22mMnZzfKmnAMoyDDeqZT1MZizA0h7mCTrWsoA0I/Po
 YWuu9XIN9y6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="251477373"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Apr 2020 23:49:20 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jM4WW-000Bg9-2g; Wed, 08 Apr 2020 14:49:20 +0800
Date:   Wed, 08 Apr 2020 14:48:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 0f538e3e712a517bd351607de50cd298102c7c08
Message-ID: <5e8d73ae.TweGidNfqJJTmsoe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/urgent
branch HEAD: 0f538e3e712a517bd351607de50cd298102c7c08  ucount: Make sure ucounts in /proc/sys/user don't regress again

elapsed time: 653m

configs tested: 186
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
mips                      fuloong2e_defconfig
c6x                        evmc6678_defconfig
ia64                                defconfig
powerpc                             defconfig
mips                      malta_kvm_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
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
mips                             allyesconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200408
x86_64               randconfig-a002-20200408
x86_64               randconfig-a003-20200408
i386                 randconfig-a001-20200408
i386                 randconfig-a002-20200408
i386                 randconfig-a003-20200408
alpha                randconfig-a001-20200408
m68k                 randconfig-a001-20200408
mips                 randconfig-a001-20200408
nds32                randconfig-a001-20200408
parisc               randconfig-a001-20200408
riscv                randconfig-a001-20200408
alpha                randconfig-a001-20200407
m68k                 randconfig-a001-20200407
nds32                randconfig-a001-20200407
parisc               randconfig-a001-20200407
riscv                randconfig-a001-20200407
c6x                  randconfig-a001-20200407
h8300                randconfig-a001-20200407
microblaze           randconfig-a001-20200407
nios2                randconfig-a001-20200407
sparc64              randconfig-a001-20200407
c6x                  randconfig-a001-20200408
h8300                randconfig-a001-20200408
microblaze           randconfig-a001-20200408
nios2                randconfig-a001-20200408
sparc64              randconfig-a001-20200408
csky                 randconfig-a001-20200408
openrisc             randconfig-a001-20200408
s390                 randconfig-a001-20200408
sh                   randconfig-a001-20200408
xtensa               randconfig-a001-20200408
csky                 randconfig-a001-20200407
openrisc             randconfig-a001-20200407
s390                 randconfig-a001-20200407
sh                   randconfig-a001-20200407
xtensa               randconfig-a001-20200407
x86_64               randconfig-c001-20200408
x86_64               randconfig-c002-20200408
x86_64               randconfig-c003-20200408
i386                 randconfig-c001-20200408
i386                 randconfig-c002-20200408
i386                 randconfig-c003-20200408
x86_64               randconfig-d001-20200407
x86_64               randconfig-d002-20200407
x86_64               randconfig-d003-20200407
i386                 randconfig-d001-20200407
i386                 randconfig-d002-20200407
i386                 randconfig-d003-20200407
x86_64               randconfig-d001-20200408
x86_64               randconfig-d002-20200408
x86_64               randconfig-d003-20200408
i386                 randconfig-d001-20200408
i386                 randconfig-d002-20200408
i386                 randconfig-d003-20200408
x86_64               randconfig-e001-20200408
x86_64               randconfig-e002-20200408
x86_64               randconfig-e003-20200408
i386                 randconfig-e001-20200408
i386                 randconfig-e002-20200408
i386                 randconfig-e003-20200408
x86_64               randconfig-f001-20200407
x86_64               randconfig-f002-20200407
x86_64               randconfig-f003-20200407
i386                 randconfig-f001-20200407
i386                 randconfig-f002-20200407
i386                 randconfig-f003-20200407
x86_64               randconfig-g001-20200407
x86_64               randconfig-g002-20200407
x86_64               randconfig-g003-20200407
i386                 randconfig-g001-20200407
i386                 randconfig-g002-20200407
i386                 randconfig-g003-20200407
x86_64               randconfig-h001-20200407
x86_64               randconfig-h002-20200407
x86_64               randconfig-h003-20200407
i386                 randconfig-h001-20200407
i386                 randconfig-h002-20200407
i386                 randconfig-h003-20200407
arc                  randconfig-a001-20200407
arm                  randconfig-a001-20200407
arm64                randconfig-a001-20200407
ia64                 randconfig-a001-20200407
powerpc              randconfig-a001-20200407
sparc                randconfig-a001-20200407
arc                  randconfig-a001-20200408
arm                  randconfig-a001-20200408
arm64                randconfig-a001-20200408
ia64                 randconfig-a001-20200408
powerpc              randconfig-a001-20200408
sparc                randconfig-a001-20200408
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
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
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
