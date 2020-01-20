Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E35C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBA12465A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgATSMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:12:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:39080 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbgATSMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:12:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 10:11:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="227116426"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Jan 2020 10:11:58 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1itbWn-0005mw-Ld; Tue, 21 Jan 2020 02:11:57 +0800
Date:   Tue, 21 Jan 2020 02:11:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/kcsan] BUILD SUCCESS
 837171fe77d700222bb75ef5fe26f4785fcd9e99
Message-ID: <5e25ed4c.5MLv9atpH+rOEEHC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/kcsan
branch HEAD: 837171fe77d700222bb75ef5fe26f4785fcd9e99  Merge tag 'v5.5-rc7' into locking/kcsan, to refresh the tree

elapsed time: 390m

configs tested: 168
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64               randconfig-e001-20200120
x86_64               randconfig-e002-20200120
x86_64               randconfig-e003-20200120
i386                 randconfig-e001-20200120
i386                 randconfig-e002-20200120
i386                 randconfig-e003-20200120
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
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
csky                 randconfig-a001-20200120
openrisc             randconfig-a001-20200120
s390                 randconfig-a001-20200120
sh                   randconfig-a001-20200120
xtensa               randconfig-a001-20200120
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
x86_64               randconfig-g001-20200120
x86_64               randconfig-g002-20200120
x86_64               randconfig-g003-20200120
i386                 randconfig-g001-20200120
i386                 randconfig-g002-20200120
i386                 randconfig-g003-20200120
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
x86_64               randconfig-d001-20200120
x86_64               randconfig-d002-20200120
x86_64               randconfig-d003-20200120
i386                 randconfig-d001-20200120
i386                 randconfig-d002-20200120
i386                 randconfig-d003-20200120
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
ia64                                defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
csky                 randconfig-a001-20200121
openrisc             randconfig-a001-20200121
s390                 randconfig-a001-20200121
sh                   randconfig-a001-20200121
xtensa               randconfig-a001-20200121
x86_64               randconfig-c001-20200120
x86_64               randconfig-c002-20200120
x86_64               randconfig-c003-20200120
i386                 randconfig-c001-20200120
i386                 randconfig-c002-20200120
i386                 randconfig-c003-20200120
x86_64               randconfig-f001-20200120
x86_64               randconfig-f002-20200120
x86_64               randconfig-f003-20200120
i386                 randconfig-f001-20200120
i386                 randconfig-f002-20200120
i386                 randconfig-f003-20200120
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
c6x                  randconfig-a001-20200120
h8300                randconfig-a001-20200120
microblaze           randconfig-a001-20200120
nios2                randconfig-a001-20200120
sparc64              randconfig-a001-20200120
x86_64               randconfig-a001-20200120
x86_64               randconfig-a002-20200120
x86_64               randconfig-a003-20200120
i386                 randconfig-a001-20200120
i386                 randconfig-a002-20200120
i386                 randconfig-a003-20200120
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
arc                  randconfig-a001-20200120
arm                  randconfig-a001-20200120
arm64                randconfig-a001-20200120
ia64                 randconfig-a001-20200120
powerpc              randconfig-a001-20200120
sparc                randconfig-a001-20200120
x86_64               randconfig-b001-20200120
x86_64               randconfig-b002-20200120
x86_64               randconfig-b003-20200120
i386                 randconfig-b001-20200120
i386                 randconfig-b002-20200120
i386                 randconfig-b003-20200120
x86_64               randconfig-h001-20200120
x86_64               randconfig-h002-20200120
x86_64               randconfig-h003-20200120
i386                 randconfig-h001-20200120
i386                 randconfig-h002-20200120
i386                 randconfig-h003-20200120
c6x                  randconfig-a001-20200121
h8300                randconfig-a001-20200121
microblaze           randconfig-a001-20200121
nios2                randconfig-a001-20200121
sparc64              randconfig-a001-20200121

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
