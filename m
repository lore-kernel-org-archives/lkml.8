Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2225C47256
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 01:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7866208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 01:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgEBBWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 21:22:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:16722 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgEBBWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 21:22:43 -0400
IronPort-SDR: mXOOcpydc82n1AOgM2MoaJCEK6kUGCF/qSJKpP99WgVdv1N3ZyUgGlCrk7a1NG/Jl6LcqOqpAO
 SYZZobcCQfHw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 18:22:42 -0700
IronPort-SDR: sqxMU72u4EgHCMcpToHPRCmhnIhsHM5OG2IVX1NK7t+njwgt2oGMufNr6o/OONYxoxZD4KLPzw
 H70zqEcA2Scw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; 
   d="scan'208";a="294043103"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 May 2020 18:22:41 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jUgrY-000DgY-PM; Sat, 02 May 2020 09:22:40 +0800
Date:   Sat, 02 May 2020 09:22:22 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 c84cb3735fd53c91101ccdb191f2e3331a9262cb
Message-ID: <5eaccb4e.UI4UjkfRpMaKhIet%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: c84cb3735fd53c91101ccdb191f2e3331a9262cb  x86/apic: Move TSC deadline timer debug printk

elapsed time: 484m

configs tested: 197
configs skipped: 122

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
arc                                 defconfig
sparc64                           allnoconfig
sh                               allmodconfig
sparc64                             defconfig
riscv                             allnoconfig
c6x                              allyesconfig
i386                             alldefconfig
powerpc                             defconfig
ia64                                defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                              allnoconfig
ia64                        generic_defconfig
ia64                          tiger_defconfig
ia64                         bigsur_defconfig
ia64                             allyesconfig
ia64                             alldefconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
m68k                       bvme6000_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
xtensa                          iss_defconfig
h8300                    h8300h-sim_defconfig
xtensa                       common_defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
mips                malta_kvm_guest_defconfig
mips                         tb0287_defconfig
mips                       capcella_defconfig
mips                           ip32_defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                          ath79_defconfig
mips                        bcm63xx_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                      chrp32_defconfig
powerpc                       holly_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
powerpc                  mpc866_ads_defconfig
powerpc                    amigaone_defconfig
powerpc                    adder875_defconfig
powerpc                     ep8248e_defconfig
powerpc                          g5_defconfig
powerpc                     mpc512x_defconfig
parisc               randconfig-a001-20200430
mips                 randconfig-a001-20200430
m68k                 randconfig-a001-20200430
riscv                randconfig-a001-20200430
alpha                randconfig-a001-20200430
nds32                randconfig-a001-20200430
m68k                 randconfig-a001-20200502
mips                 randconfig-a001-20200502
nds32                randconfig-a001-20200502
alpha                randconfig-a001-20200502
parisc               randconfig-a001-20200502
riscv                randconfig-a001-20200502
microblaze           randconfig-a001-20200430
nios2                randconfig-a001-20200430
h8300                randconfig-a001-20200430
c6x                  randconfig-a001-20200430
sparc64              randconfig-a001-20200430
h8300                randconfig-a001-20200502
nios2                randconfig-a001-20200502
microblaze           randconfig-a001-20200502
c6x                  randconfig-a001-20200502
sparc64              randconfig-a001-20200502
s390                 randconfig-a001-20200430
xtensa               randconfig-a001-20200430
csky                 randconfig-a001-20200430
openrisc             randconfig-a001-20200430
sh                   randconfig-a001-20200430
s390                 randconfig-a001-20200502
xtensa               randconfig-a001-20200502
sh                   randconfig-a001-20200502
openrisc             randconfig-a001-20200502
csky                 randconfig-a001-20200502
i386                 randconfig-b003-20200501
x86_64               randconfig-b002-20200501
i386                 randconfig-b001-20200501
x86_64               randconfig-b003-20200501
x86_64               randconfig-b001-20200501
i386                 randconfig-b002-20200501
x86_64               randconfig-c001-20200430
i386                 randconfig-c001-20200430
i386                 randconfig-c002-20200430
x86_64               randconfig-c002-20200430
x86_64               randconfig-c003-20200430
i386                 randconfig-c003-20200430
i386                 randconfig-d003-20200502
i386                 randconfig-d001-20200502
x86_64               randconfig-d002-20200502
i386                 randconfig-d002-20200502
x86_64               randconfig-d002-20200430
x86_64               randconfig-d001-20200430
i386                 randconfig-d001-20200430
i386                 randconfig-d003-20200430
i386                 randconfig-d002-20200430
x86_64               randconfig-d003-20200430
x86_64               randconfig-e003-20200502
i386                 randconfig-e003-20200502
x86_64               randconfig-e001-20200502
i386                 randconfig-e002-20200502
i386                 randconfig-e001-20200502
x86_64               randconfig-e002-20200430
i386                 randconfig-e003-20200430
x86_64               randconfig-e003-20200430
i386                 randconfig-e002-20200430
x86_64               randconfig-e001-20200430
i386                 randconfig-e001-20200430
i386                 randconfig-f003-20200501
x86_64               randconfig-f001-20200501
x86_64               randconfig-f003-20200501
i386                 randconfig-f001-20200501
i386                 randconfig-f002-20200501
i386                 randconfig-h001-20200501
i386                 randconfig-h002-20200501
i386                 randconfig-h003-20200501
x86_64               randconfig-h001-20200501
x86_64               randconfig-h003-20200501
i386                 randconfig-h002-20200430
i386                 randconfig-h003-20200430
x86_64               randconfig-h001-20200430
x86_64               randconfig-h003-20200430
i386                 randconfig-h001-20200430
ia64                 randconfig-a001-20200501
arc                  randconfig-a001-20200501
powerpc              randconfig-a001-20200501
arm                  randconfig-a001-20200501
sparc                randconfig-a001-20200501
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
sh                          rsk7269_defconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
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
