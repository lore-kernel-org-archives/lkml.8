Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BD2C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC9520735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbgDMR4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:56:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:11989 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387436AbgDMR4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:56:44 -0400
IronPort-SDR: qrPlIhJdYlEsZRL9hM/8umkntQYmNpI1E2QTKcNLGyG1EqcLPkbTfNtcaGdewWOomTw792EDK5
 fwtobT42/NYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 10:56:43 -0700
IronPort-SDR: ybBueqj+4xLRWQU4b+M0VpnOSB2dXDEeAp9jGUn3Fcaw1R8sbFd1qzWLAcHuMCjFfafiCvlzuF
 bc9KTYT4OIeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="399682976"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 10:56:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jO3K5-0008VL-T3; Tue, 14 Apr 2020 01:56:41 +0800
Date:   Tue, 14 Apr 2020 01:56:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/kcsan] BUILD SUCCESS
 3b02a051d25d9600e9d403ad3043aed7de00160e
Message-ID: <5e94a7d2.f6Bk89AubGryLaUH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/kcsan
branch HEAD: 3b02a051d25d9600e9d403ad3043aed7de00160e  Merge tag 'v5.7-rc1' into locking/kcsan, to resolve conflicts and refresh

elapsed time: 524m

configs tested: 152
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
h8300                    h8300h-sim_defconfig
sparc64                          allmodconfig
s390                             allyesconfig
arc                                 defconfig
parisc                generic-64bit_defconfig
ia64                                defconfig
powerpc                             defconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
mips                 randconfig-a001-20200413
nds32                randconfig-a001-20200413
riscv                randconfig-a001-20200413
m68k                 randconfig-a001-20200413
parisc               randconfig-a001-20200413
alpha                randconfig-a001-20200413
h8300                randconfig-a001-20200413
nios2                randconfig-a001-20200413
c6x                  randconfig-a001-20200413
microblaze           randconfig-a001-20200413
sparc64              randconfig-a001-20200413
csky                 randconfig-a001-20200413
openrisc             randconfig-a001-20200413
s390                 randconfig-a001-20200413
sh                   randconfig-a001-20200413
xtensa               randconfig-a001-20200413
x86_64               randconfig-b002-20200413
x86_64               randconfig-c001-20200413
x86_64               randconfig-c002-20200413
x86_64               randconfig-c003-20200413
i386                 randconfig-c001-20200413
i386                 randconfig-c002-20200413
i386                 randconfig-c003-20200413
x86_64               randconfig-d001-20200413
x86_64               randconfig-d002-20200413
x86_64               randconfig-d003-20200413
i386                 randconfig-d001-20200413
i386                 randconfig-d002-20200413
i386                 randconfig-d003-20200413
x86_64               randconfig-e001-20200413
i386                 randconfig-e002-20200413
i386                 randconfig-e001-20200413
x86_64               randconfig-e002-20200413
i386                 randconfig-e003-20200413
x86_64               randconfig-e003-20200413
i386                 randconfig-f003-20200413
i386                 randconfig-f002-20200413
x86_64               randconfig-f003-20200413
x86_64               randconfig-f001-20200413
x86_64               randconfig-f002-20200413
i386                 randconfig-f001-20200413
x86_64               randconfig-g001-20200413
x86_64               randconfig-g002-20200413
x86_64               randconfig-g003-20200413
i386                 randconfig-g001-20200413
i386                 randconfig-g002-20200413
i386                 randconfig-g003-20200413
x86_64               randconfig-h001-20200413
i386                 randconfig-h003-20200413
i386                 randconfig-h002-20200413
i386                 randconfig-h001-20200413
x86_64               randconfig-h002-20200413
ia64                 randconfig-a001-20200413
arc                  randconfig-a001-20200413
arm                  randconfig-a001-20200413
sparc                randconfig-a001-20200413
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
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
