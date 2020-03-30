Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3450CC2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCF92072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgC3TPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:15:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:20322 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbgC3TPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:15:46 -0400
IronPort-SDR: 8KtbCPY5Lu0PUTdqJko/6tQknPqvNCFE/bRNhK/CI0p06/H4PCskDr4DCfkzQT33v72cjmAA4E
 15ibhIiF8Zmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 12:15:46 -0700
IronPort-SDR: CuW0s6d3C6jgWjYELttw3b5i5K55kw8y+4J/cnN/qfAEc3mTNh0s5PXcls2KX4g0TdnDzaK1iB
 vZlfkoWaN1KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="283739683"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2020 12:15:44 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jIzsu-0001Nm-2x; Tue, 31 Mar 2020 03:15:44 +0800
Date:   Tue, 31 Mar 2020 03:15:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5dde265e04ea5f714d1e8c059fab5051b41f645a
Message-ID: <5e824547.+lrTL7zrJxv87+qR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 5dde265e04ea5f714d1e8c059fab5051b41f645a  Merge branch 'sched/core'

elapsed time: 483m

configs tested: 152
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
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
arm                              allmodconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
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
parisc                generic-64bit_defconfig
x86_64               randconfig-a003-20200330
x86_64               randconfig-a002-20200330
i386                 randconfig-a001-20200330
i386                 randconfig-a002-20200330
i386                 randconfig-a003-20200330
x86_64               randconfig-a001-20200330
riscv                randconfig-a001-20200330
mips                 randconfig-a001-20200330
m68k                 randconfig-a001-20200330
parisc               randconfig-a001-20200330
alpha                randconfig-a001-20200330
nds32                randconfig-a001-20200330
microblaze           randconfig-a001-20200330
h8300                randconfig-a001-20200330
nios2                randconfig-a001-20200330
c6x                  randconfig-a001-20200330
sparc64              randconfig-a001-20200330
csky                 randconfig-a001-20200330
openrisc             randconfig-a001-20200330
s390                 randconfig-a001-20200330
sh                   randconfig-a001-20200330
xtensa               randconfig-a001-20200330
x86_64               randconfig-c001-20200330
x86_64               randconfig-c002-20200330
x86_64               randconfig-c003-20200330
i386                 randconfig-c001-20200330
i386                 randconfig-c002-20200330
i386                 randconfig-c003-20200330
i386                 randconfig-d003-20200330
i386                 randconfig-d001-20200330
i386                 randconfig-d002-20200330
x86_64               randconfig-d001-20200330
x86_64               randconfig-d003-20200330
x86_64               randconfig-d002-20200330
x86_64               randconfig-e001-20200330
x86_64               randconfig-e002-20200330
x86_64               randconfig-e003-20200330
i386                 randconfig-e001-20200330
i386                 randconfig-e002-20200330
i386                 randconfig-e003-20200330
i386                 randconfig-f001-20200330
i386                 randconfig-f003-20200330
i386                 randconfig-f002-20200330
x86_64               randconfig-f002-20200330
x86_64               randconfig-f001-20200330
x86_64               randconfig-g002-20200330
i386                 randconfig-g001-20200330
x86_64               randconfig-h001-20200330
x86_64               randconfig-h002-20200330
x86_64               randconfig-h003-20200330
i386                 randconfig-h001-20200330
i386                 randconfig-h002-20200330
i386                 randconfig-h003-20200330
sparc                randconfig-a001-20200330
arm64                randconfig-a001-20200330
ia64                 randconfig-a001-20200330
arc                  randconfig-a001-20200330
arm                  randconfig-a001-20200330
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
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
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
