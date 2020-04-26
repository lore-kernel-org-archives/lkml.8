Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B6CC55186
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 00:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F9B20748
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 00:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgDZA6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 20:58:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:55357 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgDZA6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 20:58:15 -0400
IronPort-SDR: eGih5dI0iVcBmgZ3RlyyIyLuWr+Fhxx9TBYMxD0x6Okw1fHACk58IRAdBShCD8EyZSLlNoB8U6
 Hx/zliwfeIbg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2020 17:58:13 -0700
IronPort-SDR: Hwju3rc7QaA4lTmB/HFVWaKo1cqhXa+S47W2ihkRpPPVMXJr0qQ5cN+DErNw7dRn+sJpTvZ+2l
 ybLFYDNqv6lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,318,1583222400"; 
   d="scan'208";a="431262304"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2020 17:58:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jSVcY-0000bw-Fc; Sun, 26 Apr 2020 08:58:10 +0800
Date:   Sun, 26 Apr 2020 08:57:30 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:lkmm-dev] BUILD SUCCESS
 7cd5e8adf1bb9df5f33eb472adbb047a3ba23acc
Message-ID: <5ea4dc7a.CoE1Y2pWpIuPApST%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  lkmm-dev
branch HEAD: 7cd5e8adf1bb9df5f33eb472adbb047a3ba23acc  tools/memory-model: Use "-unroll 0" to keep --hw runs finite

elapsed time: 12957m

