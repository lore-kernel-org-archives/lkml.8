Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49526C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 03:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA4C246A8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 03:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgB2DVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 22:21:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:4034 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgB2DVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 22:21:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 19:21:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,498,1574150400"; 
   d="scan'208";a="285847391"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Feb 2020 19:20:59 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j7sgV-0004y3-BP; Sat, 29 Feb 2020 11:20:59 +0800
Date:   Sat, 29 Feb 2020 11:20:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:efi/core] BUILD SUCCESS
 e9765680a31b22ca6703936c000ce5cc46192e10
Message-ID: <5e59d892.ogo6gdrGGNdSLNXO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  efi/core
branch HEAD: e9765680a31b22ca6703936c000ce5cc46192e10  Merge tag 'efi-next' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/core

elapsed time: 3251m

configs tested: 337
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
h8300                     edosk2674_defconfig
arc                                 defconfig
riscv                          rv32_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
sh                  sh7785lcr_32bit_defconfig
alpha                               defconfig
nios2                         3c120_defconfig
sparc64                             defconfig
h8300                    h8300h-sim_defconfig
ia64                              allnoconfig
nds32                               defconfig
s390                       zfcpdump_defconfig
c6x                        evmc6678_defconfig
mips                             allmodconfig
ia64                             allyesconfig
parisc                generic-32bit_defconfig
powerpc                       ppc64_defconfig
openrisc                    or1ksim_defconfig
mips                      fuloong2e_defconfig
i386                             allyesconfig
sh                          rsk7269_defconfig
sparc64                          allyesconfig
ia64                                defconfig
powerpc                             defconfig
s390                              allnoconfig
sparc                               defconfig
um                                  defconfig
mips                      malta_kvm_defconfig
nds32                             allnoconfig
riscv                            allyesconfig
nios2                         10m50_defconfig
sh                            titan_defconfig
s390                          debug_defconfig
xtensa                          iss_defconfig
sparc64                           allnoconfig
m68k                           sun3_defconfig
xtensa                       common_defconfig
parisc                            allnoconfig
powerpc                           allnoconfig
i386                              allnoconfig
parisc                generic-64bit_defconfig
sh                                allnoconfig
i386                             alldefconfig
riscv                    nommu_virt_defconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
c6x                              allyesconfig
openrisc                 simple_smp_defconfig
csky                                defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                             allyesconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200228
x86_64               randconfig-a002-20200228
x86_64               randconfig-a003-20200228
i386                 randconfig-a001-20200228
i386                 randconfig-a002-20200228
i386                 randconfig-a003-20200228
x86_64               randconfig-a001-20200226
x86_64               randconfig-a002-20200226
x86_64               randconfig-a003-20200226
i386                 randconfig-a001-20200226
i386                 randconfig-a002-20200226
i386                 randconfig-a003-20200226
x86_64               randconfig-a001-20200227
x86_64               randconfig-a002-20200227
x86_64               randconfig-a003-20200227
i386                 randconfig-a001-20200227
i386                 randconfig-a002-20200227
i386                 randconfig-a003-20200227
alpha                randconfig-a001-20200227
m68k                 randconfig-a001-20200227
mips                 randconfig-a001-20200227
nds32                randconfig-a001-20200227
parisc               randconfig-a001-20200227
riscv                randconfig-a001-20200227
alpha                randconfig-a001-20200228
m68k                 randconfig-a001-20200228
mips                 randconfig-a001-20200228
nds32                randconfig-a001-20200228
parisc               randconfig-a001-20200228
riscv                randconfig-a001-20200228
alpha                randconfig-a001-20200229
m68k                 randconfig-a001-20200229
nds32                randconfig-a001-20200229
parisc               randconfig-a001-20200229
riscv                randconfig-a001-20200229
c6x                  randconfig-a001-20200227
h8300                randconfig-a001-20200227
microblaze           randconfig-a001-20200227
nios2                randconfig-a001-20200227
sparc64              randconfig-a001-20200227
c6x                  randconfig-a001-20200228
h8300                randconfig-a001-20200228
microblaze           randconfig-a001-20200228
nios2                randconfig-a001-20200228
sparc64              randconfig-a001-20200228
c6x                  randconfig-a001-20200229
h8300                randconfig-a001-20200229
microblaze           randconfig-a001-20200229
nios2                randconfig-a001-20200229
sparc64              randconfig-a001-20200229
c6x                  randconfig-a001-20200226
h8300                randconfig-a001-20200226
microblaze           randconfig-a001-20200226
nios2                randconfig-a001-20200226
sparc64              randconfig-a001-20200226
csky                 randconfig-a001-20200227
openrisc             randconfig-a001-20200227
s390                 randconfig-a001-20200227
sh                   randconfig-a001-20200227
xtensa               randconfig-a001-20200227
csky                 randconfig-a001-20200228
openrisc             randconfig-a001-20200228
s390                 randconfig-a001-20200228
sh                   randconfig-a001-20200228
xtensa               randconfig-a001-20200228
csky                 randconfig-a001-20200229
openrisc             randconfig-a001-20200229
s390                 randconfig-a001-20200229
xtensa               randconfig-a001-20200229
x86_64               randconfig-b001-20200228
x86_64               randconfig-b002-20200228
x86_64               randconfig-b003-20200228
i386                 randconfig-b001-20200228
i386                 randconfig-b002-20200228
i386                 randconfig-b003-20200228
x86_64               randconfig-b001-20200227
x86_64               randconfig-b002-20200227
x86_64               randconfig-b003-20200227
i386                 randconfig-b001-20200227
i386                 randconfig-b002-20200227
i386                 randconfig-b003-20200227
x86_64               randconfig-c001-20200227
x86_64               randconfig-c002-20200227
x86_64               randconfig-c003-20200227
i386                 randconfig-c001-20200227
i386                 randconfig-c002-20200227
i386                 randconfig-c003-20200227
x86_64               randconfig-c001-20200228
x86_64               randconfig-c002-20200228
x86_64               randconfig-c003-20200228
i386                 randconfig-c001-20200228
i386                 randconfig-c002-20200228
i386                 randconfig-c003-20200228
x86_64               randconfig-c001-20200226
x86_64               randconfig-c002-20200226
x86_64               randconfig-c003-20200226
i386                 randconfig-c001-20200226
i386                 randconfig-c002-20200226
i386                 randconfig-c003-20200226
x86_64               randconfig-c001-20200229
x86_64               randconfig-c002-20200229
x86_64               randconfig-c003-20200229
i386                 randconfig-c001-20200229
i386                 randconfig-c002-20200229
i386                 randconfig-c003-20200229
x86_64               randconfig-d001-20200227
x86_64               randconfig-d002-20200227
x86_64               randconfig-d003-20200227
i386                 randconfig-d001-20200227
i386                 randconfig-d002-20200227
i386                 randconfig-d003-20200227
x86_64               randconfig-d001-20200226
x86_64               randconfig-d002-20200226
x86_64               randconfig-d003-20200226
i386                 randconfig-d001-20200226
i386                 randconfig-d002-20200226
i386                 randconfig-d003-20200226
x86_64               randconfig-d001-20200228
x86_64               randconfig-d002-20200228
x86_64               randconfig-d003-20200228
i386                 randconfig-d001-20200228
i386                 randconfig-d002-20200228
i386                 randconfig-d003-20200228
x86_64               randconfig-d001-20200229
x86_64               randconfig-d002-20200229
x86_64               randconfig-d003-20200229
i386                 randconfig-d001-20200229
i386                 randconfig-d002-20200229
i386                 randconfig-d003-20200229
x86_64               randconfig-e001-20200228
x86_64               randconfig-e002-20200228
x86_64               randconfig-e003-20200228
i386                 randconfig-e001-20200228
i386                 randconfig-e002-20200228
i386                 randconfig-e003-20200228
x86_64               randconfig-e001-20200227
x86_64               randconfig-e002-20200227
x86_64               randconfig-e003-20200227
i386                 randconfig-e001-20200227
i386                 randconfig-e002-20200227
i386                 randconfig-e003-20200227
x86_64               randconfig-e001-20200229
x86_64               randconfig-e002-20200229
x86_64               randconfig-e003-20200229
i386                 randconfig-e001-20200229
i386                 randconfig-e002-20200229
i386                 randconfig-e003-20200229
x86_64               randconfig-e001-20200226
x86_64               randconfig-e002-20200226
x86_64               randconfig-e003-20200226
i386                 randconfig-e001-20200226
i386                 randconfig-e002-20200226
i386                 randconfig-e003-20200226
x86_64               randconfig-f001-20200227
x86_64               randconfig-f002-20200227
x86_64               randconfig-f003-20200227
i386                 randconfig-f001-20200227
i386                 randconfig-f002-20200227
i386                 randconfig-f003-20200227
x86_64               randconfig-f001-20200228
x86_64               randconfig-f002-20200228
x86_64               randconfig-f003-20200228
i386                 randconfig-f001-20200228
i386                 randconfig-f002-20200228
i386                 randconfig-f003-20200228
x86_64               randconfig-f001-20200229
x86_64               randconfig-f002-20200229
x86_64               randconfig-f003-20200229
i386                 randconfig-f001-20200229
i386                 randconfig-f002-20200229
i386                 randconfig-f003-20200229
x86_64               randconfig-f001-20200226
x86_64               randconfig-f002-20200226
x86_64               randconfig-f003-20200226
i386                 randconfig-f001-20200226
i386                 randconfig-f002-20200226
i386                 randconfig-f003-20200226
x86_64               randconfig-g001-20200228
x86_64               randconfig-g002-20200228
x86_64               randconfig-g003-20200228
i386                 randconfig-g001-20200228
i386                 randconfig-g002-20200228
i386                 randconfig-g003-20200228
x86_64               randconfig-g001-20200227
x86_64               randconfig-g002-20200227
x86_64               randconfig-g003-20200227
i386                 randconfig-g001-20200227
i386                 randconfig-g002-20200227
i386                 randconfig-g003-20200227
x86_64               randconfig-g001-20200229
x86_64               randconfig-g002-20200229
x86_64               randconfig-g003-20200229
i386                 randconfig-g001-20200229
i386                 randconfig-g002-20200229
i386                 randconfig-g003-20200229
x86_64               randconfig-g001-20200226
x86_64               randconfig-g002-20200226
x86_64               randconfig-g003-20200226
i386                 randconfig-g001-20200226
i386                 randconfig-g002-20200226
i386                 randconfig-g003-20200226
x86_64               randconfig-h001-20200228
x86_64               randconfig-h002-20200228
x86_64               randconfig-h003-20200228
i386                 randconfig-h001-20200228
i386                 randconfig-h002-20200228
i386                 randconfig-h003-20200228
x86_64               randconfig-h001-20200226
x86_64               randconfig-h002-20200226
x86_64               randconfig-h003-20200226
i386                 randconfig-h001-20200226
i386                 randconfig-h002-20200226
i386                 randconfig-h003-20200226
x86_64               randconfig-h001-20200227
x86_64               randconfig-h002-20200227
x86_64               randconfig-h003-20200227
i386                 randconfig-h001-20200227
i386                 randconfig-h002-20200227
i386                 randconfig-h003-20200227
x86_64               randconfig-h001-20200229
x86_64               randconfig-h002-20200229
x86_64               randconfig-h003-20200229
i386                 randconfig-h001-20200229
i386                 randconfig-h002-20200229
i386                 randconfig-h003-20200229
arc                  randconfig-a001-20200228
arm                  randconfig-a001-20200228
arm64                randconfig-a001-20200228
ia64                 randconfig-a001-20200228
powerpc              randconfig-a001-20200228
sparc                randconfig-a001-20200228
arc                  randconfig-a001-20200229
arm                  randconfig-a001-20200229
arm64                randconfig-a001-20200229
ia64                 randconfig-a001-20200229
powerpc              randconfig-a001-20200229
sparc                randconfig-a001-20200229
arm                  randconfig-a001-20200227
arm64                randconfig-a001-20200227
ia64                 randconfig-a001-20200227
powerpc              randconfig-a001-20200227
arc                  randconfig-a001-20200227
sparc                randconfig-a001-20200227
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                                defconfig
sh                               allmodconfig
sparc64                          allmodconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
