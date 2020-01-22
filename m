Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7ABC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A0721835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAVGeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 01:34:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:15104 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgAVGeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 01:34:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 22:34:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,348,1574150400"; 
   d="scan'208";a="374826359"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Jan 2020 22:34:11 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iu9ad-000DxQ-5c; Wed, 22 Jan 2020 14:34:11 +0800
Date:   Wed, 22 Jan 2020 14:33:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 283bab9809786cf41798512f5c1e97f4b679ba96
Message-ID: <5e27ecc0.in7e6fnsK/BDEpUe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cpu
branch HEAD: 283bab9809786cf41798512f5c1e97f4b679ba96  x86/cpu: Remove redundant cpu_detect_cache_sizes() call

elapsed time: 2222m

configs tested: 113
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

sparc64                          allmodconfig
sparc                            allyesconfig
sparc64                          allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
ia64                                defconfig
powerpc                             defconfig
csky                 randconfig-a001-20200121
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
arm64                randconfig-a001-20200122
ia64                 randconfig-a001-20200122
arm                  randconfig-a001-20200122
arc                  randconfig-a001-20200122
sparc                randconfig-a001-20200122
i386                 randconfig-d003-20200121
i386                 randconfig-d002-20200121
x86_64               randconfig-d001-20200121
x86_64               randconfig-d003-20200121
x86_64               randconfig-d002-20200121
i386                 randconfig-d001-20200121
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
h8300                randconfig-a001-20200121
nios2                randconfig-a001-20200121
c6x                  randconfig-a001-20200121
microblaze           randconfig-a001-20200121
sparc64              randconfig-a001-20200121
s390                              allnoconfig
s390                             alldefconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
parisc                            allyesonfig
riscv                randconfig-a001-20200121
alpha                randconfig-a001-20200121
parisc               randconfig-a001-20200121
m68k                 randconfig-a001-20200121
nds32                randconfig-a001-20200121
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
mips                             allmodconfig
mips                           32r2_defconfig
mips                             allyesconfig
mips                              allnoconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
arm                              allmodconfig
arm                         at91_dt_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allmodconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
