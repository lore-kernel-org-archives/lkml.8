Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDA1C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AE5206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCFXFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:05:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:40847 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgCFXFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:05:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 15:05:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="414088971"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Mar 2020 15:05:39 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jAM2E-0002Ex-4z; Sat, 07 Mar 2020 07:05:38 +0800
Date:   Sat, 07 Mar 2020 07:05:23 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 73c01f50194846de50e0d926b1251daffa06abd2
Message-ID: <5e62d733.39+VSsZvpkQ4npYB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 73c01f50194846de50e0d926b1251daffa06abd2  Merge branch 'sched/core'

elapsed time: 504m

configs tested: 160
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
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
alpha                               defconfig
riscv                    nommu_virt_defconfig
ia64                                defconfig
powerpc                             defconfig
m68k                           sun3_defconfig
c6x                        evmc6678_defconfig
m68k                          multi_defconfig
s390                       zfcpdump_defconfig
h8300                     edosk2674_defconfig
ia64                              allnoconfig
s390                          debug_defconfig
um                           x86_64_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                             allyesconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
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
alpha                randconfig-a001-20200307
m68k                 randconfig-a001-20200307
mips                 randconfig-a001-20200307
nds32                randconfig-a001-20200307
parisc               randconfig-a001-20200307
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
csky                 randconfig-a001-20200306
openrisc             randconfig-a001-20200306
s390                 randconfig-a001-20200306
sh                   randconfig-a001-20200306
xtensa               randconfig-a001-20200306
x86_64               randconfig-b002-20200305
x86_64               randconfig-b001-20200305
i386                 randconfig-b001-20200305
i386                 randconfig-b003-20200305
i386                 randconfig-b002-20200305
x86_64               randconfig-b003-20200305
x86_64               randconfig-c001-20200306
x86_64               randconfig-c002-20200306
x86_64               randconfig-c003-20200306
i386                 randconfig-c001-20200306
i386                 randconfig-c002-20200306
i386                 randconfig-c003-20200306
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
x86_64               randconfig-f001-20200306
x86_64               randconfig-f002-20200306
x86_64               randconfig-f003-20200306
i386                 randconfig-f001-20200306
i386                 randconfig-f002-20200306
i386                 randconfig-f003-20200306
x86_64               randconfig-h001-20200306
x86_64               randconfig-h002-20200306
x86_64               randconfig-h003-20200306
i386                 randconfig-h001-20200306
i386                 randconfig-h002-20200306
i386                 randconfig-h003-20200306
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
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
sparc64                             defconfig
sparc64                           allnoconfig
um                                  defconfig
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
