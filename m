Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46639C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3BE20715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgBJPlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:41:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:54417 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgBJPlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:41:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 07:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="227214500"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2020 07:40:59 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j1BBD-0005yA-Ei; Mon, 10 Feb 2020 23:40:59 +0800
Date:   Mon, 10 Feb 2020 23:40:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:kcsan] BUILD SUCCESS
 f60f0f543333e128c9b653ecdfdf770ccbeb9bc9
Message-ID: <5e417975.x8O4tTR+fwO7Q8N0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  kcsan
branch HEAD: f60f0f543333e128c9b653ecdfdf770ccbeb9bc9  kcsan: Expose core configuration parameters as module params

elapsed time: 3905m

configs tested: 171
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
csky                                defconfig
um                                  defconfig
i386                              allnoconfig
mips                      malta_kvm_defconfig
riscv                          rv32_defconfig
xtensa                       common_defconfig
m68k                             allmodconfig
mips                              allnoconfig
nios2                         10m50_defconfig
sparc64                             defconfig
sh                               allmodconfig
riscv                               defconfig
arc                                 defconfig
nds32                               defconfig
um                             i386_defconfig
sparc64                          allmodconfig
powerpc                             defconfig
sh                          rsk7269_defconfig
sparc64                           allnoconfig
um                           x86_64_defconfig
m68k                       m5475evb_defconfig
parisc                              defconfig
sh                                allnoconfig
i386                                defconfig
sparc                               defconfig
c6x                        evmc6678_defconfig
s390                             allmodconfig
s390                       zfcpdump_defconfig
h8300                     edosk2674_defconfig
riscv                    nommu_virt_defconfig
parisc                            allnoconfig
mips                             allmodconfig
s390                                defconfig
ia64                                defconfig
powerpc                       ppc64_defconfig
nios2                         3c120_defconfig
sh                            titan_defconfig
openrisc                    or1ksim_defconfig
powerpc                           allnoconfig
microblaze                    nommu_defconfig
s390                             allyesconfig
c6x                              allyesconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
openrisc                 simple_smp_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
nds32                             allnoconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
parisc                           allyesconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
x86_64               randconfig-a001-20200210
x86_64               randconfig-a002-20200210
x86_64               randconfig-a003-20200210
i386                 randconfig-a001-20200210
i386                 randconfig-a002-20200210
i386                 randconfig-a003-20200210
c6x                  randconfig-a001-20200209
h8300                randconfig-a001-20200209
microblaze           randconfig-a001-20200209
nios2                randconfig-a001-20200209
sparc64              randconfig-a001-20200209
c6x                  randconfig-a001-20200210
h8300                randconfig-a001-20200210
microblaze           randconfig-a001-20200210
nios2                randconfig-a001-20200210
sparc64              randconfig-a001-20200210
x86_64               randconfig-b001-20200210
x86_64               randconfig-b002-20200210
x86_64               randconfig-b003-20200210
i386                 randconfig-b001-20200210
i386                 randconfig-b002-20200210
i386                 randconfig-b003-20200210
x86_64               randconfig-c001-20200209
x86_64               randconfig-c002-20200209
x86_64               randconfig-c003-20200209
i386                 randconfig-c001-20200209
i386                 randconfig-c002-20200209
i386                 randconfig-c003-20200209
x86_64               randconfig-c001-20200210
x86_64               randconfig-c002-20200210
x86_64               randconfig-c003-20200210
i386                 randconfig-c001-20200210
i386                 randconfig-c002-20200210
i386                 randconfig-c003-20200210
x86_64               randconfig-d001-20200210
x86_64               randconfig-d002-20200210
x86_64               randconfig-d003-20200210
i386                 randconfig-d001-20200210
i386                 randconfig-d002-20200210
i386                 randconfig-d003-20200210
x86_64               randconfig-e001-20200210
x86_64               randconfig-e002-20200210
x86_64               randconfig-e003-20200210
i386                 randconfig-e001-20200210
i386                 randconfig-e002-20200210
i386                 randconfig-e003-20200210
x86_64               randconfig-f001-20200210
x86_64               randconfig-f002-20200210
x86_64               randconfig-f003-20200210
i386                 randconfig-f001-20200210
i386                 randconfig-f002-20200210
i386                 randconfig-f003-20200210
x86_64               randconfig-g001-20200210
x86_64               randconfig-g002-20200210
x86_64               randconfig-g003-20200210
i386                 randconfig-g001-20200210
i386                 randconfig-g002-20200210
i386                 randconfig-g003-20200210
x86_64               randconfig-h001-20200210
x86_64               randconfig-h002-20200210
x86_64               randconfig-h003-20200210
i386                 randconfig-h001-20200210
i386                 randconfig-h002-20200210
i386                 randconfig-h003-20200210
arc                  randconfig-a001-20200209
arm                  randconfig-a001-20200209
arm64                randconfig-a001-20200209
ia64                 randconfig-a001-20200209
powerpc              randconfig-a001-20200209
sparc                randconfig-a001-20200209
arc                  randconfig-a001-20200210
arm                  randconfig-a001-20200210
arm64                randconfig-a001-20200210
ia64                 randconfig-a001-20200210
powerpc              randconfig-a001-20200210
sparc                randconfig-a001-20200210
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
s390                             alldefconfig
s390                              allnoconfig
s390                          debug_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc64                          allyesconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
