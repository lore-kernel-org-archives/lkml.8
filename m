Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163ECC11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46D7208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgBTWJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:09:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:21745 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbgBTWJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:09:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 14:09:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="408932474"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Feb 2020 14:09:53 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j4u13-0006GQ-7l; Fri, 21 Feb 2020 06:09:53 +0800
Date:   Fri, 21 Feb 2020 06:09:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.02.07a] BUILD SUCCESS
 b42970dbc19ef6f28f45dcc97dde4054af038b6d
Message-ID: <5e4f03a5.Wtdrgpax9i7k6Ja/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.02.07a
branch HEAD: b42970dbc19ef6f28f45dcc97dde4054af038b6d  rcu: Make rcu_dynticks_curr_cpu_in_eqs() be notrace

elapsed time: 11978m

configs tested: 165
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
ia64                              allnoconfig
mips                      malta_kvm_defconfig
h8300                    h8300h-sim_defconfig
s390                       zfcpdump_defconfig
microblaze                    nommu_defconfig
nios2                         10m50_defconfig
s390                          debug_defconfig
powerpc                             defconfig
arc                                 defconfig
nds32                             allnoconfig
mips                      fuloong2e_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
ia64                             alldefconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200213
x86_64               randconfig-a002-20200213
x86_64               randconfig-a003-20200213
i386                 randconfig-a001-20200213
i386                 randconfig-a002-20200213
i386                 randconfig-a003-20200213
i386                 randconfig-a003-20200212
x86_64               randconfig-a003-20200212
i386                 randconfig-a001-20200212
x86_64               randconfig-a002-20200212
i386                 randconfig-a002-20200212
x86_64               randconfig-a001-20200212
parisc               randconfig-a001-20200212
riscv                randconfig-a001-20200212
m68k                 randconfig-a001-20200212
mips                 randconfig-a001-20200212
nds32                randconfig-a001-20200212
alpha                randconfig-a001-20200212
c6x                  randconfig-a001-20200212
sparc64              randconfig-a001-20200212
h8300                randconfig-a001-20200212
nios2                randconfig-a001-20200212
csky                 randconfig-a001-20200213
openrisc             randconfig-a001-20200213
s390                 randconfig-a001-20200213
sh                   randconfig-a001-20200213
xtensa               randconfig-a001-20200213
openrisc             randconfig-a001-20200212
sh                   randconfig-a001-20200212
csky                 randconfig-a001-20200212
s390                 randconfig-a001-20200212
xtensa               randconfig-a001-20200212
csky                 randconfig-a001-20200219
openrisc             randconfig-a001-20200219
s390                 randconfig-a001-20200219
xtensa               randconfig-a001-20200219
i386                 randconfig-c002-20200212
x86_64               randconfig-c003-20200212
i386                 randconfig-c001-20200212
x86_64               randconfig-c002-20200212
i386                 randconfig-c003-20200212
x86_64               randconfig-c001-20200212
x86_64               randconfig-d001-20200218
x86_64               randconfig-d002-20200218
x86_64               randconfig-d003-20200218
i386                 randconfig-d001-20200218
i386                 randconfig-d002-20200218
i386                 randconfig-d003-20200218
x86_64               randconfig-d001-20200215
x86_64               randconfig-d002-20200215
x86_64               randconfig-d003-20200215
i386                 randconfig-d001-20200215
i386                 randconfig-d002-20200215
i386                 randconfig-d003-20200215
arc                  randconfig-a001-20200213
arm                  randconfig-a001-20200213
arm64                randconfig-a001-20200213
ia64                 randconfig-a001-20200213
powerpc              randconfig-a001-20200213
sparc                randconfig-a001-20200213
arc                  randconfig-a001-20200219
arm                  randconfig-a001-20200219
arm64                randconfig-a001-20200219
ia64                 randconfig-a001-20200219
powerpc              randconfig-a001-20200219
sparc                randconfig-a001-20200219
arc                  randconfig-a001-20200212
sparc                randconfig-a001-20200212
ia64                 randconfig-a001-20200212
arm                  randconfig-a001-20200212
arm64                randconfig-a001-20200212
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
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
