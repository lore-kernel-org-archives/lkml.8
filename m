Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD477C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767F92072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgBEWXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:23:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:12401 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgBEWXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:23:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 14:23:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="235744152"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2020 14:23:20 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1izT4p-0004rz-RH; Thu, 06 Feb 2020 06:23:19 +0800
Date:   Thu, 06 Feb 2020 06:22:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 febac332a819f0e764aa4da62757ba21d18c182b
Message-ID: <5e3b4036.3/KbfugNoMrddYCf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/urgent
branch HEAD: febac332a819f0e764aa4da62757ba21d18c182b  clocksource: Prevent double add_timer_on() for watchdog_timer

elapsed time: 6222m

configs tested: 215
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
um                                  defconfig
xtensa                       common_defconfig
sh                            titan_defconfig
h8300                     edosk2674_defconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
nds32                               defconfig
sh                          rsk7269_defconfig
sparc64                          allmodconfig
i386                              allnoconfig
h8300                    h8300h-sim_defconfig
sparc                               defconfig
arc                                 defconfig
parisc                            allnoconfig
um                           x86_64_defconfig
s390                                defconfig
parisc                              defconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
x86_64               randconfig-a001-20200205
x86_64               randconfig-a002-20200205
x86_64               randconfig-a003-20200205
i386                 randconfig-a001-20200205
i386                 randconfig-a002-20200205
i386                 randconfig-a003-20200205
i386                 randconfig-a003-20200201
i386                 randconfig-a002-20200201
x86_64               randconfig-a003-20200201
x86_64               randconfig-a002-20200201
i386                 randconfig-a001-20200201
x86_64               randconfig-a001-20200201
x86_64               randconfig-a001-20200204
x86_64               randconfig-a002-20200204
x86_64               randconfig-a003-20200204
i386                 randconfig-a001-20200204
i386                 randconfig-a002-20200204
i386                 randconfig-a003-20200204
h8300                randconfig-a001-20200201
nios2                randconfig-a001-20200201
sparc64              randconfig-a001-20200201
c6x                  randconfig-a001-20200201
c6x                  randconfig-a001-20200205
h8300                randconfig-a001-20200205
microblaze           randconfig-a001-20200205
nios2                randconfig-a001-20200205
sparc64              randconfig-a001-20200205
sh                   randconfig-a001-20200201
s390                 randconfig-a001-20200201
csky                 randconfig-a001-20200201
xtensa               randconfig-a001-20200201
openrisc             randconfig-a001-20200201
x86_64               randconfig-c001-20200204
x86_64               randconfig-c002-20200204
x86_64               randconfig-c003-20200204
i386                 randconfig-c001-20200204
i386                 randconfig-c002-20200204
i386                 randconfig-c003-20200204
x86_64               randconfig-d003-20200201
i386                 randconfig-d001-20200201
x86_64               randconfig-d002-20200201
i386                 randconfig-d003-20200201
x86_64               randconfig-d001-20200201
i386                 randconfig-d002-20200201
x86_64               randconfig-d001-20200205
x86_64               randconfig-d002-20200205
x86_64               randconfig-d003-20200205
i386                 randconfig-d001-20200205
i386                 randconfig-d002-20200205
i386                 randconfig-d003-20200205
x86_64               randconfig-e001-20200205
x86_64               randconfig-e002-20200205
x86_64               randconfig-e003-20200205
i386                 randconfig-e001-20200205
i386                 randconfig-e002-20200205
i386                 randconfig-e003-20200205
i386                 randconfig-e003-20200201
i386                 randconfig-e002-20200201
x86_64               randconfig-e001-20200201
x86_64               randconfig-e003-20200201
i386                 randconfig-e001-20200201
x86_64               randconfig-e002-20200201
i386                 randconfig-f002-20200201
i386                 randconfig-f003-20200201
x86_64               randconfig-f002-20200201
i386                 randconfig-f001-20200201
x86_64               randconfig-f001-20200201
x86_64               randconfig-f003-20200201
x86_64               randconfig-f001-20200204
x86_64               randconfig-f002-20200204
x86_64               randconfig-f003-20200204
i386                 randconfig-f001-20200204
i386                 randconfig-f002-20200204
i386                 randconfig-f003-20200204
x86_64               randconfig-f001-20200205
x86_64               randconfig-f002-20200205
x86_64               randconfig-f003-20200205
i386                 randconfig-f001-20200205
i386                 randconfig-f002-20200205
i386                 randconfig-f003-20200205
x86_64               randconfig-g003-20200201
x86_64               randconfig-g001-20200201
i386                 randconfig-g001-20200201
x86_64               randconfig-g002-20200201
i386                 randconfig-g002-20200201
i386                 randconfig-g003-20200201
x86_64               randconfig-g001-20200205
x86_64               randconfig-g002-20200205
x86_64               randconfig-g003-20200205
i386                 randconfig-g001-20200205
i386                 randconfig-g002-20200205
i386                 randconfig-g003-20200205
x86_64               randconfig-h001-20200201
i386                 randconfig-h002-20200201
x86_64               randconfig-h002-20200201
i386                 randconfig-h003-20200201
x86_64               randconfig-h003-20200201
i386                 randconfig-h001-20200201
x86_64               randconfig-h001-20200204
x86_64               randconfig-h002-20200204
x86_64               randconfig-h003-20200204
i386                 randconfig-h001-20200204
i386                 randconfig-h002-20200204
i386                 randconfig-h003-20200204
arc                  randconfig-a001-20200204
arm                  randconfig-a001-20200204
arm64                randconfig-a001-20200204
ia64                 randconfig-a001-20200204
powerpc              randconfig-a001-20200204
sparc                randconfig-a001-20200204
arm                  randconfig-a001-20200205
arm64                randconfig-a001-20200205
ia64                 randconfig-a001-20200205
powerpc              randconfig-a001-20200205
powerpc              randconfig-a001-20200201
arc                  randconfig-a001-20200201
ia64                 randconfig-a001-20200201
sparc                randconfig-a001-20200201
arm64                randconfig-a001-20200201
arm                  randconfig-a001-20200201
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                  sh7785lcr_32bit_defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
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
