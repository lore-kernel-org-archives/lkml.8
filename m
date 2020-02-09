Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845C0C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC8C2080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgBIUdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 15:33:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:48308 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbgBIUdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:33:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 12:33:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,422,1574150400"; 
   d="scan'208";a="265639440"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Feb 2020 12:33:18 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j0tGY-000EpI-2u; Mon, 10 Feb 2020 04:33:18 +0800
Date:   Mon, 10 Feb 2020 04:32:45 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/urgent] BUILD SUCCESS
 1e474b28e78897d0d170fab3b28ba683149cb9ea
Message-ID: <5e406c6d.QaueDJ9ABgy6wpiF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  smp/urgent
branch HEAD: 1e474b28e78897d0d170fab3b28ba683149cb9ea  smp/up: Make smp_call_function_single() match SMP semantics

elapsed time: 3098m

configs tested: 163
configs skipped: 0

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
s390                              allnoconfig
sparc64                          allmodconfig
riscv                             allnoconfig
sh                                allnoconfig
csky                                defconfig
um                                  defconfig
i386                              allnoconfig
mips                      malta_kvm_defconfig
riscv                          rv32_defconfig
xtensa                       common_defconfig
s390                       zfcpdump_defconfig
parisc                           allyesconfig
m68k                       m5475evb_defconfig
parisc                              defconfig
riscv                    nommu_virt_defconfig
arc                              allyesconfig
xtensa                          iss_defconfig
ia64                                defconfig
s390                                defconfig
i386                                defconfig
h8300                       h8s-sim_defconfig
nds32                             allnoconfig
openrisc                 simple_smp_defconfig
ia64                             allmodconfig
mips                             allmodconfig
sparc64                          allyesconfig
sparc64                           allnoconfig
um                             i386_defconfig
mips                              allnoconfig
powerpc                           allnoconfig
sh                            titan_defconfig
parisc                            allnoconfig
c6x                              allyesconfig
powerpc                             defconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
m68k                             allmodconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
c6x                  randconfig-a001-20200209
h8300                randconfig-a001-20200209
microblaze           randconfig-a001-20200209
nios2                randconfig-a001-20200209
sparc64              randconfig-a001-20200209
h8300                randconfig-a001-20200208
nios2                randconfig-a001-20200208
microblaze           randconfig-a001-20200208
sparc64              randconfig-a001-20200208
c6x                  randconfig-a001-20200208
s390                 randconfig-a001-20200208
csky                 randconfig-a001-20200208
sh                   randconfig-a001-20200208
xtensa               randconfig-a001-20200208
openrisc             randconfig-a001-20200208
x86_64               randconfig-b001-20200210
x86_64               randconfig-b002-20200210
x86_64               randconfig-b003-20200210
i386                 randconfig-b001-20200210
i386                 randconfig-b002-20200210
i386                 randconfig-b003-20200210
x86_64               randconfig-c001-20200207
x86_64               randconfig-c002-20200207
x86_64               randconfig-c003-20200207
i386                 randconfig-c001-20200207
i386                 randconfig-c002-20200207
i386                 randconfig-c003-20200207
x86_64               randconfig-c001-20200209
x86_64               randconfig-c002-20200209
x86_64               randconfig-c003-20200209
i386                 randconfig-c001-20200209
i386                 randconfig-c002-20200209
i386                 randconfig-c003-20200209
x86_64               randconfig-c001-20200208
x86_64               randconfig-c002-20200208
x86_64               randconfig-c003-20200208
i386                 randconfig-c001-20200208
i386                 randconfig-c002-20200208
i386                 randconfig-c003-20200208
x86_64               randconfig-d001-20200207
x86_64               randconfig-d002-20200207
x86_64               randconfig-d003-20200207
i386                 randconfig-d001-20200207
i386                 randconfig-d002-20200207
i386                 randconfig-d003-20200207
x86_64               randconfig-f001-20200210
x86_64               randconfig-f002-20200210
x86_64               randconfig-f003-20200210
i386                 randconfig-f001-20200210
i386                 randconfig-f002-20200210
i386                 randconfig-f003-20200210
i386                 randconfig-f002-20200208
i386                 randconfig-f003-20200208
x86_64               randconfig-f002-20200208
i386                 randconfig-f001-20200208
x86_64               randconfig-f001-20200208
x86_64               randconfig-f003-20200208
x86_64               randconfig-g001-20200210
x86_64               randconfig-g002-20200210
x86_64               randconfig-g003-20200210
i386                 randconfig-g001-20200210
i386                 randconfig-g002-20200210
i386                 randconfig-g003-20200210
arc                  randconfig-a001-20200208
ia64                 randconfig-a001-20200208
sparc                randconfig-a001-20200208
arm64                randconfig-a001-20200208
arm                  randconfig-a001-20200208
riscv                            allmodconfig
riscv                            allyesconfig
riscv                               defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                             allyesconfig
s390                          debug_defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc                               defconfig
sparc64                             defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
