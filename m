Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FC5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED80520704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388788AbgAXO5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:57:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:6731 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387544AbgAXO5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:57:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 06:57:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,358,1574150400"; 
   d="scan'208";a="428311887"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2020 06:57:04 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iv0OO-0003v4-2C; Fri, 24 Jan 2020 22:57:04 +0800
Date:   Fri, 24 Jan 2020 22:56:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:tip] BUILD INCOMPLETE
 0b3680e906bda9219e952c5577899fa282498e8d
Message-ID: <5e2b05bb.8lYXLOEQsoAwvF2U%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  tip
branch HEAD: 0b3680e906bda9219e952c5577899fa282498e8d  auto-x86-next: Add x86/misc

TIMEOUT after 2891m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 7

i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      malta_kvm_defconfig

configs tested: 127
configs skipped: 14

xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
sparc64                          allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm64                randconfig-a001-20200123
powerpc              randconfig-a001-20200123
ia64                 randconfig-a001-20200123
arm                  randconfig-a001-20200123
arc                  randconfig-a001-20200123
sparc                randconfig-a001-20200123
riscv                randconfig-a001-20200122
alpha                randconfig-a001-20200122
m68k                 randconfig-a001-20200122
parisc               randconfig-a001-20200122
nds32                randconfig-a001-20200122
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
openrisc             randconfig-a001-20200123
csky                 randconfig-a001-20200123
xtensa               randconfig-a001-20200123
sh                   randconfig-a001-20200123
s390                 randconfig-a001-20200123
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
h8300                randconfig-a001-20200124
nios2                randconfig-a001-20200124
c6x                  randconfig-a001-20200124
sparc64              randconfig-a001-20200124
arm                              allmodconfig
arm                         at91_dt_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                              allyesconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
i386                              allnoconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
mips                      fuloong2e_defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
alpha                randconfig-a001-20200123
m68k                 randconfig-a001-20200123
mips                 randconfig-a001-20200123
nds32                randconfig-a001-20200123
parisc               randconfig-a001-20200123
riscv                randconfig-a001-20200123
x86_64               randconfig-b002-20200123
i386                 randconfig-b003-20200123
i386                 randconfig-b001-20200123
i386                 randconfig-b002-20200123
x86_64               randconfig-b001-20200123
x86_64               randconfig-b003-20200123
x86_64               randconfig-f003-20200124
x86_64               randconfig-f001-20200124
x86_64               randconfig-f002-20200124
i386                 randconfig-f002-20200124
i386                 randconfig-f003-20200124
i386                 randconfig-f001-20200124
x86_64               randconfig-b002-20200124
i386                 randconfig-b003-20200124
i386                 randconfig-b001-20200124
i386                 randconfig-b002-20200124
x86_64               randconfig-b001-20200124
x86_64               randconfig-b003-20200124

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
