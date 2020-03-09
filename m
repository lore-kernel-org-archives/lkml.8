Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DC9C10F28
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 00:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35892072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 00:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCIAlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 20:41:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:56159 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgCIAlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 20:41:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2020 17:41:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,530,1574150400"; 
   d="scan'208";a="245196497"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Mar 2020 17:41:30 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jB6U5-0001tL-D8; Mon, 09 Mar 2020 08:41:29 +0800
Date:   Mon, 09 Mar 2020 08:40:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 12481c76713078054f2d043b3ce946e4814ac29f
Message-ID: <5e65908f.ZNxhz6rsff6nbZig%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 12481c76713078054f2d043b3ce946e4814ac29f  Merge branch 'core/objtool'

elapsed time: 483m

configs tested: 175
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
um                             i386_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
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
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
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
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
i386                 randconfig-a003-20200308
i386                 randconfig-a001-20200308
x86_64               randconfig-a001-20200308
x86_64               randconfig-a003-20200308
i386                 randconfig-a002-20200308
x86_64               randconfig-a002-20200308
alpha                randconfig-a001-20200308
m68k                 randconfig-a001-20200308
mips                 randconfig-a001-20200308
nds32                randconfig-a001-20200308
parisc               randconfig-a001-20200308
riscv                randconfig-a001-20200308
c6x                  randconfig-a001-20200309
h8300                randconfig-a001-20200309
microblaze           randconfig-a001-20200309
nios2                randconfig-a001-20200309
sparc64              randconfig-a001-20200309
sparc64              randconfig-a001-20200308
microblaze           randconfig-a001-20200308
c6x                  randconfig-a001-20200308
nios2                randconfig-a001-20200308
h8300                randconfig-a001-20200308
csky                 randconfig-a001-20200308
openrisc             randconfig-a001-20200308
s390                 randconfig-a001-20200308
sh                   randconfig-a001-20200308
xtensa               randconfig-a001-20200308
x86_64               randconfig-b001-20200308
x86_64               randconfig-b002-20200308
i386                 randconfig-b001-20200308
i386                 randconfig-b003-20200308
x86_64               randconfig-b003-20200308
i386                 randconfig-b002-20200308
x86_64               randconfig-c003-20200309
i386                 randconfig-c001-20200309
i386                 randconfig-c002-20200309
x86_64               randconfig-c002-20200309
i386                 randconfig-c003-20200309
x86_64               randconfig-c001-20200309
i386                 randconfig-d001-20200308
x86_64               randconfig-d003-20200308
x86_64               randconfig-d001-20200308
i386                 randconfig-d003-20200308
x86_64               randconfig-d002-20200308
i386                 randconfig-d002-20200308
x86_64               randconfig-e001-20200308
x86_64               randconfig-e002-20200308
x86_64               randconfig-e003-20200308
i386                 randconfig-e001-20200308
i386                 randconfig-e002-20200308
i386                 randconfig-e003-20200308
i386                 randconfig-f003-20200308
x86_64               randconfig-f001-20200308
i386                 randconfig-f002-20200308
i386                 randconfig-f001-20200308
x86_64               randconfig-f002-20200308
x86_64               randconfig-f003-20200308
i386                 randconfig-g001-20200308
x86_64               randconfig-g003-20200308
i386                 randconfig-g003-20200308
x86_64               randconfig-g001-20200308
x86_64               randconfig-g002-20200308
i386                 randconfig-g002-20200308
x86_64               randconfig-h001-20200308
x86_64               randconfig-h002-20200308
x86_64               randconfig-h003-20200308
i386                 randconfig-h001-20200308
i386                 randconfig-h002-20200308
i386                 randconfig-h003-20200308
i386                 randconfig-h001-20200309
x86_64               randconfig-h001-20200309
x86_64               randconfig-h002-20200309
x86_64               randconfig-h003-20200309
i386                 randconfig-h003-20200309
i386                 randconfig-h002-20200309
arc                  randconfig-a001-20200308
sparc                randconfig-a001-20200308
ia64                 randconfig-a001-20200308
arm                  randconfig-a001-20200308
arm64                randconfig-a001-20200308
powerpc              randconfig-a001-20200308
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                           x86_64_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
