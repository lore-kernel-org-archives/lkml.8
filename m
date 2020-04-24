Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDC5C5518A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B508320715
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDXDaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 23:30:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:15544 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgDXDaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:30:19 -0400
IronPort-SDR: SDeeWN2GvvphPd7B0KA8SVjt2Yic1PyiIEIZyUXBasFDWakXlLEw9m5ObEz2pTsXzzhLqORQQo
 lsTxyIO6qrxg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 20:30:13 -0700
IronPort-SDR: aCSb/HO//PGxfcJztD1xWfxLEoO23AdFTFSkLq2cIXwVwCmifIPgHOxyEg60yso/XfjVdTrCeG
 RXEpKy6SrV1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,310,1583222400"; 
   d="scan'208";a="245103893"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Apr 2020 20:30:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jRp2Z-00026O-8S; Fri, 24 Apr 2020 11:30:11 +0800
Date:   Fri, 24 Apr 2020 11:29:31 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/urgent] BUILD SUCCESS
 40e7d7bdc19e65a356ca6d692c6e56ec45012737
Message-ID: <5ea25d1b.QOuOclqPlrNJgbpV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  core/urgent
branch HEAD: 40e7d7bdc19e65a356ca6d692c6e56ec45012737  Merge branch 'urgent-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/urgent

elapsed time: 14110m

