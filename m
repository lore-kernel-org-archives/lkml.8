Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584EDC3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288CF214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgCBTgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:36:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:23935 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbgCBTgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:36:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 11:36:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,508,1574150400"; 
   d="scan'208";a="351612339"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2020 11:36:07 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j8qrG-0006mW-I9; Tue, 03 Mar 2020 03:36:06 +0800
Date:   Tue, 03 Mar 2020 03:35:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 bba42affa732d6fd5bd5c9678e6deacde2de1547
Message-ID: <5e5d5fff.zyTdMyx7nA8D1DfL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: bba42affa732d6fd5bd5c9678e6deacde2de1547  x86/mm: Fix dump_pagetables with Xen PV

elapsed time: 2956m

configs tested: 211
configs skipped: 106

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
ia64                                defconfig
powerpc                             defconfig
i386                              allnoconfig
xtensa                       common_defconfig
nios2                         3c120_defconfig
nds32                             allnoconfig
s390                             alldefconfig
arc                                 defconfig
parisc                generic-64bit_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
nds32                               defconfig
powerpc                           allnoconfig
m68k                       m5475evb_defconfig
h8300                     edosk2674_defconfig
m68k                          multi_defconfig
c6x                              allyesconfig
s390                          debug_defconfig
sh                            titan_defconfig
openrisc                 simple_smp_defconfig
ia64                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                             allyesconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
x86_64               randconfig-a001-20200301
x86_64               randconfig-a002-20200301
x86_64               randconfig-a003-20200301
i386                 randconfig-a001-20200301
i386                 randconfig-a002-20200301
i386                 randconfig-a003-20200301
x86_64               randconfig-a001-20200302
x86_64               randconfig-a002-20200302
x86_64               randconfig-a003-20200302
i386                 randconfig-a001-20200302
i386                 randconfig-a002-20200302
i386                 randconfig-a003-20200302
alpha                randconfig-a001-20200302
parisc               randconfig-a001-20200302
m68k                 randconfig-a001-20200302
mips                 randconfig-a001-20200302
nds32                randconfig-a001-20200302
riscv                randconfig-a001-20200302
alpha                randconfig-a001-20200301
m68k                 randconfig-a001-20200301
mips                 randconfig-a001-20200301
nds32                randconfig-a001-20200301
parisc               randconfig-a001-20200301
riscv                randconfig-a001-20200301
c6x                  randconfig-a001-20200301
h8300                randconfig-a001-20200301
microblaze           randconfig-a001-20200301
nios2                randconfig-a001-20200301
sparc64              randconfig-a001-20200301
c6x                  randconfig-a001-20200302
microblaze           randconfig-a001-20200302
sparc64              randconfig-a001-20200302
csky                 randconfig-a001-20200302
openrisc             randconfig-a001-20200302
s390                 randconfig-a001-20200302
sh                   randconfig-a001-20200302
xtensa               randconfig-a001-20200302
csky                 randconfig-a001-20200301
openrisc             randconfig-a001-20200301
s390                 randconfig-a001-20200301
xtensa               randconfig-a001-20200301
x86_64               randconfig-b001-20200301
x86_64               randconfig-b002-20200301
i386                 randconfig-b001-20200301
i386                 randconfig-b003-20200301
i386                 randconfig-b002-20200301
x86_64               randconfig-b003-20200301
x86_64               randconfig-b001-20200302
x86_64               randconfig-b002-20200302
x86_64               randconfig-b003-20200302
i386                 randconfig-b001-20200302
i386                 randconfig-b002-20200302
i386                 randconfig-b003-20200302
x86_64               randconfig-c001-20200301
x86_64               randconfig-c002-20200301
x86_64               randconfig-c003-20200301
i386                 randconfig-c001-20200301
i386                 randconfig-c002-20200301
i386                 randconfig-c003-20200301
x86_64               randconfig-c001-20200302
x86_64               randconfig-c002-20200302
x86_64               randconfig-c003-20200302
i386                 randconfig-c001-20200302
i386                 randconfig-c002-20200302
i386                 randconfig-c003-20200302
x86_64               randconfig-d001-20200301
x86_64               randconfig-d002-20200301
x86_64               randconfig-d003-20200301
i386                 randconfig-d001-20200301
i386                 randconfig-d002-20200301
i386                 randconfig-d003-20200301
x86_64               randconfig-d001-20200302
x86_64               randconfig-d002-20200302
x86_64               randconfig-d003-20200302
i386                 randconfig-d001-20200302
i386                 randconfig-d002-20200302
i386                 randconfig-d003-20200302
x86_64               randconfig-e001-20200301
x86_64               randconfig-e002-20200301
x86_64               randconfig-e003-20200301
i386                 randconfig-e001-20200301
i386                 randconfig-e002-20200301
i386                 randconfig-e003-20200301
x86_64               randconfig-e001-20200302
x86_64               randconfig-e002-20200302
x86_64               randconfig-e003-20200302
i386                 randconfig-e001-20200302
i386                 randconfig-e002-20200302
i386                 randconfig-e003-20200302
x86_64               randconfig-f001-20200302
x86_64               randconfig-f002-20200302
x86_64               randconfig-f003-20200302
i386                 randconfig-f001-20200302
i386                 randconfig-f002-20200302
i386                 randconfig-f003-20200302
i386                 randconfig-f003-20200301
x86_64               randconfig-f001-20200301
i386                 randconfig-f001-20200301
i386                 randconfig-f002-20200301
x86_64               randconfig-f002-20200301
x86_64               randconfig-f003-20200301
i386                 randconfig-g002-20200302
i386                 randconfig-g003-20200302
i386                 randconfig-g003-20200301
x86_64               randconfig-g003-20200301
i386                 randconfig-g001-20200301
x86_64               randconfig-g001-20200301
x86_64               randconfig-g002-20200301
i386                 randconfig-g002-20200301
x86_64               randconfig-g001-20200302
x86_64               randconfig-g002-20200302
x86_64               randconfig-g003-20200302
i386                 randconfig-g001-20200302
x86_64               randconfig-h001-20200301
x86_64               randconfig-h002-20200301
x86_64               randconfig-h003-20200301
i386                 randconfig-h001-20200301
i386                 randconfig-h002-20200301
i386                 randconfig-h003-20200301
x86_64               randconfig-h001-20200302
x86_64               randconfig-h002-20200302
x86_64               randconfig-h003-20200302
i386                 randconfig-h001-20200302
i386                 randconfig-h002-20200302
i386                 randconfig-h003-20200302
arc                  randconfig-a001-20200301
arm                  randconfig-a001-20200301
arm64                randconfig-a001-20200301
ia64                 randconfig-a001-20200301
powerpc              randconfig-a001-20200301
sparc                randconfig-a001-20200301
arm64                randconfig-a001-20200302
ia64                 randconfig-a001-20200302
powerpc              randconfig-a001-20200302
arc                  randconfig-a001-20200302
arm                  randconfig-a001-20200302
sparc                randconfig-a001-20200302
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
