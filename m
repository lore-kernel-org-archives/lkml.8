Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00501C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C487B20674
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCFSTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:19:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:62328 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgCFSTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:19:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 10:19:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="414014702"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Mar 2020 10:19:45 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jAHZY-000Dl3-Qd; Sat, 07 Mar 2020 02:19:44 +0800
Date:   Sat, 07 Mar 2020 02:19:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 5d0c9b0eb8ab2dd540919174abe75aa3b86b802f
Message-ID: <5e629420.uSajKT1Q7vHQrRPB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  locking/core
branch HEAD: 5d0c9b0eb8ab2dd540919174abe75aa3b86b802f  asm-generic/bitops: Update stale comment

elapsed time: 483m

configs tested: 212
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
ia64                                defconfig
powerpc                             defconfig
ia64                             allmodconfig
m68k                          multi_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                           sun3_defconfig
powerpc                          rhel-kconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
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
x86_64               randconfig-a001-20200306
x86_64               randconfig-a002-20200306
x86_64               randconfig-a003-20200306
i386                 randconfig-a001-20200306
i386                 randconfig-a002-20200306
i386                 randconfig-a003-20200306
x86_64               randconfig-a001-20200305
x86_64               randconfig-a002-20200305
x86_64               randconfig-a003-20200305
i386                 randconfig-a001-20200305
i386                 randconfig-a002-20200305
i386                 randconfig-a003-20200305
alpha                randconfig-a001-20200306
m68k                 randconfig-a001-20200306
mips                 randconfig-a001-20200306
nds32                randconfig-a001-20200306
parisc               randconfig-a001-20200306
riscv                randconfig-a001-20200306
alpha                randconfig-a001-20200305
m68k                 randconfig-a001-20200305
mips                 randconfig-a001-20200305
nds32                randconfig-a001-20200305
parisc               randconfig-a001-20200305
riscv                randconfig-a001-20200305
c6x                  randconfig-a001-20200306
h8300                randconfig-a001-20200306
microblaze           randconfig-a001-20200306
nios2                randconfig-a001-20200306
sparc64              randconfig-a001-20200306
csky                 randconfig-a001-20200305
openrisc             randconfig-a001-20200305
s390                 randconfig-a001-20200305
sh                   randconfig-a001-20200305
xtensa               randconfig-a001-20200305
x86_64               randconfig-b001-20200306
x86_64               randconfig-b002-20200306
x86_64               randconfig-b003-20200306
i386                 randconfig-b001-20200306
i386                 randconfig-b002-20200306
i386                 randconfig-b003-20200306
x86_64               randconfig-c001-20200306
x86_64               randconfig-c002-20200306
x86_64               randconfig-c003-20200306
i386                 randconfig-c001-20200306
i386                 randconfig-c002-20200306
i386                 randconfig-c003-20200306
x86_64               randconfig-c001-20200305
x86_64               randconfig-c002-20200305
x86_64               randconfig-c003-20200305
i386                 randconfig-c001-20200305
i386                 randconfig-c002-20200305
i386                 randconfig-c003-20200305
x86_64               randconfig-d001-20200306
x86_64               randconfig-d002-20200306
x86_64               randconfig-d003-20200306
i386                 randconfig-d001-20200306
i386                 randconfig-d002-20200306
i386                 randconfig-d003-20200306
x86_64               randconfig-e001-20200305
x86_64               randconfig-e002-20200305
x86_64               randconfig-e003-20200305
i386                 randconfig-e001-20200305
i386                 randconfig-e002-20200305
i386                 randconfig-e003-20200305
x86_64               randconfig-e001-20200306
x86_64               randconfig-e002-20200306
x86_64               randconfig-e003-20200306
i386                 randconfig-e001-20200306
i386                 randconfig-e002-20200306
i386                 randconfig-e003-20200306
x86_64               randconfig-f001-20200305
x86_64               randconfig-f002-20200305
x86_64               randconfig-f003-20200305
i386                 randconfig-f001-20200305
i386                 randconfig-f002-20200305
i386                 randconfig-f003-20200305
x86_64               randconfig-f001-20200306
x86_64               randconfig-f002-20200306
x86_64               randconfig-f003-20200306
i386                 randconfig-f001-20200306
i386                 randconfig-f002-20200306
i386                 randconfig-f003-20200306
x86_64               randconfig-g001-20200305
x86_64               randconfig-g002-20200305
x86_64               randconfig-g003-20200305
i386                 randconfig-g001-20200305
i386                 randconfig-g002-20200305
i386                 randconfig-g003-20200305
x86_64               randconfig-g001-20200306
x86_64               randconfig-g002-20200306
x86_64               randconfig-g003-20200306
i386                 randconfig-g001-20200306
i386                 randconfig-g002-20200306
i386                 randconfig-g003-20200306
x86_64               randconfig-h001-20200305
x86_64               randconfig-h002-20200305
x86_64               randconfig-h003-20200305
i386                 randconfig-h001-20200305
i386                 randconfig-h002-20200305
i386                 randconfig-h003-20200305
x86_64               randconfig-h001-20200306
x86_64               randconfig-h002-20200306
x86_64               randconfig-h003-20200306
i386                 randconfig-h001-20200306
i386                 randconfig-h002-20200306
i386                 randconfig-h003-20200306
arc                  randconfig-a001-20200306
arm                  randconfig-a001-20200306
arm64                randconfig-a001-20200306
ia64                 randconfig-a001-20200306
powerpc              randconfig-a001-20200306
sparc                randconfig-a001-20200306
arc                  randconfig-a001-20200305
arm                  randconfig-a001-20200305
arm64                randconfig-a001-20200305
ia64                 randconfig-a001-20200305
powerpc              randconfig-a001-20200305
sparc                randconfig-a001-20200305
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
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                           x86_64_defconfig
um                             i386_defconfig
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
