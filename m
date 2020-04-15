Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1439C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87FCD20774
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392823AbgDOCBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:01:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:63489 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392790AbgDOCAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:00:53 -0400
IronPort-SDR: L5q2/D431jl2s7iplkK44IqhPyXEYikQgjnWjpHXrwbbrG7WGma3sCxRqthY6lzpv8F9z3gB7O
 5fL+2CQWSaGQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 19:00:48 -0700
IronPort-SDR: L4b2+r3W2nuNIZaF0Cw0EN1D8mAOAn9oeHqU7fXxuLswcKQVTB9YOYEQXzffIqb2qfL9szgLMY
 wWdJ30mhStyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; 
   d="scan'208";a="242172309"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Apr 2020 19:00:46 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jOXM6-000B1T-3S; Wed, 15 Apr 2020 10:00:46 +0800
Date:   Wed, 15 Apr 2020 10:00:17 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:kfree_rcu.2020.04.13c] BUILD SUCCESS
 b5acbe24289dc3be5d041c94a8bb0d173c2e0fa2
Message-ID: <5e966ab1.hCQ1siB5m3FKYqQN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  kfree_rcu.2020.04.13c
branch HEAD: b5acbe24289dc3be5d041c94a8bb0d173c2e0fa2  rcu: Add rcu_gp_might_be_stalled()

elapsed time: 483m

configs tested: 193
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
um                                  defconfig
xtensa                       common_defconfig
mips                      fuloong2e_defconfig
riscv                               defconfig
s390                             alldefconfig
mips                              allnoconfig
ia64                                defconfig
powerpc                             defconfig
mips                      malta_kvm_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                             allyesconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200414
x86_64               randconfig-a002-20200414
x86_64               randconfig-a003-20200414
i386                 randconfig-a001-20200414
i386                 randconfig-a002-20200414
i386                 randconfig-a003-20200414
alpha                randconfig-a001-20200414
m68k                 randconfig-a001-20200414
nds32                randconfig-a001-20200414
parisc               randconfig-a001-20200414
riscv                randconfig-a001-20200414
alpha                randconfig-a001-20200415
m68k                 randconfig-a001-20200415
mips                 randconfig-a001-20200415
nds32                randconfig-a001-20200415
parisc               randconfig-a001-20200415
riscv                randconfig-a001-20200415
c6x                  randconfig-a001-20200415
h8300                randconfig-a001-20200415
microblaze           randconfig-a001-20200415
nios2                randconfig-a001-20200415
sparc64              randconfig-a001-20200415
c6x                  randconfig-a001-20200414
h8300                randconfig-a001-20200414
microblaze           randconfig-a001-20200414
nios2                randconfig-a001-20200414
sparc64              randconfig-a001-20200414
csky                 randconfig-a001-20200414
openrisc             randconfig-a001-20200414
s390                 randconfig-a001-20200414
sh                   randconfig-a001-20200414
xtensa               randconfig-a001-20200414
csky                 randconfig-a001-20200415
openrisc             randconfig-a001-20200415
s390                 randconfig-a001-20200415
sh                   randconfig-a001-20200415
xtensa               randconfig-a001-20200415
x86_64               randconfig-b001-20200415
x86_64               randconfig-b002-20200415
x86_64               randconfig-b003-20200415
i386                 randconfig-b001-20200415
i386                 randconfig-b002-20200415
i386                 randconfig-b003-20200415
x86_64               randconfig-b001-20200414
x86_64               randconfig-b002-20200414
x86_64               randconfig-b003-20200414
i386                 randconfig-b001-20200414
i386                 randconfig-b002-20200414
i386                 randconfig-b003-20200414
x86_64               randconfig-c001-20200414
x86_64               randconfig-c002-20200414
x86_64               randconfig-c003-20200414
i386                 randconfig-c001-20200414
i386                 randconfig-c002-20200414
i386                 randconfig-c003-20200414
x86_64               randconfig-d001-20200415
x86_64               randconfig-d002-20200415
x86_64               randconfig-d003-20200415
i386                 randconfig-d001-20200415
i386                 randconfig-d002-20200415
i386                 randconfig-d003-20200415
x86_64               randconfig-g001-20200414
x86_64               randconfig-g002-20200414
x86_64               randconfig-g003-20200414
i386                 randconfig-g001-20200414
i386                 randconfig-g002-20200414
i386                 randconfig-g003-20200414
x86_64               randconfig-g001-20200415
x86_64               randconfig-g002-20200415
x86_64               randconfig-g003-20200415
i386                 randconfig-g001-20200415
i386                 randconfig-g002-20200415
i386                 randconfig-g003-20200415
x86_64               randconfig-h001-20200415
x86_64               randconfig-h002-20200415
x86_64               randconfig-h003-20200415
i386                 randconfig-h001-20200415
i386                 randconfig-h002-20200415
i386                 randconfig-h003-20200415
x86_64               randconfig-h001-20200414
x86_64               randconfig-h002-20200414
x86_64               randconfig-h003-20200414
i386                 randconfig-h001-20200414
i386                 randconfig-h002-20200414
i386                 randconfig-h003-20200414
arc                  randconfig-a001-20200415
arm                  randconfig-a001-20200415
arm64                randconfig-a001-20200415
ia64                 randconfig-a001-20200415
powerpc              randconfig-a001-20200415
sparc                randconfig-a001-20200415
arc                  randconfig-a001-20200414
arm                  randconfig-a001-20200414
arm64                randconfig-a001-20200414
ia64                 randconfig-a001-20200414
powerpc              randconfig-a001-20200414
sparc                randconfig-a001-20200414
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