configs tested: 309
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
nds32                               defconfig
sh                                allnoconfig
xtensa                       common_defconfig
um                                  defconfig
microblaze                    nommu_defconfig
mips                malta_kvm_guest_defconfig
arc                              allyesconfig
alpha                               defconfig
mips                          ath79_defconfig
sparc64                           allnoconfig
s390                             allmodconfig
i386                                defconfig
riscv                             allnoconfig
riscv                               defconfig
um                             i386_defconfig
s390                          debug_defconfig
h8300                    h8300h-sim_defconfig
powerpc                             defconfig
ia64                                defconfig
m68k                       m5475evb_defconfig
ia64                         bigsur_defconfig
ia64                             allyesconfig
mips                      malta_kvm_defconfig
ia64                              allnoconfig
nios2                         10m50_defconfig
ia64                        generic_defconfig
mips                         tb0287_defconfig
powerpc                       ppc64_defconfig
mips                            ar7_defconfig
riscv                          rv32_defconfig
sh                  sh7785lcr_32bit_defconfig
parisc                generic-64bit_defconfig
microblaze                      mmu_defconfig
sh                          rsk7269_defconfig
mips                              allnoconfig
s390                             allyesconfig
powerpc                           allnoconfig
s390                             alldefconfig
sparc                               defconfig
h8300                     edosk2674_defconfig
sparc64                          allyesconfig
s390                              allnoconfig
parisc                generic-32bit_defconfig
parisc                           allmodconfig
mips                  decstation_64_defconfig
mips                      fuloong2e_defconfig
xtensa                          iss_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                              debian-10.3
ia64                             alldefconfig
ia64                             allmodconfig
ia64                          tiger_defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
nds32                             allnoconfig
csky                                defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
powerpc                          rhel-kconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                             allmodconfig
mips                       capcella_defconfig
mips                           ip32_defconfig
mips                      loongson3_defconfig
mips                        bcm63xx_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc               randconfig-a001-20200421
alpha                randconfig-a001-20200421
mips                 randconfig-a001-20200421
m68k                 randconfig-a001-20200421
riscv                randconfig-a001-20200421
nds32                randconfig-a001-20200421
parisc               randconfig-a001-20200422
mips                 randconfig-a001-20200422
alpha                randconfig-a001-20200422
m68k                 randconfig-a001-20200422
riscv                randconfig-a001-20200422
nds32                randconfig-a001-20200422
nios2                randconfig-a001-20200421
h8300                randconfig-a001-20200421
c6x                  randconfig-a001-20200421
sparc64              randconfig-a001-20200421
microblaze           randconfig-a001-20200421
sh                   randconfig-a001-20200421
csky                 randconfig-a001-20200421
s390                 randconfig-a001-20200421
xtensa               randconfig-a001-20200421
openrisc             randconfig-a001-20200421
i386                 randconfig-a002-20200415
x86_64               randconfig-a001-20200415
x86_64               randconfig-a002-20200415
i386                 randconfig-a003-20200415
i386                 randconfig-a001-20200415
x86_64               randconfig-a003-20200415
i386                 randconfig-a002-20200416
x86_64               randconfig-a001-20200416
x86_64               randconfig-a002-20200416
i386                 randconfig-a003-20200416
i386                 randconfig-a001-20200416
x86_64               randconfig-a003-20200416
i386                 randconfig-b002-20200421
i386                 randconfig-b001-20200421
x86_64               randconfig-b001-20200421
i386                 randconfig-b003-20200421
x86_64               randconfig-b002-20200421
x86_64               randconfig-b003-20200421
i386                 randconfig-b002-20200422
i386                 randconfig-b001-20200422
x86_64               randconfig-b001-20200422
i386                 randconfig-b003-20200422
x86_64               randconfig-b003-20200422
x86_64               randconfig-a001-20200414
x86_64               randconfig-a002-20200414
x86_64               randconfig-a003-20200414
i386                 randconfig-a001-20200414
i386                 randconfig-a002-20200414
i386                 randconfig-a003-20200414
i386                 randconfig-c002-20200421
i386                 randconfig-c001-20200421
x86_64               randconfig-c002-20200421
x86_64               randconfig-c001-20200421
i386                 randconfig-c003-20200421
x86_64               randconfig-c003-20200421
x86_64               randconfig-d001-20200421
x86_64               randconfig-d002-20200421
i386                 randconfig-d002-20200421
i386                 randconfig-d001-20200421
x86_64               randconfig-d003-20200421
i386                 randconfig-d003-20200421
x86_64               randconfig-e002-20200421
i386                 randconfig-e003-20200421
x86_64               randconfig-e003-20200421
i386                 randconfig-e002-20200421
i386                 randconfig-e001-20200421
x86_64               randconfig-e001-20200421
i386                 randconfig-f002-20200421
i386                 randconfig-f003-20200421
x86_64               randconfig-f003-20200421
i386                 randconfig-f001-20200421
x86_64               randconfig-f001-20200421
i386                 randconfig-g003-20200422
x86_64               randconfig-g001-20200422
i386                 randconfig-g001-20200422
x86_64               randconfig-g002-20200422
i386                 randconfig-g002-20200422
x86_64               randconfig-g003-20200422
i386                 randconfig-g003-20200423
x86_64               randconfig-g001-20200423
i386                 randconfig-g001-20200423
i386                 randconfig-g002-20200423
x86_64               randconfig-g003-20200423
i386                 randconfig-h003-20200421
x86_64               randconfig-h001-20200421
x86_64               randconfig-h003-20200421
i386                 randconfig-h002-20200421
i386                 randconfig-h001-20200421
sparc                randconfig-a001-20200421
ia64                 randconfig-a001-20200421
powerpc              randconfig-a001-20200421
arm                  randconfig-a001-20200421
arc                  randconfig-a001-20200421
alpha                randconfig-a001-20200414
m68k                 randconfig-a001-20200414
nds32                randconfig-a001-20200414
parisc               randconfig-a001-20200414
riscv                randconfig-a001-20200414
alpha                randconfig-a001-20200415
m68k                 randconfig-a001-20200415
mips                 randconfig-a001-20200415
nds32                randconfig-a001-20200415
parisc               randconfig-a001-20200415
riscv                randconfig-a001-20200415
c6x                  randconfig-a001-20200414
h8300                randconfig-a001-20200414
microblaze           randconfig-a001-20200414
nios2                randconfig-a001-20200414
sparc64              randconfig-a001-20200414
c6x                  randconfig-a001-20200415
h8300                randconfig-a001-20200415
microblaze           randconfig-a001-20200415
nios2                randconfig-a001-20200415
sparc64              randconfig-a001-20200415
csky                 randconfig-a001-20200414
openrisc             randconfig-a001-20200414
s390                 randconfig-a001-20200414
sh                   randconfig-a001-20200414
xtensa               randconfig-a001-20200414
s390                 randconfig-a001-20200415
xtensa               randconfig-a001-20200415
sh                   randconfig-a001-20200415
openrisc             randconfig-a001-20200415
csky                 randconfig-a001-20200415
x86_64               randconfig-b003-20200415
i386                 randconfig-b001-20200415
i386                 randconfig-b003-20200415
x86_64               randconfig-b001-20200414
x86_64               randconfig-b002-20200414
x86_64               randconfig-b003-20200414
i386                 randconfig-b001-20200414
i386                 randconfig-b002-20200414
i386                 randconfig-b003-20200414
x86_64               randconfig-b002-20200415
x86_64               randconfig-b001-20200415
i386                 randconfig-b002-20200415
x86_64               randconfig-c001-20200414
x86_64               randconfig-c002-20200414
x86_64               randconfig-c003-20200414
i386                 randconfig-c001-20200414
i386                 randconfig-c002-20200414
i386                 randconfig-c003-20200414
i386                 randconfig-d002-20200415
x86_64               randconfig-d003-20200415
i386                 randconfig-d003-20200415
x86_64               randconfig-d001-20200415
i386                 randconfig-d001-20200415
x86_64               randconfig-d002-20200415
x86_64               randconfig-d001-20200414
x86_64               randconfig-d002-20200414
x86_64               randconfig-d003-20200414
i386                 randconfig-d001-20200414
i386                 randconfig-d002-20200414
i386                 randconfig-d003-20200414
x86_64               randconfig-e001-20200415
x86_64               randconfig-e002-20200415
x86_64               randconfig-e003-20200415
i386                 randconfig-e001-20200415
i386                 randconfig-e002-20200415
i386                 randconfig-e003-20200415
i386                 randconfig-f003-20200415
i386                 randconfig-f002-20200415
i386                 randconfig-f001-20200415
x86_64               randconfig-f001-20200414
x86_64               randconfig-f002-20200414
x86_64               randconfig-f003-20200414
i386                 randconfig-f001-20200414
i386                 randconfig-f002-20200414
i386                 randconfig-f003-20200414
x86_64               randconfig-g001-20200414
x86_64               randconfig-g002-20200414
x86_64               randconfig-g003-20200414
i386                 randconfig-g001-20200414
i386                 randconfig-g002-20200414
i386                 randconfig-g003-20200414
x86_64               randconfig-h001-20200414
x86_64               randconfig-h002-20200414
x86_64               randconfig-h003-20200414
i386                 randconfig-h001-20200414
i386                 randconfig-h002-20200414
i386                 randconfig-h003-20200414
x86_64               randconfig-h001-20200415
i386                 randconfig-h003-20200415
i386                 randconfig-h002-20200415
i386                 randconfig-h001-20200415
x86_64               randconfig-h002-20200415
arc                  randconfig-a001-20200414
arm                  randconfig-a001-20200414
arm64                randconfig-a001-20200414
ia64                 randconfig-a001-20200414
powerpc              randconfig-a001-20200414
sparc                randconfig-a001-20200414
powerpc              randconfig-a001-20200415
arm64                randconfig-a001-20200415
ia64                 randconfig-a001-20200415
arc                  randconfig-a001-20200415
arm                  randconfig-a001-20200415
sparc                randconfig-a001-20200415
riscv                            allmodconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                             defconfig
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
