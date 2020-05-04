Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7E1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3D820663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgEDRia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:38:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:16140 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730032AbgEDRia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:38:30 -0400
IronPort-SDR: QQFZU0pRrJNcsbKgtqFtOjXqpVx2CKZI1Gt4hBkBDxpNNl6iychyxN+5yB8Yt9J1Fq2h2R9dZn
 ubN4OC8YGpUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 10:38:29 -0700
IronPort-SDR: EhmT2hBAhXyQCtUqJRpl9QSK8YtbIxLR5ZMVgssJEM26ptGSUBMgGEbTtE+TYWLl2ldS68E6mG
 RbJBSpnlvcvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="434173944"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 May 2020 10:38:27 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jVf2x-0009PD-10; Tue, 05 May 2020 01:38:27 +0800
Date:   Tue, 05 May 2020 01:37:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 829960d8a31ef6f025276341b6bc13be4800be4a
Message-ID: <5eb052ca.aNM5W0zyoCkVmv3Q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 829960d8a31ef6f025276341b6bc13be4800be4a  rcu: Add callbacks-invoked counters

elapsed time: 3002m

configs tested: 192
configs skipped: 22

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
um                                  defconfig
s390                       zfcpdump_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                        generic_defconfig
ia64                          tiger_defconfig
ia64                         bigsur_defconfig
ia64                             allyesconfig
ia64                             alldefconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
m68k                       bvme6000_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
xtensa                          iss_defconfig
h8300                    h8300h-sim_defconfig
xtensa                       common_defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                malta_kvm_guest_defconfig
mips                         tb0287_defconfig
mips                       capcella_defconfig
mips                           ip32_defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                          ath79_defconfig
mips                        bcm63xx_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                      chrp32_defconfig
powerpc                             defconfig
powerpc                       holly_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
powerpc                  mpc866_ads_defconfig
powerpc                    amigaone_defconfig
powerpc                    adder875_defconfig
powerpc                     ep8248e_defconfig
powerpc                          g5_defconfig
powerpc                     mpc512x_defconfig
m68k                 randconfig-a001-20200502
mips                 randconfig-a001-20200502
nds32                randconfig-a001-20200502
alpha                randconfig-a001-20200502
parisc               randconfig-a001-20200502
riscv                randconfig-a001-20200502
m68k                 randconfig-a001-20200503
mips                 randconfig-a001-20200503
nds32                randconfig-a001-20200503
alpha                randconfig-a001-20200503
parisc               randconfig-a001-20200503
riscv                randconfig-a001-20200503
h8300                randconfig-a001-20200503
nios2                randconfig-a001-20200503
microblaze           randconfig-a001-20200503
c6x                  randconfig-a001-20200503
sparc64              randconfig-a001-20200503
s390                 randconfig-a001-20200430
xtensa               randconfig-a001-20200430
csky                 randconfig-a001-20200430
openrisc             randconfig-a001-20200430
sh                   randconfig-a001-20200430
xtensa               randconfig-a001-20200503
openrisc             randconfig-a001-20200503
csky                 randconfig-a001-20200503
i386                 randconfig-b003-20200503
x86_64               randconfig-b002-20200503
i386                 randconfig-b001-20200503
x86_64               randconfig-b003-20200503
x86_64               randconfig-b001-20200503
i386                 randconfig-b002-20200503
x86_64               randconfig-c002-20200502
i386                 randconfig-c002-20200502
i386                 randconfig-c001-20200502
i386                 randconfig-c003-20200502
x86_64               randconfig-e003-20200503
x86_64               randconfig-e002-20200503
i386                 randconfig-e003-20200503
x86_64               randconfig-e001-20200503
i386                 randconfig-e002-20200503
i386                 randconfig-e001-20200503
i386                 randconfig-f003-20200502
x86_64               randconfig-f001-20200502
x86_64               randconfig-f003-20200502
x86_64               randconfig-f002-20200502
i386                 randconfig-f001-20200502
i386                 randconfig-f002-20200502
i386                 randconfig-f003-20200503
x86_64               randconfig-f002-20200503
i386                 randconfig-f001-20200503
i386                 randconfig-f002-20200503
x86_64               randconfig-g003-20200503
i386                 randconfig-g003-20200503
i386                 randconfig-g002-20200503
x86_64               randconfig-g001-20200503
i386                 randconfig-g001-20200503
i386                 randconfig-h002-20200504
i386                 randconfig-h001-20200504
i386                 randconfig-h003-20200504
x86_64               randconfig-h002-20200504
x86_64               randconfig-h003-20200504
x86_64               randconfig-h001-20200504
i386                 randconfig-h001-20200502
i386                 randconfig-h002-20200502
i386                 randconfig-h003-20200502
x86_64               randconfig-h002-20200502
x86_64               randconfig-h001-20200502
x86_64               randconfig-h003-20200502
ia64                 randconfig-a001-20200502
arm64                randconfig-a001-20200502
arc                  randconfig-a001-20200502
powerpc              randconfig-a001-20200502
arm                  randconfig-a001-20200502
sparc                randconfig-a001-20200502
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
