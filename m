Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C39CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C03F2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbgDBIzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:55:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:5803 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbgDBIza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:55:30 -0400
IronPort-SDR: YIviQi4qULzpvsonmOvOS8awHSM34mDvmUK6mD3EjLGWStHtfSsG8FxOerdWKGNA7B2enV46sK
 5IhWHykwweXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 01:55:29 -0700
IronPort-SDR: rCCruVrs6Cp1z1p2LywahX55P4QHWjXXXMBvpLoJY4QFsEBwI3un2glAwpAf2CHp6DTy3rgny+
 QfsZRMux/Lqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,335,1580803200"; 
   d="scan'208";a="252928024"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Apr 2020 01:55:27 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jJvdG-000BVK-Ny; Thu, 02 Apr 2020 16:55:26 +0800
Date:   Thu, 02 Apr 2020 16:54:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 a67cd1fb660df8d8e093cb4b75343ef3dcd17cd6
Message-ID: <5e85a85f.+Uw3XNMGmevhdtcS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/urgent
branch HEAD: a67cd1fb660df8d8e093cb4b75343ef3dcd17cd6  Merge tag 'irqchip-fixes-5.7-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 1172m

configs tested: 198
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
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
mips                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
c6x                              allyesconfig
powerpc                       ppc64_defconfig
riscv                             allnoconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
arm                              allmodconfig
arm64                            allmodconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
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
x86_64               randconfig-a001-20200401
x86_64               randconfig-a002-20200401
x86_64               randconfig-a003-20200401
i386                 randconfig-a001-20200401
i386                 randconfig-a002-20200401
i386                 randconfig-a003-20200401
mips                 randconfig-a001-20200401
nds32                randconfig-a001-20200401
m68k                 randconfig-a001-20200401
alpha                randconfig-a001-20200401
parisc               randconfig-a001-20200401
riscv                randconfig-a001-20200401
c6x                  randconfig-a001-20200401
h8300                randconfig-a001-20200401
microblaze           randconfig-a001-20200401
nios2                randconfig-a001-20200401
sparc64              randconfig-a001-20200401
c6x                  randconfig-a001-20200402
h8300                randconfig-a001-20200402
microblaze           randconfig-a001-20200402
nios2                randconfig-a001-20200402
sparc64              randconfig-a001-20200402
s390                 randconfig-a001-20200401
xtensa               randconfig-a001-20200401
csky                 randconfig-a001-20200401
openrisc             randconfig-a001-20200401
sh                   randconfig-a001-20200401
csky                 randconfig-a001-20200402
openrisc             randconfig-a001-20200402
s390                 randconfig-a001-20200402
sh                   randconfig-a001-20200402
xtensa               randconfig-a001-20200402
x86_64               randconfig-b001-20200401
x86_64               randconfig-b002-20200401
x86_64               randconfig-b003-20200401
i386                 randconfig-b001-20200401
i386                 randconfig-b002-20200401
i386                 randconfig-b003-20200401
x86_64               randconfig-c001-20200401
x86_64               randconfig-c002-20200401
x86_64               randconfig-c003-20200401
i386                 randconfig-c001-20200401
i386                 randconfig-c002-20200401
i386                 randconfig-c003-20200401
x86_64               randconfig-c001-20200402
x86_64               randconfig-c002-20200402
x86_64               randconfig-c003-20200402
i386                 randconfig-c001-20200402
i386                 randconfig-c002-20200402
i386                 randconfig-c003-20200402
x86_64               randconfig-d001-20200401
i386                 randconfig-d003-20200401
i386                 randconfig-d001-20200401
x86_64               randconfig-d002-20200401
i386                 randconfig-d002-20200401
x86_64               randconfig-d003-20200401
i386                 randconfig-e001-20200401
x86_64               randconfig-e002-20200401
i386                 randconfig-e003-20200401
x86_64               randconfig-e001-20200401
i386                 randconfig-e002-20200401
x86_64               randconfig-e003-20200401
x86_64               randconfig-f001-20200401
x86_64               randconfig-f002-20200401
x86_64               randconfig-f003-20200401
i386                 randconfig-f001-20200401
i386                 randconfig-f002-20200401
i386                 randconfig-f003-20200401
x86_64               randconfig-g001-20200402
x86_64               randconfig-g002-20200402
x86_64               randconfig-g003-20200402
i386                 randconfig-g001-20200402
i386                 randconfig-g002-20200402
i386                 randconfig-g003-20200402
x86_64               randconfig-g003-20200401
i386                 randconfig-g003-20200401
x86_64               randconfig-g002-20200401
i386                 randconfig-g001-20200401
i386                 randconfig-g002-20200401
x86_64               randconfig-g001-20200401
x86_64               randconfig-h001-20200401
x86_64               randconfig-h002-20200401
x86_64               randconfig-h003-20200401
i386                 randconfig-h001-20200401
i386                 randconfig-h002-20200401
i386                 randconfig-h003-20200401
x86_64               randconfig-h001-20200402
x86_64               randconfig-h002-20200402
x86_64               randconfig-h003-20200402
i386                 randconfig-h001-20200402
i386                 randconfig-h002-20200402
i386                 randconfig-h003-20200402
arc                  randconfig-a001-20200401
arm                  randconfig-a001-20200401
arm64                randconfig-a001-20200401
ia64                 randconfig-a001-20200401
powerpc              randconfig-a001-20200401
sparc                randconfig-a001-20200401
arc                  randconfig-a001-20200402
arm                  randconfig-a001-20200402
arm64                randconfig-a001-20200402
ia64                 randconfig-a001-20200402
powerpc              randconfig-a001-20200402
sparc                randconfig-a001-20200402
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
um                                  defconfig
um                             i386_defconfig
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
