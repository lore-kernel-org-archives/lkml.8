Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC73C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA63A2072A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389530AbgDMWVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:21:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:7747 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389509AbgDMWVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 18:21:37 -0400
IronPort-SDR: xnXzc3dPyLmJisWYe8uMs4+T3yFqowfR488WAsw23BTGq20fBL/fleDipAkcfVAUEIY+f8qXG1
 u54ZMgECkxCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 15:21:35 -0700
IronPort-SDR: 4lE/s8euzScsVUomnFU78UfOqi3RN+6geeksqZSr2L7nOhsdEN2FKE6EJD9BcCyEjpAu2t+uUo
 cqBjOFaRr9lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="scan'208";a="298529923"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2020 15:21:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jO7SP-0003aT-O2; Tue, 14 Apr 2020 06:21:33 +0800
Date:   Tue, 14 Apr 2020 06:21:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 0ddfac80e054f2ed076ff6049c1ecbb257493ffd
Message-ID: <5e94e5e6.DngzWKq6kV2fSZ7q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 0ddfac80e054f2ed076ff6049c1ecbb257493ffd  Merge branch 'x86/urgent'

elapsed time: 483m

configs tested: 157
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
arc                                 defconfig
m68k                       m5475evb_defconfig
microblaze                      mmu_defconfig
mips                             allmodconfig
riscv                             allnoconfig
ia64                                defconfig
powerpc                             defconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
i386                             allyesconfig
sh                               allmodconfig
i386                              allnoconfig
i386                             alldefconfig
i386                              debian-10.3
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
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
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
i386                 randconfig-a002-20200413
x86_64               randconfig-a002-20200413
i386                 randconfig-a003-20200413
i386                 randconfig-a001-20200413
mips                 randconfig-a001-20200413
nds32                randconfig-a001-20200413
h8300                randconfig-a001-20200413
nios2                randconfig-a001-20200413
c6x                  randconfig-a001-20200413
microblaze           randconfig-a001-20200413
sparc64              randconfig-a001-20200413
s390                 randconfig-a001-20200413
xtensa               randconfig-a001-20200413
sh                   randconfig-a001-20200413
openrisc             randconfig-a001-20200413
csky                 randconfig-a001-20200413
x86_64               randconfig-b001-20200413
x86_64               randconfig-b002-20200413
x86_64               randconfig-b003-20200413
i386                 randconfig-b001-20200413
i386                 randconfig-b002-20200413
i386                 randconfig-b003-20200413
x86_64               randconfig-c001-20200413
x86_64               randconfig-c002-20200413
x86_64               randconfig-c003-20200413
i386                 randconfig-c001-20200413
i386                 randconfig-c002-20200413
i386                 randconfig-c003-20200413
i386                 randconfig-d002-20200413
x86_64               randconfig-d003-20200413
x86_64               randconfig-d001-20200413
i386                 randconfig-d003-20200413
i386                 randconfig-d001-20200413
x86_64               randconfig-d002-20200413
x86_64               randconfig-e001-20200413
i386                 randconfig-e002-20200413
i386                 randconfig-e001-20200413
x86_64               randconfig-e002-20200413
i386                 randconfig-e003-20200413
x86_64               randconfig-e003-20200413
i386                 randconfig-f003-20200413
i386                 randconfig-f002-20200413
x86_64               randconfig-f003-20200413
x86_64               randconfig-f001-20200413
x86_64               randconfig-f002-20200413
i386                 randconfig-f001-20200413
x86_64               randconfig-g003-20200413
i386                 randconfig-g003-20200413
x86_64               randconfig-g001-20200413
x86_64               randconfig-g002-20200413
i386                 randconfig-g002-20200413
i386                 randconfig-g001-20200413
x86_64               randconfig-h001-20200413
i386                 randconfig-h003-20200413
i386                 randconfig-h002-20200413
i386                 randconfig-h001-20200413
x86_64               randconfig-h002-20200413
ia64                 randconfig-a001-20200413
arc                  randconfig-a001-20200413
arm                  randconfig-a001-20200413
sparc                randconfig-a001-20200413
riscv                            allmodconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
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
x86_64                    rhel-7.6-kselftests

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
