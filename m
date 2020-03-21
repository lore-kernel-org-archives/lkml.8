Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85179C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5717520754
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgCUWgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:36:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:24400 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbgCUWgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 18:36:04 -0400
IronPort-SDR: PXiJJSF//F/T3WIu6N8/KlqBRcCtojxlu3WgMMLEi0jd8b1eCUWA2JfTNCTiz6KkenyK40OWcS
 K2/8jAxJORWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2020 15:36:03 -0700
IronPort-SDR: fLbsV9ZoZl0vrc+e2jeAa5myvZlbP4xkDJWjcQF/1p7HktXHopy/X9+o1fRlgWptFyS2h0budz
 Vc9HREL2pP8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,290,1580803200"; 
   d="scan'208";a="419091643"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2020 15:36:01 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jFmin-000FQw-0l; Sun, 22 Mar 2020 06:36:01 +0800
Date:   Sun, 22 Mar 2020 06:35:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 a5d442f50a41d7c5a6a97b19c49d8a1ee0cf128b
Message-ID: <5e7696b6.HNp093qrM39vO08N%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: a5d442f50a41d7c5a6a97b19c49d8a1ee0cf128b  arm64: vdso32: Enable Clang Compilation

elapsed time: 483m

configs tested: 151
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
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
nds32                             allnoconfig
nios2                         3c120_defconfig
sh                          rsk7269_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
arm                              allmodconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
alpha                               defconfig
csky                                defconfig
nds32                               defconfig
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
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
mips                 randconfig-a001-20200321
nds32                randconfig-a001-20200321
m68k                 randconfig-a001-20200321
parisc               randconfig-a001-20200321
alpha                randconfig-a001-20200321
riscv                randconfig-a001-20200321
h8300                randconfig-a001-20200322
microblaze           randconfig-a001-20200322
nios2                randconfig-a001-20200322
c6x                  randconfig-a001-20200322
sparc64              randconfig-a001-20200322
h8300                randconfig-a001-20200321
microblaze           randconfig-a001-20200321
nios2                randconfig-a001-20200321
c6x                  randconfig-a001-20200321
sparc64              randconfig-a001-20200321
s390                 randconfig-a001-20200321
xtensa               randconfig-a001-20200321
csky                 randconfig-a001-20200321
openrisc             randconfig-a001-20200321
sh                   randconfig-a001-20200321
i386                 randconfig-b003-20200322
i386                 randconfig-b001-20200322
x86_64               randconfig-b003-20200322
i386                 randconfig-b002-20200322
x86_64               randconfig-b002-20200322
x86_64               randconfig-c003-20200321
i386                 randconfig-c002-20200321
x86_64               randconfig-c001-20200321
x86_64               randconfig-c002-20200321
i386                 randconfig-c003-20200321
i386                 randconfig-c001-20200321
i386                 randconfig-d003-20200322
i386                 randconfig-d001-20200322
i386                 randconfig-d002-20200322
x86_64               randconfig-d001-20200322
x86_64               randconfig-d003-20200322
i386                 randconfig-d003-20200321
i386                 randconfig-d001-20200321
x86_64               randconfig-d002-20200321
i386                 randconfig-d002-20200321
x86_64               randconfig-d001-20200321
x86_64               randconfig-d003-20200321
x86_64               randconfig-e001-20200321
i386                 randconfig-e002-20200321
x86_64               randconfig-e003-20200321
i386                 randconfig-e003-20200321
x86_64               randconfig-e002-20200321
i386                 randconfig-e001-20200321
arm                  randconfig-a001-20200321
arm64                randconfig-a001-20200321
ia64                 randconfig-a001-20200321
sparc                randconfig-a001-20200321
arc                  randconfig-a001-20200321
powerpc              randconfig-a001-20200322
ia64                 randconfig-a001-20200322
arc                  randconfig-a001-20200322
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
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
