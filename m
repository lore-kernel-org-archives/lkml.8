Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E75C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 19:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC2D206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 19:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgC1TV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 15:21:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:46376 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbgC1TV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 15:21:58 -0400
IronPort-SDR: u15Ft/txgzEcZp20fmsPPG3jlomvt3U7sVK3SYEruBgSCim36EzHja9tNEyz10Jpn83rrQvMBc
 rLrBIV7WYAEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 12:21:57 -0700
IronPort-SDR: XADm0rG478qX7k09MwWQqIFoTkH406br+77fpM61egxXCEJG4NaityPnSPgqg7IbEYetZQdO2A
 pBo5A7n45y7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="239394731"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2020 12:21:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jIH1n-000ABl-Hq; Sun, 29 Mar 2020 03:21:55 +0800
Date:   Sun, 29 Mar 2020 03:21:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 c90beea22a2bece4b0bbb39789bf835504421594
Message-ID: <5e7fa3b1.AWHMYZthPVO5euOH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/boot
branch HEAD: c90beea22a2bece4b0bbb39789bf835504421594  x86/boot/compressed: Fix debug_puthex() parameter type

elapsed time: 480m

configs tested: 181
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
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
m68k                             allmodconfig
sh                            titan_defconfig
s390                       zfcpdump_defconfig
mips                             allmodconfig
m68k                          multi_defconfig
nios2                         3c120_defconfig
riscv                            allmodconfig
c6x                              allyesconfig
arc                                 defconfig
sparc64                             defconfig
riscv                    nommu_virt_defconfig
s390                             alldefconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
i386                 randconfig-a002-20200327
i386                 randconfig-a001-20200327
x86_64               randconfig-a002-20200327
x86_64               randconfig-a001-20200327
i386                 randconfig-a003-20200327
x86_64               randconfig-a003-20200327
alpha                randconfig-a001-20200327
m68k                 randconfig-a001-20200327
mips                 randconfig-a001-20200327
nds32                randconfig-a001-20200327
parisc               randconfig-a001-20200327
alpha                randconfig-a001-20200329
m68k                 randconfig-a001-20200329
mips                 randconfig-a001-20200329
nds32                randconfig-a001-20200329
parisc               randconfig-a001-20200329
riscv                randconfig-a001-20200329
riscv                randconfig-a001-20200327
c6x                  randconfig-a001-20200327
h8300                randconfig-a001-20200327
microblaze           randconfig-a001-20200327
nios2                randconfig-a001-20200327
sparc64              randconfig-a001-20200327
c6x                  randconfig-a001-20200329
h8300                randconfig-a001-20200329
microblaze           randconfig-a001-20200329
nios2                randconfig-a001-20200329
sparc64              randconfig-a001-20200329
csky                 randconfig-a001-20200327
openrisc             randconfig-a001-20200327
s390                 randconfig-a001-20200327
sh                   randconfig-a001-20200327
xtensa               randconfig-a001-20200327
i386                 randconfig-b003-20200327
i386                 randconfig-b001-20200327
x86_64               randconfig-b003-20200327
i386                 randconfig-b002-20200327
x86_64               randconfig-b002-20200327
x86_64               randconfig-b001-20200327
x86_64               randconfig-c003-20200327
x86_64               randconfig-c001-20200327
i386                 randconfig-c002-20200327
x86_64               randconfig-c002-20200327
i386                 randconfig-c003-20200327
i386                 randconfig-c001-20200327
i386                 randconfig-d003-20200327
i386                 randconfig-d001-20200327
x86_64               randconfig-d002-20200327
x86_64               randconfig-d001-20200327
i386                 randconfig-d002-20200327
x86_64               randconfig-d003-20200327
x86_64               randconfig-e001-20200328
x86_64               randconfig-e002-20200328
x86_64               randconfig-e003-20200328
i386                 randconfig-e001-20200328
i386                 randconfig-e002-20200328
i386                 randconfig-e003-20200328
x86_64               randconfig-e001-20200327
x86_64               randconfig-e003-20200327
i386                 randconfig-e002-20200327
i386                 randconfig-e003-20200327
i386                 randconfig-e001-20200327
x86_64               randconfig-e002-20200327
x86_64               randconfig-f001-20200327
x86_64               randconfig-f002-20200327
x86_64               randconfig-f003-20200327
i386                 randconfig-f001-20200327
i386                 randconfig-f002-20200327
i386                 randconfig-f003-20200327
x86_64               randconfig-g001-20200327
x86_64               randconfig-g002-20200327
x86_64               randconfig-g003-20200327
i386                 randconfig-g001-20200327
i386                 randconfig-g002-20200327
i386                 randconfig-g003-20200327
x86_64               randconfig-h003-20200327
i386                 randconfig-h003-20200327
i386                 randconfig-h001-20200327
x86_64               randconfig-h001-20200327
i386                 randconfig-h002-20200327
x86_64               randconfig-h002-20200327
arm                  randconfig-a001-20200327
powerpc              randconfig-a001-20200327
ia64                 randconfig-a001-20200327
sparc                randconfig-a001-20200327
arc                  randconfig-a001-20200327
arm64                randconfig-a001-20200327
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc                               defconfig
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
