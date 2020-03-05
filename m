Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE7DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC35B208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCEFu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:50:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:30230 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgCEFuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:50:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 21:50:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574150400"; 
   d="scan'208";a="244175464"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Mar 2020 21:50:11 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j9jOd-0006le-4Z; Thu, 05 Mar 2020 13:50:11 +0800
Date:   Thu, 05 Mar 2020 13:49:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 6f2bc932d8ff72b1a0a5c66f3dad04ccba576a8b
Message-ID: <5e609306.ifCFBVjveSsM3JOh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 6f2bc932d8ff72b1a0a5c66f3dad04ccba576a8b  Merge branch 'core/objtool'

elapsed time: 1130m

configs tested: 192
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
parisc                           allyesconfig
csky                                defconfig
powerpc                             defconfig
sh                          rsk7269_defconfig
mips                              allnoconfig
ia64                             allmodconfig
ia64                              allnoconfig
i386                              allnoconfig
s390                       zfcpdump_defconfig
riscv                             allnoconfig
s390                          debug_defconfig
sh                               allmodconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allyesconfig
ia64                                defconfig
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
alpha                               defconfig
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
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
i386                 randconfig-a003-20200305
i386                 randconfig-a001-20200305
x86_64               randconfig-a001-20200305
i386                 randconfig-a002-20200305
x86_64               randconfig-a003-20200305
x86_64               randconfig-a002-20200305
x86_64               randconfig-a001-20200304
x86_64               randconfig-a002-20200304
x86_64               randconfig-a003-20200304
i386                 randconfig-a001-20200304
i386                 randconfig-a002-20200304
i386                 randconfig-a003-20200304
riscv                randconfig-a001-20200304
alpha                randconfig-a001-20200304
m68k                 randconfig-a001-20200304
nds32                randconfig-a001-20200304
mips                 randconfig-a001-20200304
parisc               randconfig-a001-20200304
c6x                  randconfig-a001-20200305
h8300                randconfig-a001-20200305
microblaze           randconfig-a001-20200305
nios2                randconfig-a001-20200305
sparc64              randconfig-a001-20200305
microblaze           randconfig-a001-20200304
sparc64              randconfig-a001-20200304
c6x                  randconfig-a001-20200304
nios2                randconfig-a001-20200304
h8300                randconfig-a001-20200304
csky                 randconfig-a001-20200304
openrisc             randconfig-a001-20200304
s390                 randconfig-a001-20200304
sh                   randconfig-a001-20200304
xtensa               randconfig-a001-20200304
x86_64               randconfig-b001-20200304
x86_64               randconfig-b002-20200304
x86_64               randconfig-b003-20200304
i386                 randconfig-b001-20200304
i386                 randconfig-b002-20200304
i386                 randconfig-b003-20200304
x86_64               randconfig-b001-20200305
x86_64               randconfig-b002-20200305
x86_64               randconfig-b003-20200305
i386                 randconfig-b001-20200305
i386                 randconfig-b002-20200305
i386                 randconfig-b003-20200305
x86_64               randconfig-c001-20200304
x86_64               randconfig-c002-20200304
x86_64               randconfig-c003-20200304
i386                 randconfig-c001-20200304
i386                 randconfig-c002-20200304
i386                 randconfig-c003-20200304
x86_64               randconfig-d003-20200304
i386                 randconfig-d001-20200304
x86_64               randconfig-d001-20200304
i386                 randconfig-d003-20200304
i386                 randconfig-d002-20200304
x86_64               randconfig-d002-20200304
x86_64               randconfig-e001-20200304
x86_64               randconfig-e002-20200304
x86_64               randconfig-e003-20200304
i386                 randconfig-e001-20200304
i386                 randconfig-e002-20200304
i386                 randconfig-e003-20200304
x86_64               randconfig-e001-20200305
x86_64               randconfig-e002-20200305
x86_64               randconfig-e003-20200305
i386                 randconfig-e001-20200305
i386                 randconfig-e002-20200305
i386                 randconfig-e003-20200305
i386                 randconfig-f003-20200304
x86_64               randconfig-f001-20200304
i386                 randconfig-f001-20200304
i386                 randconfig-f002-20200304
x86_64               randconfig-f002-20200304
x86_64               randconfig-f003-20200304
x86_64               randconfig-g001-20200304
x86_64               randconfig-g002-20200304
x86_64               randconfig-g003-20200304
i386                 randconfig-g001-20200304
i386                 randconfig-g002-20200304
i386                 randconfig-g003-20200304
i386                 randconfig-g003-20200305
x86_64               randconfig-g003-20200305
i386                 randconfig-g001-20200305
x86_64               randconfig-g001-20200305
x86_64               randconfig-g002-20200305
i386                 randconfig-g002-20200305
i386                 randconfig-h001-20200305
x86_64               randconfig-h002-20200305
x86_64               randconfig-h001-20200305
x86_64               randconfig-h003-20200305
i386                 randconfig-h003-20200305
i386                 randconfig-h002-20200305
arc                  randconfig-a001-20200304
ia64                 randconfig-a001-20200304
sparc                randconfig-a001-20200304
arm                  randconfig-a001-20200304
arm64                randconfig-a001-20200304
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                                defconfig
sh                                allnoconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
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
