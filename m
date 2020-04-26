Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1332C55186
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921CC20714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgDZBZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 21:25:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:29048 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgDZBZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 21:25:51 -0400
IronPort-SDR: QizMa1aGb2ORdpkAiztN3+EEpp6Bohga/EemZ/qdOoCrj7NPOlrWxtQQ6YbPEy/ybySR4pMLdu
 52AE8K6Kf4pg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2020 18:25:47 -0700
IronPort-SDR: aoFVCpb2+fg/aFqj+8Z+pnIlEes9x8RH/XWIcerECxGea5NAjLdI+xM/dp1fg9+KCc1IHIJ+kg
 Hm15RQS6epcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,318,1583222400"; 
   d="scan'208";a="293098832"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Apr 2020 18:25:46 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jSW3F-0008o5-DD; Sun, 26 Apr 2020 09:25:45 +0800
Date:   Sun, 26 Apr 2020 09:25:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 325518e9b743686f471e7a4ef617b57c91386795
Message-ID: <5ea4e2ff.ilXPROpULD3hu5oz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/mm
branch HEAD: 325518e9b743686f471e7a4ef617b57c91386795  x86/mm: Use pgprotval_t in protval_4k_2_large() and protval_large_2_4k()

elapsed time: 3438m

configs tested: 191
configs skipped: 6

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
powerpc                             defconfig
ia64                                defconfig
m68k                          multi_defconfig
mips                      fuloong2e_defconfig
arc                              allyesconfig
mips                             allyesconfig
microblaze                      mmu_defconfig
sparc64                             defconfig
sh                            titan_defconfig
m68k                           sun3_defconfig
m68k                       m5475evb_defconfig
sh                  sh7785lcr_32bit_defconfig
um                           x86_64_defconfig
mips                           ip32_defconfig
h8300                       h8s-sim_defconfig
riscv                    nommu_virt_defconfig
s390                             alldefconfig
c6x                              allyesconfig
mips                         tb0287_defconfig
riscv                          rv32_defconfig
mips                              allnoconfig
mips                malta_kvm_guest_defconfig
nios2                         10m50_defconfig
powerpc                       ppc64_defconfig
riscv                             allnoconfig
ia64                          tiger_defconfig
parisc                            allnoconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                              allnoconfig
ia64                        generic_defconfig
ia64                         bigsur_defconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
arc                                 defconfig
powerpc                          rhel-kconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                             allmodconfig
mips                       capcella_defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                          ath79_defconfig
mips                        bcm63xx_defconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
parisc                           allmodconfig
parisc               randconfig-a001-20200424
alpha                randconfig-a001-20200424
m68k                 randconfig-a001-20200424
riscv                randconfig-a001-20200424
nds32                randconfig-a001-20200424
nios2                randconfig-a001-20200424
c6x                  randconfig-a001-20200424
h8300                randconfig-a001-20200424
sparc64              randconfig-a001-20200424
microblaze           randconfig-a001-20200424
nios2                randconfig-a001-20200426
c6x                  randconfig-a001-20200426
h8300                randconfig-a001-20200426
sparc64              randconfig-a001-20200426
microblaze           randconfig-a001-20200426
nios2                randconfig-a001-20200423
h8300                randconfig-a001-20200423
c6x                  randconfig-a001-20200423
sparc64              randconfig-a001-20200423
microblaze           randconfig-a001-20200423
nios2                randconfig-a001-20200425
c6x                  randconfig-a001-20200425
h8300                randconfig-a001-20200425
sparc64              randconfig-a001-20200425
microblaze           randconfig-a001-20200425
sh                   randconfig-a001-20200426
csky                 randconfig-a001-20200426
s390                 randconfig-a001-20200426
xtensa               randconfig-a001-20200426
openrisc             randconfig-a001-20200426
sh                   randconfig-a001-20200424
csky                 randconfig-a001-20200424
s390                 randconfig-a001-20200424
xtensa               randconfig-a001-20200424
openrisc             randconfig-a001-20200424
i386                 randconfig-b002-20200426
x86_64               randconfig-b001-20200426
i386                 randconfig-b001-20200426
i386                 randconfig-b003-20200426
x86_64               randconfig-b003-20200426
x86_64               randconfig-d001-20200424
i386                 randconfig-d002-20200424
i386                 randconfig-d001-20200424
x86_64               randconfig-d003-20200424
i386                 randconfig-d003-20200424
x86_64               randconfig-d002-20200426
i386                 randconfig-d002-20200426
i386                 randconfig-d001-20200426
i386                 randconfig-d003-20200426
i386                 randconfig-e003-20200426
x86_64               randconfig-e003-20200426
i386                 randconfig-e002-20200426
i386                 randconfig-e001-20200426
x86_64               randconfig-e001-20200426
x86_64               randconfig-a001-20200424
i386                 randconfig-a003-20200424
x86_64               randconfig-a003-20200424
i386                 randconfig-a002-20200424
i386                 randconfig-a001-20200424
x86_64               randconfig-a002-20200424
x86_64               randconfig-f002-20200426
i386                 randconfig-f002-20200426
x86_64               randconfig-f003-20200426
i386                 randconfig-f003-20200426
i386                 randconfig-f001-20200426
x86_64               randconfig-f001-20200426
i386                 randconfig-g003-20200424
i386                 randconfig-g001-20200424
x86_64               randconfig-g001-20200424
x86_64               randconfig-g002-20200424
i386                 randconfig-g002-20200424
x86_64               randconfig-g003-20200424
sparc                randconfig-a001-20200424
ia64                 randconfig-a001-20200424
powerpc              randconfig-a001-20200424
arm64                randconfig-a001-20200424
arc                  randconfig-a001-20200424
sparc                randconfig-a001-20200425
ia64                 randconfig-a001-20200425
powerpc              randconfig-a001-20200425
arm                  randconfig-a001-20200425
arc                  randconfig-a001-20200425
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec
x86_64                         rhel-7.2-clear
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
