Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133C0C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78B520838
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgBIUdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 15:33:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:49296 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgBIUdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:33:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 12:33:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,422,1574150400"; 
   d="scan'208";a="405392547"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Feb 2020 12:33:18 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j0tGY-000EpS-3y; Mon, 10 Feb 2020 04:33:18 +0800
Date:   Mon, 10 Feb 2020 04:32:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 0f378d73d429d5f73fe2f00be4c9a15dbe9779ee
Message-ID: <5e406c7b.qA4fzUegpeFHRRdI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: 0f378d73d429d5f73fe2f00be4c9a15dbe9779ee  x86/apic: Mask IOAPIC entries when disabling the local APIC

elapsed time: 3098m

configs tested: 169
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

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
riscv                             allnoconfig
sh                                allnoconfig
csky                                defconfig
um                                  defconfig
i386                              allnoconfig
mips                      malta_kvm_defconfig
riscv                          rv32_defconfig
xtensa                       common_defconfig
m68k                             allmodconfig
alpha                               defconfig
s390                       zfcpdump_defconfig
parisc                           allyesconfig
m68k                       m5475evb_defconfig
mips                             allyesconfig
powerpc                             defconfig
mips                      fuloong2e_defconfig
sparc64                          allmodconfig
parisc                              defconfig
riscv                    nommu_virt_defconfig
arc                              allyesconfig
xtensa                          iss_defconfig
ia64                                defconfig
s390                                defconfig
sh                          rsk7269_defconfig
i386                                defconfig
ia64                             allmodconfig
ia64                              allnoconfig
s390                             alldefconfig
c6x                        evmc6678_defconfig
riscv                               defconfig
s390                             allmodconfig
sh                               allmodconfig
mips                             allmodconfig
sparc64                          allyesconfig
powerpc                       ppc64_defconfig
h8300                       h8s-sim_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc64                           allnoconfig
um                             i386_defconfig
mips                              allnoconfig
powerpc                           allnoconfig
sh                            titan_defconfig
parisc                            allnoconfig
c6x                              allyesconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             alldefconfig
ia64                             allyesconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
nds32                               defconfig
nds32                             allnoconfig
m68k                          multi_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
alpha                randconfig-a001-20200208
parisc               randconfig-a001-20200208
m68k                 randconfig-a001-20200208
nds32                randconfig-a001-20200208
mips                 randconfig-a001-20200208
riscv                randconfig-a001-20200208
c6x                  randconfig-a001-20200209
h8300                randconfig-a001-20200209
microblaze           randconfig-a001-20200209
nios2                randconfig-a001-20200209
sparc64              randconfig-a001-20200209
h8300                randconfig-a001-20200208
nios2                randconfig-a001-20200208
microblaze           randconfig-a001-20200208
sparc64              randconfig-a001-20200208
c6x                  randconfig-a001-20200208
s390                 randconfig-a001-20200208
csky                 randconfig-a001-20200208
sh                   randconfig-a001-20200208
xtensa               randconfig-a001-20200208
openrisc             randconfig-a001-20200208
x86_64               randconfig-b001-20200210
x86_64               randconfig-b002-20200210
x86_64               randconfig-b003-20200210
i386                 randconfig-b001-20200210
i386                 randconfig-b002-20200210
i386                 randconfig-b003-20200210
x86_64               randconfig-c001-20200207
x86_64               randconfig-c002-20200207
x86_64               randconfig-c003-20200207
i386                 randconfig-c001-20200207
i386                 randconfig-c002-20200207
i386                 randconfig-c003-20200207
x86_64               randconfig-c001-20200209
x86_64               randconfig-c002-20200209
x86_64               randconfig-c003-20200209
i386                 randconfig-c001-20200209
i386                 randconfig-c002-20200209
i386                 randconfig-c003-20200209
x86_64               randconfig-c001-20200208
x86_64               randconfig-c002-20200208
x86_64               randconfig-c003-20200208
i386                 randconfig-c001-20200208
i386                 randconfig-c002-20200208
i386                 randconfig-c003-20200208
x86_64               randconfig-d001-20200207
x86_64               randconfig-d002-20200207
x86_64               randconfig-d003-20200207
i386                 randconfig-d001-20200207
i386                 randconfig-d002-20200207
i386                 randconfig-d003-20200207
x86_64               randconfig-f001-20200210
x86_64               randconfig-f002-20200210
x86_64               randconfig-f003-20200210
i386                 randconfig-f001-20200210
i386                 randconfig-f002-20200210
i386                 randconfig-f003-20200210
x86_64               randconfig-g001-20200210
x86_64               randconfig-g002-20200210
x86_64               randconfig-g003-20200210
i386                 randconfig-g001-20200210
i386                 randconfig-g002-20200210
i386                 randconfig-g003-20200210
x86_64               randconfig-g001-20200207
x86_64               randconfig-g002-20200207
x86_64               randconfig-g003-20200207
i386                 randconfig-g001-20200207
i386                 randconfig-g002-20200207
i386                 randconfig-g003-20200207
arc                  randconfig-a001-20200208
ia64                 randconfig-a001-20200208
sparc                randconfig-a001-20200208
arm64                randconfig-a001-20200208
arm                  randconfig-a001-20200208
riscv                            allmodconfig
riscv                            allyesconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
sparc                               defconfig
sparc64                             defconfig
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
