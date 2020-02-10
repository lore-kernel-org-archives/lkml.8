Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EDEC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708E02085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgBJRak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:30:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:52553 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBJRak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:30:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 09:30:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="431673216"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2020 09:30:38 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j1CtK-000Euh-7t; Tue, 11 Feb 2020 01:30:38 +0800
Date:   Tue, 11 Feb 2020 01:30:07 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 2f86e45a7f427d217f4b94603a9f43a14877e2cc
Message-ID: <5e41931f.z2DJFSe/hqkcmsR8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/urgent
branch HEAD: 2f86e45a7f427d217f4b94603a9f43a14877e2cc  Merge tag 'irqchip-fixes-5.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

elapsed time: 2893m

configs tested: 206
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
csky                                defconfig
um                                  defconfig
i386                              allnoconfig
mips                      malta_kvm_defconfig
riscv                          rv32_defconfig
xtensa                       common_defconfig
m68k                             allmodconfig
sparc64                             defconfig
sh                               allmodconfig
riscv                               defconfig
arc                                 defconfig
nds32                               defconfig
m68k                           sun3_defconfig
mips                      fuloong2e_defconfig
sparc64                          allmodconfig
s390                          debug_defconfig
sparc64                           allnoconfig
um                           x86_64_defconfig
m68k                       m5475evb_defconfig
ia64                             allmodconfig
sh                          rsk7269_defconfig
i386                                defconfig
sparc                               defconfig
sparc64                          allyesconfig
s390                             allyesconfig
parisc                              defconfig
sh                                allnoconfig
s390                                defconfig
mips                              allnoconfig
ia64                                defconfig
powerpc                       ppc64_defconfig
nios2                         3c120_defconfig
sh                            titan_defconfig
mips                             allmodconfig
powerpc                           allnoconfig
riscv                            allyesconfig
parisc                           allyesconfig
microblaze                    nommu_defconfig
m68k                          multi_defconfig
parisc                            allnoconfig
c6x                              allyesconfig
arc                              allyesconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
nds32                             allnoconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
microblaze                      mmu_defconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allyesconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
i386                 randconfig-a003-20200209
i386                 randconfig-a002-20200209
x86_64               randconfig-a003-20200209
x86_64               randconfig-a002-20200209
i386                 randconfig-a001-20200209
x86_64               randconfig-a001-20200209
x86_64               randconfig-a001-20200210
x86_64               randconfig-a002-20200210
x86_64               randconfig-a003-20200210
i386                 randconfig-a001-20200210
i386                 randconfig-a002-20200210
i386                 randconfig-a003-20200210
alpha                randconfig-a001-20200209
parisc               randconfig-a001-20200209
m68k                 randconfig-a001-20200209
nds32                randconfig-a001-20200209
riscv                randconfig-a001-20200209
alpha                randconfig-a001-20200210
m68k                 randconfig-a001-20200210
mips                 randconfig-a001-20200210
nds32                randconfig-a001-20200210
parisc               randconfig-a001-20200210
riscv                randconfig-a001-20200210
c6x                  randconfig-a001-20200210
h8300                randconfig-a001-20200210
microblaze           randconfig-a001-20200210
nios2                randconfig-a001-20200210
sparc64              randconfig-a001-20200210
csky                 randconfig-a001-20200210
openrisc             randconfig-a001-20200210
s390                 randconfig-a001-20200210
sh                   randconfig-a001-20200210
xtensa               randconfig-a001-20200210
x86_64               randconfig-b001-20200210
x86_64               randconfig-b002-20200210
x86_64               randconfig-b003-20200210
i386                 randconfig-b001-20200210
i386                 randconfig-b002-20200210
i386                 randconfig-b003-20200210
x86_64               randconfig-c001-20200210
x86_64               randconfig-c002-20200210
x86_64               randconfig-c003-20200210
i386                 randconfig-c001-20200210
i386                 randconfig-c002-20200210
i386                 randconfig-c003-20200210
x86_64               randconfig-c001-20200209
x86_64               randconfig-c002-20200209
x86_64               randconfig-c003-20200209
i386                 randconfig-c001-20200209
i386                 randconfig-c002-20200209
i386                 randconfig-c003-20200209
x86_64               randconfig-d001-20200210
x86_64               randconfig-d002-20200210
x86_64               randconfig-d003-20200210
i386                 randconfig-d001-20200210
i386                 randconfig-d002-20200210
i386                 randconfig-d003-20200210
x86_64               randconfig-d003-20200209
x86_64               randconfig-d002-20200209
i386                 randconfig-d001-20200209
i386                 randconfig-d002-20200209
i386                 randconfig-d003-20200209
x86_64               randconfig-d001-20200209
x86_64               randconfig-e001-20200210
x86_64               randconfig-e002-20200210
x86_64               randconfig-e003-20200210
i386                 randconfig-e001-20200210
i386                 randconfig-e002-20200210
i386                 randconfig-e003-20200210
x86_64               randconfig-f001-20200210
x86_64               randconfig-f002-20200210
x86_64               randconfig-f003-20200210
i386                 randconfig-f001-20200210
i386                 randconfig-f002-20200210
i386                 randconfig-f003-20200210
i386                 randconfig-f002-20200209
i386                 randconfig-f003-20200209
x86_64               randconfig-f002-20200209
i386                 randconfig-f001-20200209
x86_64               randconfig-f001-20200209
x86_64               randconfig-f003-20200209
x86_64               randconfig-g001-20200210
x86_64               randconfig-g002-20200210
x86_64               randconfig-g003-20200210
i386                 randconfig-g001-20200210
i386                 randconfig-g002-20200210
i386                 randconfig-g003-20200210
x86_64               randconfig-g003-20200209
x86_64               randconfig-g001-20200209
i386                 randconfig-g001-20200209
x86_64               randconfig-g002-20200209
i386                 randconfig-g003-20200209
i386                 randconfig-g002-20200209
x86_64               randconfig-h001-20200210
x86_64               randconfig-h002-20200210
x86_64               randconfig-h003-20200210
i386                 randconfig-h001-20200210
i386                 randconfig-h002-20200210
i386                 randconfig-h003-20200210
arc                  randconfig-a001-20200209
arm                  randconfig-a001-20200209
arm64                randconfig-a001-20200209
ia64                 randconfig-a001-20200209
powerpc              randconfig-a001-20200209
sparc                randconfig-a001-20200209
arc                  randconfig-a001-20200210
arm                  randconfig-a001-20200210
arm64                randconfig-a001-20200210
ia64                 randconfig-a001-20200210
powerpc              randconfig-a001-20200210
sparc                randconfig-a001-20200210
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                       zfcpdump_defconfig
sh                  sh7785lcr_32bit_defconfig
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
