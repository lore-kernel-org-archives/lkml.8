Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E91C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2C7206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgC1SuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:50:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:23019 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbgC1SuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 14:50:18 -0400
IronPort-SDR: W6Pch55uYFiqw1yilE9oLIxQ0Kno4NbjD27oiSavjmL2UQuJAJSudabqrfUpo+m16fWPm3eSA7
 CeQgC/Cw/Lbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 11:50:17 -0700
IronPort-SDR: ecpcXK0BQgW5Go4JFZaHT+gFUWuONwRxahtbCruYSorl1IiVEJZriKHhcTEdH8bOOoyH6Hdoxf
 I+GMSLsbhHAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="248205216"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2020 11:50:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jIGX9-000HPQ-9u; Sun, 29 Mar 2020 02:50:15 +0800
Date:   Sun, 29 Mar 2020 02:50:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 e98eac6ff1b45e4e73f2e6031b37c256ccb5d36b
Message-ID: <5e7f9c60.DYeVe7ZXLyevLjG2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  smp/core
branch HEAD: e98eac6ff1b45e4e73f2e6031b37c256ccb5d36b  cpu/hotplug: Ignore pm_wakeup_pending() for disable_nonboot_cpus()

elapsed time: 482m

configs tested: 156
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
nds32                               defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                             allmodconfig
sh                            titan_defconfig
m68k                           sun3_defconfig
ia64                             alldefconfig
s390                       zfcpdump_defconfig
sparc64                             defconfig
mips                             allmodconfig
h8300                       h8s-sim_defconfig
m68k                          multi_defconfig
nios2                         3c120_defconfig
c6x                              allyesconfig
i386                                defconfig
arc                                 defconfig
riscv                    nommu_virt_defconfig
s390                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
arm                              allmodconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
i386                 randconfig-a002-20200327
i386                 randconfig-a001-20200327
x86_64               randconfig-a002-20200327
x86_64               randconfig-a001-20200327
i386                 randconfig-a003-20200327
x86_64               randconfig-a003-20200327
alpha                randconfig-a001-20200327
m68k                 randconfig-a001-20200327
mips                 randconfig-a001-20200327
nds32                randconfig-a001-20200327
parisc               randconfig-a001-20200327
riscv                randconfig-a001-20200327
c6x                  randconfig-a001-20200327
h8300                randconfig-a001-20200327
microblaze           randconfig-a001-20200327
nios2                randconfig-a001-20200327
sparc64              randconfig-a001-20200327
s390                 randconfig-a001-20200327
xtensa               randconfig-a001-20200327
csky                 randconfig-a001-20200327
openrisc             randconfig-a001-20200327
sh                   randconfig-a001-20200327
i386                 randconfig-b003-20200327
i386                 randconfig-b001-20200327
x86_64               randconfig-b003-20200327
i386                 randconfig-b002-20200327
x86_64               randconfig-b002-20200327
x86_64               randconfig-b001-20200327
x86_64               randconfig-c003-20200327
x86_64               randconfig-c001-20200327
i386                 randconfig-c002-20200327
x86_64               randconfig-c002-20200327
i386                 randconfig-c003-20200327
i386                 randconfig-c001-20200327
i386                 randconfig-d003-20200327
i386                 randconfig-d001-20200327
x86_64               randconfig-d002-20200327
x86_64               randconfig-d001-20200327
i386                 randconfig-d002-20200327
x86_64               randconfig-d003-20200327
x86_64               randconfig-e001-20200327
x86_64               randconfig-e003-20200327
i386                 randconfig-e002-20200327
i386                 randconfig-e003-20200327
i386                 randconfig-e001-20200327
x86_64               randconfig-e002-20200327
i386                 randconfig-f001-20200327
i386                 randconfig-f003-20200327
i386                 randconfig-f002-20200327
x86_64               randconfig-f002-20200327
x86_64               randconfig-f001-20200327
x86_64               randconfig-h003-20200327
i386                 randconfig-h003-20200327
i386                 randconfig-h001-20200327
x86_64               randconfig-h001-20200327
i386                 randconfig-h002-20200327
arm                  randconfig-a001-20200327
powerpc              randconfig-a001-20200327
ia64                 randconfig-a001-20200327
sparc                randconfig-a001-20200327
arc                  randconfig-a001-20200327
arm64                randconfig-a001-20200327
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
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
