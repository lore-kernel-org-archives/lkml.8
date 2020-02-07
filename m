Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166DBC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C297B20726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBGTEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 14:04:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:27164 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgBGTEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 14:04:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 11:04:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,414,1574150400"; 
   d="scan'208";a="432655072"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Feb 2020 11:04:41 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j08vh-000ImA-Ab; Sat, 08 Feb 2020 03:04:41 +0800
Date:   Sat, 08 Feb 2020 03:03:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.01.31a] BUILD SUCCESS
 19cae4b11accf692fb67d6ba92833ca45dd63197
Message-ID: <5e3db48e.mIX1DQNv9X0phtbG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.01.31a
branch HEAD: 19cae4b11accf692fb67d6ba92833ca45dd63197  kcsan: Fix 0-sized checks

elapsed time: 2883m

configs tested: 233
configs skipped: 1

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
powerpc                           allnoconfig
csky                                defconfig
nios2                         10m50_defconfig
ia64                             allmodconfig
h8300                       h8s-sim_defconfig
c6x                        evmc6678_defconfig
nds32                               defconfig
sparc64                           allnoconfig
mips                      fuloong2e_defconfig
parisc                         b180_defconfig
openrisc                 simple_smp_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
ia64                             alldefconfig
c6x                              allyesconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
nds32                             allnoconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64               randconfig-a001-20200206
x86_64               randconfig-a002-20200206
x86_64               randconfig-a003-20200206
i386                 randconfig-a001-20200206
i386                 randconfig-a002-20200206
i386                 randconfig-a003-20200206
x86_64               randconfig-a001-20200207
x86_64               randconfig-a002-20200207
x86_64               randconfig-a003-20200207
i386                 randconfig-a001-20200207
i386                 randconfig-a002-20200207
i386                 randconfig-a003-20200207
alpha                randconfig-a001-20200206
parisc               randconfig-a001-20200206
m68k                 randconfig-a001-20200206
nds32                randconfig-a001-20200206
mips                 randconfig-a001-20200206
riscv                randconfig-a001-20200206
alpha                randconfig-a001-20200207
m68k                 randconfig-a001-20200207
mips                 randconfig-a001-20200207
nds32                randconfig-a001-20200207
parisc               randconfig-a001-20200207
h8300                randconfig-a001-20200206
nios2                randconfig-a001-20200206
sparc64              randconfig-a001-20200206
c6x                  randconfig-a001-20200206
microblaze           randconfig-a001-20200206
c6x                  randconfig-a001-20200207
h8300                randconfig-a001-20200207
microblaze           randconfig-a001-20200207
nios2                randconfig-a001-20200207
sparc64              randconfig-a001-20200207
sh                   randconfig-a001-20200205
csky                 randconfig-a001-20200205
s390                 randconfig-a001-20200205
xtensa               randconfig-a001-20200205
openrisc             randconfig-a001-20200205
csky                 randconfig-a001-20200207
openrisc             randconfig-a001-20200207
s390                 randconfig-a001-20200207
xtensa               randconfig-a001-20200207
x86_64               randconfig-b001-20200206
x86_64               randconfig-b002-20200206
x86_64               randconfig-b003-20200206
i386                 randconfig-b001-20200206
i386                 randconfig-b002-20200206
i386                 randconfig-b003-20200206
x86_64               randconfig-c001-20200204
x86_64               randconfig-c002-20200204
x86_64               randconfig-c003-20200204
i386                 randconfig-c001-20200204
i386                 randconfig-c002-20200204
i386                 randconfig-c003-20200204
x86_64               randconfig-c003-20200206
x86_64               randconfig-c002-20200206
i386                 randconfig-c002-20200206
i386                 randconfig-c001-20200206
x86_64               randconfig-c001-20200206
i386                 randconfig-c003-20200206
x86_64               randconfig-c001-20200207
x86_64               randconfig-c002-20200207
x86_64               randconfig-c003-20200207
i386                 randconfig-c001-20200207
i386                 randconfig-c002-20200207
i386                 randconfig-c003-20200207
x86_64               randconfig-d001-20200207
x86_64               randconfig-d002-20200207
x86_64               randconfig-d003-20200207
i386                 randconfig-d001-20200207
i386                 randconfig-d002-20200207
i386                 randconfig-d003-20200207
x86_64               randconfig-d003-20200206
i386                 randconfig-d001-20200206
x86_64               randconfig-d002-20200206
x86_64               randconfig-d001-20200206
i386                 randconfig-d003-20200206
i386                 randconfig-d002-20200206
x86_64               randconfig-e001-20200207
x86_64               randconfig-e002-20200207
x86_64               randconfig-e003-20200207
i386                 randconfig-e001-20200207
i386                 randconfig-e002-20200207
i386                 randconfig-e003-20200207
i386                 randconfig-e003-20200206
i386                 randconfig-e002-20200206
x86_64               randconfig-e001-20200206
x86_64               randconfig-e003-20200206
i386                 randconfig-e001-20200206
x86_64               randconfig-e002-20200206
x86_64               randconfig-f001-20200204
x86_64               randconfig-f002-20200204
x86_64               randconfig-f003-20200204
i386                 randconfig-f001-20200204
i386                 randconfig-f002-20200204
i386                 randconfig-f003-20200204
x86_64               randconfig-g003-20200205
i386                 randconfig-g001-20200205
x86_64               randconfig-g001-20200205
x86_64               randconfig-g002-20200205
i386                 randconfig-g002-20200205
i386                 randconfig-g003-20200205
x86_64               randconfig-g001-20200206
x86_64               randconfig-g002-20200206
x86_64               randconfig-g003-20200206
i386                 randconfig-g001-20200206
i386                 randconfig-g002-20200206
i386                 randconfig-g003-20200206
x86_64               randconfig-g001-20200207
x86_64               randconfig-g002-20200207
x86_64               randconfig-g003-20200207
i386                 randconfig-g001-20200207
i386                 randconfig-g002-20200207
i386                 randconfig-g003-20200207
x86_64               randconfig-h001-20200206
x86_64               randconfig-h002-20200206
x86_64               randconfig-h003-20200206
i386                 randconfig-h001-20200206
i386                 randconfig-h002-20200206
i386                 randconfig-h003-20200206
x86_64               randconfig-h001-20200205
x86_64               randconfig-h002-20200205
x86_64               randconfig-h003-20200205
i386                 randconfig-h001-20200205
i386                 randconfig-h002-20200205
i386                 randconfig-h003-20200205
x86_64               randconfig-h001-20200207
x86_64               randconfig-h002-20200207
x86_64               randconfig-h003-20200207
i386                 randconfig-h001-20200207
i386                 randconfig-h002-20200207
i386                 randconfig-h003-20200207
powerpc              randconfig-a001-20200206
arc                  randconfig-a001-20200206
ia64                 randconfig-a001-20200206
sparc                randconfig-a001-20200206
arm64                randconfig-a001-20200206
arm                  randconfig-a001-20200206
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
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
