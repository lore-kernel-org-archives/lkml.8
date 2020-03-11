Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1BFC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31E6222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgCKJGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:06:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:60942 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgCKJGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:06:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 02:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="231630803"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2020 02:06:43 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jBxK6-000D9m-Dd; Wed, 11 Mar 2020 17:06:42 +0800
Date:   Wed, 11 Mar 2020 17:06:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 bdb04a1abbf92c998f1afb5f00a037f2edaec1f7
Message-ID: <5e68aa06.mp1FHG/GEbeC9Pwh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cpu
branch HEAD: bdb04a1abbf92c998f1afb5f00a037f2edaec1f7  x86/Kconfig: Drop vendor dependency for X86_UMIP

elapsed time: 1429m

configs tested: 188
configs skipped: 102

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
i386                                defconfig
xtensa                       common_defconfig
m68k                             allmodconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
parisc                generic-64bit_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc64                             defconfig
ia64                             alldefconfig
riscv                               defconfig
arc                                 defconfig
sparc64                           allnoconfig
um                           x86_64_defconfig
sh                                allnoconfig
sparc64                          allmodconfig
c6x                              allyesconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                          iss_defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
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
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
alpha                randconfig-a001-20200311
m68k                 randconfig-a001-20200311
mips                 randconfig-a001-20200311
nds32                randconfig-a001-20200311
parisc               randconfig-a001-20200311
riscv                randconfig-a001-20200311
alpha                randconfig-a001-20200309
m68k                 randconfig-a001-20200309
mips                 randconfig-a001-20200309
nds32                randconfig-a001-20200309
parisc               randconfig-a001-20200309
riscv                randconfig-a001-20200309
csky                 randconfig-a001-20200311
openrisc             randconfig-a001-20200311
s390                 randconfig-a001-20200311
sh                   randconfig-a001-20200311
xtensa               randconfig-a001-20200311
csky                 randconfig-a001-20200310
openrisc             randconfig-a001-20200310
s390                 randconfig-a001-20200310
sh                   randconfig-a001-20200310
xtensa               randconfig-a001-20200310
x86_64               randconfig-b001-20200309
x86_64               randconfig-b002-20200309
x86_64               randconfig-b003-20200309
i386                 randconfig-b001-20200309
i386                 randconfig-b002-20200309
i386                 randconfig-b003-20200309
x86_64               randconfig-b001-20200311
x86_64               randconfig-b002-20200311
x86_64               randconfig-b003-20200311
i386                 randconfig-b001-20200311
i386                 randconfig-b002-20200311
i386                 randconfig-b003-20200311
x86_64               randconfig-c001-20200311
x86_64               randconfig-c002-20200311
x86_64               randconfig-c003-20200311
i386                 randconfig-c001-20200311
i386                 randconfig-c002-20200311
i386                 randconfig-c003-20200311
x86_64               randconfig-c001-20200310
x86_64               randconfig-c002-20200310
x86_64               randconfig-c003-20200310
i386                 randconfig-c001-20200310
i386                 randconfig-c002-20200310
i386                 randconfig-c003-20200310
x86_64               randconfig-d001-20200311
x86_64               randconfig-d002-20200311
x86_64               randconfig-d003-20200311
i386                 randconfig-d001-20200311
i386                 randconfig-d002-20200311
i386                 randconfig-d003-20200311
x86_64               randconfig-e001-20200310
x86_64               randconfig-e002-20200310
x86_64               randconfig-e003-20200310
i386                 randconfig-e001-20200310
i386                 randconfig-e002-20200310
i386                 randconfig-e003-20200310
x86_64               randconfig-f001-20200311
x86_64               randconfig-f002-20200311
x86_64               randconfig-f003-20200311
i386                 randconfig-f001-20200311
i386                 randconfig-f002-20200311
i386                 randconfig-f003-20200311
i386                 randconfig-g003-20200310
i386                 randconfig-g001-20200310
x86_64               randconfig-g003-20200310
x86_64               randconfig-g002-20200310
x86_64               randconfig-g001-20200310
i386                 randconfig-g002-20200310
x86_64               randconfig-g001-20200311
x86_64               randconfig-g002-20200311
x86_64               randconfig-g003-20200311
i386                 randconfig-g001-20200311
i386                 randconfig-g002-20200311
i386                 randconfig-g003-20200311
x86_64               randconfig-g001-20200309
x86_64               randconfig-g002-20200309
x86_64               randconfig-g003-20200309
i386                 randconfig-g001-20200309
i386                 randconfig-g002-20200309
i386                 randconfig-g003-20200309
x86_64               randconfig-h001-20200311
x86_64               randconfig-h002-20200311
x86_64               randconfig-h003-20200311
i386                 randconfig-h001-20200311
i386                 randconfig-h002-20200311
i386                 randconfig-h003-20200311
arc                  randconfig-a001-20200311
arm                  randconfig-a001-20200311
arm64                randconfig-a001-20200311
ia64                 randconfig-a001-20200311
powerpc              randconfig-a001-20200311
sparc                randconfig-a001-20200311
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allyesconfig
um                                  defconfig
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