configs tested: 396
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                             allnoconfig
arm                               allnoconfig
arm64                            allmodconfig
arm                              allmodconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
sparc64                           allnoconfig
mips                             allmodconfig
ia64                          tiger_defconfig
mips                            ar7_defconfig
um                             i386_defconfig
mips                              allnoconfig
mips                malta_kvm_guest_defconfig
sh                  sh7785lcr_32bit_defconfig
arc                                 defconfig
parisc                            allnoconfig
ia64                              allnoconfig
microblaze                      mmu_defconfig
ia64                        generic_defconfig
mips                      loongson3_defconfig
mips                         tb0287_defconfig
um                           x86_64_defconfig
i386                                defconfig
riscv                            allmodconfig
mips                      fuloong2e_defconfig
alpha                               defconfig
ia64                                defconfig
xtensa                          iss_defconfig
mips                          ath79_defconfig
um                                  defconfig
mips                       capcella_defconfig
powerpc                             defconfig
riscv                            allyesconfig
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                         bigsur_defconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
openrisc                 simple_smp_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                           ip32_defconfig
mips                  decstation_64_defconfig
mips                        bcm63xx_defconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
parisc                           allmodconfig
parisc               randconfig-a001-20200422
mips                 randconfig-a001-20200422
alpha                randconfig-a001-20200422
m68k                 randconfig-a001-20200422
riscv                randconfig-a001-20200422
nds32                randconfig-a001-20200422
parisc               randconfig-a001-20200424
alpha                randconfig-a001-20200424
m68k                 randconfig-a001-20200424
riscv                randconfig-a001-20200424
nds32                randconfig-a001-20200424
parisc               randconfig-a001-20200421
alpha                randconfig-a001-20200421
mips                 randconfig-a001-20200421
m68k                 randconfig-a001-20200421
riscv                randconfig-a001-20200421
nds32                randconfig-a001-20200421
parisc               randconfig-a001-20200423
alpha                randconfig-a001-20200423
mips                 randconfig-a001-20200423
riscv                randconfig-a001-20200423
nds32                randconfig-a001-20200423
parisc               randconfig-a001-20200426
mips                 randconfig-a001-20200426
alpha                randconfig-a001-20200426
m68k                 randconfig-a001-20200426
nds32                randconfig-a001-20200426
nios2                randconfig-a001-20200421
h8300                randconfig-a001-20200421
c6x                  randconfig-a001-20200421
sparc64              randconfig-a001-20200421
microblaze           randconfig-a001-20200421
nios2                randconfig-a001-20200424
c6x                  randconfig-a001-20200424
h8300                randconfig-a001-20200424
sparc64              randconfig-a001-20200424
microblaze           randconfig-a001-20200424
nios2                randconfig-a001-20200425
c6x                  randconfig-a001-20200425
h8300                randconfig-a001-20200425
sparc64              randconfig-a001-20200425
microblaze           randconfig-a001-20200425
sh                   randconfig-a001-20200421
csky                 randconfig-a001-20200421
s390                 randconfig-a001-20200421
xtensa               randconfig-a001-20200421
openrisc             randconfig-a001-20200421
sh                   randconfig-a001-20200422
csky                 randconfig-a001-20200422
s390                 randconfig-a001-20200422
xtensa               randconfig-a001-20200422
openrisc             randconfig-a001-20200422
sh                   randconfig-a001-20200424
csky                 randconfig-a001-20200424
s390                 randconfig-a001-20200424
xtensa               randconfig-a001-20200424
openrisc             randconfig-a001-20200424
sh                   randconfig-a001-20200425
csky                 randconfig-a001-20200425
s390                 randconfig-a001-20200425
xtensa               randconfig-a001-20200425
openrisc             randconfig-a001-20200425
i386                 randconfig-a002-20200417
x86_64               randconfig-a001-20200417
x86_64               randconfig-a002-20200417
i386                 randconfig-a003-20200417
i386                 randconfig-a001-20200417
x86_64               randconfig-a003-20200417
x86_64               randconfig-a001-20200420
i386                 randconfig-a003-20200420
x86_64               randconfig-a003-20200420
i386                 randconfig-a002-20200420
i386                 randconfig-a001-20200420
x86_64               randconfig-a002-20200420
x86_64               randconfig-a001-20200422
i386                 randconfig-a003-20200422
x86_64               randconfig-a003-20200422
i386                 randconfig-a002-20200422
i386                 randconfig-a001-20200422
x86_64               randconfig-a002-20200422
i386                 randconfig-b002-20200421
i386                 randconfig-b001-20200421
x86_64               randconfig-b001-20200421
i386                 randconfig-b003-20200421
x86_64               randconfig-b002-20200421
x86_64               randconfig-b003-20200421
i386                 randconfig-b002-20200422
i386                 randconfig-b001-20200422
x86_64               randconfig-b001-20200422
i386                 randconfig-b003-20200422
x86_64               randconfig-b003-20200422
i386                 randconfig-b002-20200425
x86_64               randconfig-b001-20200425
i386                 randconfig-b001-20200425
i386                 randconfig-b003-20200425
x86_64               randconfig-b002-20200425
x86_64               randconfig-b003-20200425
i386                 randconfig-b002-20200426
x86_64               randconfig-b001-20200426
i386                 randconfig-b001-20200426
i386                 randconfig-b003-20200426
x86_64               randconfig-b003-20200426
x86_64               randconfig-a001-20200424
i386                 randconfig-a003-20200424
x86_64               randconfig-a003-20200424
i386                 randconfig-a002-20200424
i386                 randconfig-a001-20200424
x86_64               randconfig-a002-20200424
i386                 randconfig-c001-20200421
x86_64               randconfig-c002-20200421
x86_64               randconfig-c001-20200421
i386                 randconfig-c003-20200421
x86_64               randconfig-c003-20200421
i386                 randconfig-c002-20200421
i386                 randconfig-c002-20200424
i386                 randconfig-c001-20200424
x86_64               randconfig-c001-20200424
i386                 randconfig-c003-20200424
x86_64               randconfig-c003-20200424
i386                 randconfig-c002-20200425
i386                 randconfig-c001-20200425
x86_64               randconfig-c002-20200425
x86_64               randconfig-c001-20200425
i386                 randconfig-c003-20200425
x86_64               randconfig-c003-20200425
i386                 randconfig-c002-20200423
i386                 randconfig-c001-20200423
x86_64               randconfig-c002-20200423
x86_64               randconfig-c001-20200423
i386                 randconfig-c003-20200423
x86_64               randconfig-c003-20200423
x86_64               randconfig-d001-20200421
x86_64               randconfig-d002-20200421
i386                 randconfig-d002-20200421
i386                 randconfig-d001-20200421
x86_64               randconfig-d003-20200421
i386                 randconfig-d003-20200421
x86_64               randconfig-d002-20200422
i386                 randconfig-d002-20200422
i386                 randconfig-d001-20200422
i386                 randconfig-d003-20200422
x86_64               randconfig-d001-20200423
x86_64               randconfig-d002-20200423
i386                 randconfig-d002-20200423
i386                 randconfig-d001-20200423
x86_64               randconfig-d003-20200423
i386                 randconfig-d003-20200423
x86_64               randconfig-d001-20200424
i386                 randconfig-d002-20200424
i386                 randconfig-d001-20200424
x86_64               randconfig-d003-20200424
i386                 randconfig-d003-20200424
x86_64               randconfig-d002-20200426
i386                 randconfig-d002-20200426
i386                 randconfig-d001-20200426
i386                 randconfig-d003-20200426
x86_64               randconfig-e002-20200421
i386                 randconfig-e003-20200421
x86_64               randconfig-e003-20200421
i386                 randconfig-e002-20200421
i386                 randconfig-e001-20200421
x86_64               randconfig-e001-20200421
i386                 randconfig-e003-20200422
x86_64               randconfig-e003-20200422
i386                 randconfig-e002-20200422
i386                 randconfig-e001-20200422
x86_64               randconfig-e001-20200422
x86_64               randconfig-e002-20200423
i386                 randconfig-e003-20200423
x86_64               randconfig-e003-20200423
i386                 randconfig-e002-20200423
i386                 randconfig-e001-20200423
x86_64               randconfig-e001-20200423
i386                 randconfig-e003-20200425
x86_64               randconfig-e002-20200425
x86_64               randconfig-e003-20200425
i386                 randconfig-e002-20200425
i386                 randconfig-e001-20200425
x86_64               randconfig-e001-20200425
i386                 randconfig-e003-20200426
x86_64               randconfig-e003-20200426
i386                 randconfig-e002-20200426
i386                 randconfig-e001-20200426
x86_64               randconfig-e001-20200426
i386                 randconfig-f002-20200421
i386                 randconfig-f003-20200421
x86_64               randconfig-f003-20200421
i386                 randconfig-f001-20200421
x86_64               randconfig-f001-20200421
x86_64               randconfig-f002-20200424
i386                 randconfig-f002-20200424
i386                 randconfig-f003-20200424
x86_64               randconfig-f003-20200424
i386                 randconfig-f001-20200424
x86_64               randconfig-f001-20200424
i386                 randconfig-f002-20200425
i386                 randconfig-f003-20200425
x86_64               randconfig-f003-20200425
i386                 randconfig-f001-20200425
x86_64               randconfig-f001-20200425
x86_64               randconfig-f002-20200422
i386                 randconfig-f002-20200422
x86_64               randconfig-f003-20200422
i386                 randconfig-f003-20200422
i386                 randconfig-f001-20200422
x86_64               randconfig-f001-20200422
x86_64               randconfig-f002-20200426
i386                 randconfig-f002-20200426
x86_64               randconfig-f003-20200426
i386                 randconfig-f003-20200426
i386                 randconfig-f001-20200426
x86_64               randconfig-f001-20200426
i386                 randconfig-g003-20200422
x86_64               randconfig-g001-20200422
i386                 randconfig-g001-20200422
x86_64               randconfig-g002-20200422
i386                 randconfig-g002-20200422
x86_64               randconfig-g003-20200422
i386                 randconfig-g003-20200424
i386                 randconfig-g001-20200424
x86_64               randconfig-g001-20200424
x86_64               randconfig-g002-20200424
i386                 randconfig-g002-20200424
x86_64               randconfig-g003-20200424
i386                 randconfig-g003-20200423
x86_64               randconfig-g001-20200423
i386                 randconfig-g001-20200423
i386                 randconfig-g002-20200423
x86_64               randconfig-g003-20200423
i386                 randconfig-h003-20200421
x86_64               randconfig-h001-20200421
x86_64               randconfig-h003-20200421
i386                 randconfig-h002-20200421
i386                 randconfig-h001-20200421
i386                 randconfig-h003-20200424
x86_64               randconfig-h001-20200424
x86_64               randconfig-h003-20200424
x86_64               randconfig-h002-20200424
i386                 randconfig-h001-20200424
i386                 randconfig-h002-20200424
i386                 randconfig-h003-20200425
x86_64               randconfig-h001-20200425
x86_64               randconfig-h003-20200425
i386                 randconfig-h002-20200425
i386                 randconfig-h001-20200425
i386                 randconfig-h003-20200422
x86_64               randconfig-h001-20200422
x86_64               randconfig-h003-20200422
x86_64               randconfig-h002-20200422
i386                 randconfig-h001-20200422
i386                 randconfig-h002-20200422
i386                 randconfig-h003-20200423
x86_64               randconfig-h002-20200423
i386                 randconfig-h002-20200423
i386                 randconfig-h001-20200423
i386                 randconfig-h003-20200426
x86_64               randconfig-h001-20200426
x86_64               randconfig-h003-20200426
x86_64               randconfig-h002-20200426
i386                 randconfig-h001-20200426
i386                 randconfig-h002-20200426
sparc                randconfig-a001-20200421
ia64                 randconfig-a001-20200421
powerpc              randconfig-a001-20200421
arm                  randconfig-a001-20200421
arc                  randconfig-a001-20200421
sparc                randconfig-a001-20200423
ia64                 randconfig-a001-20200423
arm                  randconfig-a001-20200423
arm64                randconfig-a001-20200423
arc                  randconfig-a001-20200423
sparc                randconfig-a001-20200425
ia64                 randconfig-a001-20200425
powerpc              randconfig-a001-20200425
arm                  randconfig-a001-20200425
arc                  randconfig-a001-20200425
sparc                randconfig-a001-20200422
ia64                 randconfig-a001-20200422
powerpc              randconfig-a001-20200422
arm                  randconfig-a001-20200422
arm64                randconfig-a001-20200422
arc                  randconfig-a001-20200422
sparc                randconfig-a001-20200424
ia64                 randconfig-a001-20200424
powerpc              randconfig-a001-20200424
arm64                randconfig-a001-20200424
arc                  randconfig-a001-20200424
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
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
