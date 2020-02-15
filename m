Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161C0C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 15:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E303F2082F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 15:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgBOPjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 10:39:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:28387 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgBOPjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 10:39:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2020 07:39:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,445,1574150400"; 
   d="scan'208";a="257827527"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 Feb 2020 07:39:04 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j2zX5-0001Yl-D2; Sat, 15 Feb 2020 23:39:03 +0800
Date:   Sat, 15 Feb 2020 23:38:57 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.02.13a] BUILD SUCCESS
 87a0ed1afbe3b17f057dd2f096deba6a524aa94f
Message-ID: <5e481091.0BTd0C8H0y9Xb2Cs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.02.13a
branch HEAD: 87a0ed1afbe3b17f057dd2f096deba6a524aa94f  cpu/hotplug, stop_machine: Fix stop_machine vs hotplug order

elapsed time: 2937m

configs tested: 190
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
riscv                               defconfig
xtensa                          iss_defconfig
alpha                               defconfig
arc                                 defconfig
m68k                             allmodconfig
nds32                             allnoconfig
openrisc                    or1ksim_defconfig
s390                                defconfig
ia64                                defconfig
riscv                    nommu_virt_defconfig
csky                                defconfig
m68k                           sun3_defconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              allnoconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
nds32                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
powerpc                             defconfig
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
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
i386                 randconfig-a003-20200213
x86_64               randconfig-a003-20200213
i386                 randconfig-a001-20200213
x86_64               randconfig-a002-20200213
i386                 randconfig-a002-20200213
x86_64               randconfig-a001-20200213
x86_64               randconfig-a001-20200215
x86_64               randconfig-a002-20200215
x86_64               randconfig-a003-20200215
i386                 randconfig-a001-20200215
i386                 randconfig-a002-20200215
i386                 randconfig-a003-20200215
parisc               randconfig-a001-20200213
riscv                randconfig-a001-20200213
mips                 randconfig-a001-20200213
m68k                 randconfig-a001-20200213
nds32                randconfig-a001-20200213
alpha                randconfig-a001-20200213
c6x                  randconfig-a001-20200215
h8300                randconfig-a001-20200215
microblaze           randconfig-a001-20200215
nios2                randconfig-a001-20200215
sparc64              randconfig-a001-20200215
c6x                  randconfig-a001-20200213
sparc64              randconfig-a001-20200213
h8300                randconfig-a001-20200213
nios2                randconfig-a001-20200213
openrisc             randconfig-a001-20200213
sh                   randconfig-a001-20200213
csky                 randconfig-a001-20200213
s390                 randconfig-a001-20200213
xtensa               randconfig-a001-20200213
csky                 randconfig-a001-20200214
openrisc             randconfig-a001-20200214
s390                 randconfig-a001-20200214
xtensa               randconfig-a001-20200214
x86_64               randconfig-b002-20200213
i386                 randconfig-b002-20200213
x86_64               randconfig-b001-20200213
i386                 randconfig-b001-20200213
i386                 randconfig-b003-20200213
x86_64               randconfig-b003-20200213
x86_64               randconfig-c001-20200214
x86_64               randconfig-c002-20200214
x86_64               randconfig-c003-20200214
i386                 randconfig-c001-20200214
i386                 randconfig-c002-20200214
i386                 randconfig-c003-20200214
x86_64               randconfig-d003-20200213
x86_64               randconfig-d001-20200213
i386                 randconfig-d003-20200213
x86_64               randconfig-d002-20200213
i386                 randconfig-d001-20200213
i386                 randconfig-d002-20200213
i386                 randconfig-e001-20200213
i386                 randconfig-e003-20200213
x86_64               randconfig-e001-20200213
x86_64               randconfig-e002-20200213
i386                 randconfig-e002-20200213
x86_64               randconfig-e003-20200213
i386                 randconfig-f002-20200213
i386                 randconfig-f003-20200213
i386                 randconfig-f001-20200213
x86_64               randconfig-f002-20200213
x86_64               randconfig-f001-20200213
x86_64               randconfig-f003-20200213
x86_64               randconfig-g001-20200214
x86_64               randconfig-g002-20200214
x86_64               randconfig-g003-20200214
i386                 randconfig-g001-20200214
i386                 randconfig-g002-20200214
i386                 randconfig-g003-20200214
i386                 randconfig-g001-20200213
i386                 randconfig-g002-20200213
x86_64               randconfig-g003-20200213
x86_64               randconfig-g001-20200213
i386                 randconfig-g003-20200213
x86_64               randconfig-g002-20200213
x86_64               randconfig-h001-20200214
x86_64               randconfig-h002-20200214
x86_64               randconfig-h003-20200214
i386                 randconfig-h001-20200214
i386                 randconfig-h002-20200214
i386                 randconfig-h003-20200214
i386                 randconfig-h002-20200213
x86_64               randconfig-h002-20200213
i386                 randconfig-h001-20200213
x86_64               randconfig-h001-20200213
i386                 randconfig-h003-20200213
x86_64               randconfig-h003-20200213
arc                  randconfig-a001-20200213
sparc                randconfig-a001-20200213
ia64                 randconfig-a001-20200213
arm                  randconfig-a001-20200213
powerpc              randconfig-a001-20200213
arm64                randconfig-a001-20200213
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
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
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
