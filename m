Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C609EC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 23:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C01220754
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 23:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgCUXGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 19:06:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:56827 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgCUXGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 19:06:13 -0400
IronPort-SDR: 2M24gmKPxKb1n3eaZR63djypLl/qDivR1iSfZ7XtjZ2ciQINSrdVZJE+SKK4O/TsIrbfEdNUrF
 EzaUj1PoeY8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2020 16:06:12 -0700
IronPort-SDR: 0/cXOI/hYpV+Gtz7FH1iMKFbzqRqEXpul8yMorOM8mKCnphDCQcXHRvXPKIy9Ch2n469XGwPIx
 mBbGedMc4GXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,290,1580803200"; 
   d="scan'208";a="269472126"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Mar 2020 16:06:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jFnBy-0001Tr-TP; Sun, 22 Mar 2020 07:06:10 +0800
Date:   Sun, 22 Mar 2020 07:06:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD REGRESSION
 d53f2b62fcb63f6547c10d8c62bca19e957b0eef
Message-ID: <5e769dd8.DwOuHyI25W7qtzFM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  locking/core
branch HEAD: d53f2b62fcb63f6547c10d8c62bca19e957b0eef  lockdep: Add posixtimer context tracing bits

Regressions in current branch:

include/linux/fs.h:1422:29: error: array type has incomplete element type 'struct percpu_rw_semaphore'

Error ids grouped by kconfigs:

recent_errors
`-- m68k-m5275evb_defconfig
    `-- include-linux-fs.h:error:array-type-has-incomplete-element-type-struct-percpu_rw_semaphore

elapsed time: 482m

configs tested: 149
configs skipped: 2

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
c6x                              allyesconfig
powerpc                             defconfig
ia64                                defconfig
s390                          debug_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                          rhel-kconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
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
i386                 randconfig-a001-20200322
i386                 randconfig-a002-20200322
i386                 randconfig-a003-20200322
alpha                randconfig-a001-20200321
m68k                 randconfig-a001-20200321
mips                 randconfig-a001-20200321
nds32                randconfig-a001-20200321
parisc               randconfig-a001-20200321
riscv                randconfig-a001-20200321
c6x                  randconfig-a001-20200322
h8300                randconfig-a001-20200322
microblaze           randconfig-a001-20200322
nios2                randconfig-a001-20200322
sparc64              randconfig-a001-20200322
h8300                randconfig-a001-20200321
microblaze           randconfig-a001-20200321
nios2                randconfig-a001-20200321
c6x                  randconfig-a001-20200321
sparc64              randconfig-a001-20200321
csky                 randconfig-a001-20200322
openrisc             randconfig-a001-20200322
s390                 randconfig-a001-20200322
sh                   randconfig-a001-20200322
xtensa               randconfig-a001-20200322
s390                 randconfig-a001-20200321
xtensa               randconfig-a001-20200321
csky                 randconfig-a001-20200321
openrisc             randconfig-a001-20200321
sh                   randconfig-a001-20200321
i386                 randconfig-c001-20200321
i386                 randconfig-c002-20200321
i386                 randconfig-c003-20200321
x86_64               randconfig-d002-20200322
i386                 randconfig-d001-20200322
i386                 randconfig-d002-20200322
i386                 randconfig-d003-20200322
x86_64               randconfig-e003-20200322
i386                 randconfig-e001-20200322
i386                 randconfig-e002-20200322
i386                 randconfig-e003-20200322
i386                 randconfig-f001-20200322
i386                 randconfig-f002-20200322
i386                 randconfig-f003-20200322
i386                 randconfig-g001-20200322
i386                 randconfig-g002-20200322
i386                 randconfig-g003-20200322
i386                 randconfig-h001-20200322
i386                 randconfig-h002-20200322
i386                 randconfig-h003-20200322
arm                  randconfig-a001-20200322
arm64                randconfig-a001-20200322
ia64                 randconfig-a001-20200322
arc                  randconfig-a001-20200322
sparc                randconfig-a001-20200322
powerpc              randconfig-a001-20200322
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
s390                                defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
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
