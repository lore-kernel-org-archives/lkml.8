Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58103C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F9720748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAQEb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 23:31:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:14867 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgAQEb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 23:31:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 20:31:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,328,1574150400"; 
   d="scan'208";a="373545879"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2020 20:31:24 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1isJI4-0005f8-9p; Fri, 17 Jan 2020 12:31:24 +0800
Date:   Fri, 17 Jan 2020 12:31:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 a006483b2f97af685f0e60f3a547c9ad4c9b9e94
Message-ID: <5e213894.hSm/+gfNsLO5ExxV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: a006483b2f97af685f0e60f3a547c9ad4c9b9e94  x86/CPU/AMD: Ensure clearing of SME/SEV features is maintained

elapsed time: 516m

configs tested: 144
configs skipped: 71

The following configs have been built successfully.
More configs may be tested in the coming days.

c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
c6x                  randconfig-a001-20200117
h8300                randconfig-a001-20200117
microblaze           randconfig-a001-20200117
nios2                randconfig-a001-20200117
sparc64              randconfig-a001-20200117
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
x86_64               randconfig-g001-20200117
x86_64               randconfig-g002-20200117
x86_64               randconfig-g003-20200117
i386                 randconfig-g001-20200117
i386                 randconfig-g002-20200117
i386                 randconfig-g003-20200117
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-e001-20200117
x86_64               randconfig-e002-20200117
x86_64               randconfig-e003-20200117
i386                 randconfig-e001-20200117
i386                 randconfig-e002-20200117
i386                 randconfig-e003-20200117
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64               randconfig-b001-20200117
x86_64               randconfig-b002-20200117
x86_64               randconfig-b003-20200117
i386                 randconfig-b001-20200117
i386                 randconfig-b002-20200117
i386                 randconfig-b003-20200117
alpha                randconfig-a001-20200117
m68k                 randconfig-a001-20200117
mips                 randconfig-a001-20200117
nds32                randconfig-a001-20200117
parisc               randconfig-a001-20200117
riscv                randconfig-a001-20200117
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
x86_64               randconfig-c001-20200117
x86_64               randconfig-c002-20200117
x86_64               randconfig-c003-20200117
i386                 randconfig-c001-20200117
i386                 randconfig-c002-20200117
i386                 randconfig-c003-20200117
csky                 randconfig-a001-20200117
openrisc             randconfig-a001-20200117
s390                 randconfig-a001-20200117
sh                   randconfig-a001-20200117
xtensa               randconfig-a001-20200117
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64               randconfig-d001-20200117
x86_64               randconfig-d002-20200117
x86_64               randconfig-d003-20200117
i386                 randconfig-d001-20200117
i386                 randconfig-d002-20200117
i386                 randconfig-d003-20200117
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
s390                             allmodconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
arc                  randconfig-a001-20200117
arm                  randconfig-a001-20200117
arm64                randconfig-a001-20200117
ia64                 randconfig-a001-20200117
powerpc              randconfig-a001-20200117
sparc                randconfig-a001-20200117
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64               randconfig-a001-20200117
x86_64               randconfig-a002-20200117
x86_64               randconfig-a003-20200117
i386                 randconfig-a001-20200117
i386                 randconfig-a002-20200117
i386                 randconfig-a003-20200117
x86_64               randconfig-h001-20200117
x86_64               randconfig-h002-20200117
x86_64               randconfig-h003-20200117
i386                 randconfig-h001-20200117
i386                 randconfig-h002-20200117
i386                 randconfig-h003-20200117
s390                             alldefconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
