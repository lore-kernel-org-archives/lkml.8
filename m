Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE02C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE1720732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgCUQei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:34:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:6072 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCUQei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 12:34:38 -0400
IronPort-SDR: IoQ0p7VwKwTyN+9xWNjtaYgodfLf67qFBWaAehwSfmIcLmfMcgqrwcO0ifKgXbWlunaGkx8sF4
 wFUf5WViUxIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2020 09:34:36 -0700
IronPort-SDR: /63A6fatkRMXyx+Nx7FV5C7PNwPqmWX28/lmhte5rTtn46cgAMBjxo8gj4+T9hUa6pqTPI76Ni
 F+y4WhlwNyPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,289,1580803200"; 
   d="scan'208";a="245777301"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Mar 2020 09:34:33 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jFh4y-000D7l-VJ; Sun, 22 Mar 2020 00:34:32 +0800
Date:   Sun, 22 Mar 2020 00:33:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/kcsan] BUILD SUCCESS
 a4654e9bde4ecedb4921e6c8fe2088114bdff1b3
Message-ID: <5e7641f3.SlOfb0ZAIONHPzuI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/kcsan
branch HEAD: a4654e9bde4ecedb4921e6c8fe2088114bdff1b3  Merge branch 'x86/kdump' into locking/kcsan, to resolve conflicts

elapsed time: 484m

configs tested: 151
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
mips                      fuloong2e_defconfig
riscv                          rv32_defconfig
c6x                        evmc6678_defconfig
sparc64                             defconfig
csky                                defconfig
m68k                          multi_defconfig
s390                          debug_defconfig
alpha                               defconfig
sparc                               defconfig
ia64                             allmodconfig
s390                             alldefconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200321
x86_64               randconfig-a002-20200321
x86_64               randconfig-a003-20200321
i386                 randconfig-a001-20200321
i386                 randconfig-a002-20200321
i386                 randconfig-a003-20200321
alpha                randconfig-a001-20200321
m68k                 randconfig-a001-20200321
mips                 randconfig-a001-20200321
nds32                randconfig-a001-20200321
parisc               randconfig-a001-20200321
riscv                randconfig-a001-20200321
c6x                  randconfig-a001-20200321
h8300                randconfig-a001-20200321
microblaze           randconfig-a001-20200321
nios2                randconfig-a001-20200321
sparc64              randconfig-a001-20200321
csky                 randconfig-a001-20200321
openrisc             randconfig-a001-20200321
s390                 randconfig-a001-20200321
sh                   randconfig-a001-20200321
xtensa               randconfig-a001-20200321
x86_64               randconfig-b001-20200321
x86_64               randconfig-b002-20200321
x86_64               randconfig-b003-20200321
i386                 randconfig-b001-20200321
i386                 randconfig-b002-20200321
i386                 randconfig-b003-20200321
x86_64               randconfig-c003-20200321
i386                 randconfig-c002-20200321
x86_64               randconfig-c001-20200321
x86_64               randconfig-c002-20200321
i386                 randconfig-c003-20200321
i386                 randconfig-c001-20200321
x86_64               randconfig-d001-20200321
x86_64               randconfig-d002-20200321
x86_64               randconfig-d003-20200321
i386                 randconfig-d001-20200321
i386                 randconfig-d002-20200321
i386                 randconfig-d003-20200321
x86_64               randconfig-e001-20200321
x86_64               randconfig-e002-20200321
x86_64               randconfig-e003-20200321
i386                 randconfig-e001-20200321
i386                 randconfig-e002-20200321
i386                 randconfig-e003-20200321
x86_64               randconfig-g001-20200321
x86_64               randconfig-g002-20200321
x86_64               randconfig-g003-20200321
i386                 randconfig-g001-20200321
i386                 randconfig-g002-20200321
i386                 randconfig-g003-20200321
arm                  randconfig-a001-20200321
arm64                randconfig-a001-20200321
ia64                 randconfig-a001-20200321
sparc                randconfig-a001-20200321
arc                  randconfig-a001-20200321
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
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
