Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6627FC33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BFD217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 07:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgAWH2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 02:28:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:8844 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgAWH2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 02:28:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 23:28:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,353,1574150400"; 
   d="scan'208";a="245310572"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Jan 2020 23:28:29 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iuWuh-000GK2-6e; Thu, 23 Jan 2020 15:28:27 +0800
Date:   Thu, 23 Jan 2020 15:28:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 4144fddbd3932b59370e6e279002991c3e2b2fc6
Message-ID: <5e294b0f.r3RwR+lgfZeNeeYp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 4144fddbd3932b59370e6e279002991c3e2b2fc6  x86/tsc: Remove redundant assignment

elapsed time: 1002m

configs tested: 165
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
i386                             allyesconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
x86_64               randconfig-e001-20200123
x86_64               randconfig-e002-20200123
x86_64               randconfig-e003-20200123
i386                 randconfig-e001-20200123
i386                 randconfig-e002-20200123
i386                 randconfig-e003-20200123
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
arm                           sunxi_defconfig
ia64                              allnoconfig
x86_64               randconfig-a001-20200123
x86_64               randconfig-a002-20200123
x86_64               randconfig-a003-20200123
i386                 randconfig-a001-20200123
i386                 randconfig-a002-20200123
i386                 randconfig-a003-20200123
x86_64               randconfig-h001-20200123
x86_64               randconfig-h002-20200123
x86_64               randconfig-h003-20200123
i386                 randconfig-h001-20200123
i386                 randconfig-h002-20200123
i386                 randconfig-h003-20200123
ia64                             alldefconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
csky                 randconfig-a001-20200123
openrisc             randconfig-a001-20200123
s390                 randconfig-a001-20200123
sh                   randconfig-a001-20200123
xtensa               randconfig-a001-20200123
arc                  randconfig-a001-20200123
arm                  randconfig-a001-20200123
arm64                randconfig-a001-20200123
ia64                 randconfig-a001-20200123
powerpc              randconfig-a001-20200123
sparc                randconfig-a001-20200123
x86_64               randconfig-g001-20200123
x86_64               randconfig-g002-20200123
x86_64               randconfig-g003-20200123
i386                 randconfig-g001-20200123
i386                 randconfig-g002-20200123
i386                 randconfig-g003-20200123
alpha                randconfig-a001-20200123
m68k                 randconfig-a001-20200123
mips                 randconfig-a001-20200123
nds32                randconfig-a001-20200123
parisc               randconfig-a001-20200123
riscv                randconfig-a001-20200123
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
arm                         at91_dt_defconfig
microblaze                      mmu_defconfig
c6x                        evmc6678_defconfig
x86_64               randconfig-c001-20200123
x86_64               randconfig-c002-20200123
x86_64               randconfig-c003-20200123
i386                 randconfig-c001-20200123
i386                 randconfig-c002-20200123
i386                 randconfig-c003-20200123
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64               randconfig-d001-20200123
x86_64               randconfig-d002-20200123
x86_64               randconfig-d003-20200123
i386                 randconfig-d001-20200123
i386                 randconfig-d002-20200123
i386                 randconfig-d003-20200123
x86_64                         rhel-7.2-clear
arc                              allyesconfig
arc                                 defconfig
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
x86_64               randconfig-f001-20200123
x86_64               randconfig-f002-20200123
x86_64               randconfig-f003-20200123
i386                 randconfig-f001-20200123
i386                 randconfig-f002-20200123
i386                 randconfig-f003-20200123
arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
x86_64               randconfig-b001-20200123
x86_64               randconfig-b002-20200123
x86_64               randconfig-b003-20200123
i386                 randconfig-b001-20200123
i386                 randconfig-b002-20200123
i386                 randconfig-b003-20200123
c6x                  randconfig-a001-20200123
h8300                randconfig-a001-20200123
microblaze           randconfig-a001-20200123
nios2                randconfig-a001-20200123
sparc64              randconfig-a001-20200123

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
