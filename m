Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D886FC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F0620781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgC2SP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:15:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:53206 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728457AbgC2SP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:15:26 -0400
IronPort-SDR: 3DfYK0fnldfZwuSp58z+GG4Pj53vx+u56kSNRukwwIOvJtv4g6FR+A4ohi8bioMHubtEaWEh7d
 HlmNqHkMt5kg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 11:15:25 -0700
IronPort-SDR: wkZML7/gzA4ma8SHDrcULgmmVHtVkOIB0WaeHhXo1LAP2eXKuHFnKB6bJhB4/HUt9zsDYVbg9S
 TvM6J8JdjfLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,321,1580803200"; 
   d="scan'208";a="241421946"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2020 11:15:23 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jIcSx-0003Lk-55; Mon, 30 Mar 2020 02:15:23 +0800
Date:   Mon, 30 Mar 2020 02:14:31 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:efi/core] BUILD SUCCESS
 594e576d4b93b8cda3247542366b47e1b2ddc4dc
Message-ID: <5e80e587.T4d0vHVwIbsD/KLB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  efi/core
branch HEAD: 594e576d4b93b8cda3247542366b47e1b2ddc4dc  efi/libstub/arm: Fix spurious message that an initrd was loaded

elapsed time: 481m

configs tested: 146
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
microblaze                    nommu_defconfig
nds32                             allnoconfig
parisc                generic-32bit_defconfig
sparc64                           allnoconfig
parisc                            allnoconfig
powerpc                       ppc64_defconfig
nios2                         10m50_defconfig
m68k                       m5475evb_defconfig
xtensa                          iss_defconfig
s390                              allnoconfig
h8300                     edosk2674_defconfig
s390                             alldefconfig
riscv                          rv32_defconfig
m68k                          multi_defconfig
alpha                               defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
nds32                               defconfig
csky                                defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                           allyesconfig
parisc                generic-64bit_defconfig
alpha                randconfig-a001-20200329
m68k                 randconfig-a001-20200329
mips                 randconfig-a001-20200329
nds32                randconfig-a001-20200329
parisc               randconfig-a001-20200329
riscv                randconfig-a001-20200329
c6x                  randconfig-a001-20200329
h8300                randconfig-a001-20200329
microblaze           randconfig-a001-20200329
nios2                randconfig-a001-20200329
sparc64              randconfig-a001-20200329
csky                 randconfig-a001-20200329
openrisc             randconfig-a001-20200329
s390                 randconfig-a001-20200329
sh                   randconfig-a001-20200329
xtensa               randconfig-a001-20200329
x86_64               randconfig-b001-20200329
x86_64               randconfig-b002-20200329
x86_64               randconfig-b003-20200329
i386                 randconfig-b001-20200329
i386                 randconfig-b002-20200329
i386                 randconfig-b003-20200329
x86_64               randconfig-c001-20200329
x86_64               randconfig-c002-20200329
x86_64               randconfig-c003-20200329
i386                 randconfig-c001-20200329
i386                 randconfig-c002-20200329
i386                 randconfig-c003-20200329
x86_64               randconfig-d001-20200329
x86_64               randconfig-d002-20200329
x86_64               randconfig-d003-20200329
i386                 randconfig-d001-20200329
i386                 randconfig-d002-20200329
i386                 randconfig-d003-20200329
x86_64               randconfig-e001-20200329
x86_64               randconfig-e002-20200329
x86_64               randconfig-e003-20200329
i386                 randconfig-e001-20200329
i386                 randconfig-e002-20200329
i386                 randconfig-e003-20200329
x86_64               randconfig-h001-20200329
x86_64               randconfig-h002-20200329
x86_64               randconfig-h003-20200329
i386                 randconfig-h001-20200329
i386                 randconfig-h002-20200329
i386                 randconfig-h003-20200329
arc                  randconfig-a001-20200329
arm                  randconfig-a001-20200329
arm64                randconfig-a001-20200329
ia64                 randconfig-a001-20200329
powerpc              randconfig-a001-20200329
sparc                randconfig-a001-20200329
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allmodconfig
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
