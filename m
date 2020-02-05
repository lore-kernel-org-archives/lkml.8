Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72859C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447602082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgBEN4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:56:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:12737 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgBEN4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:56:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 05:56:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,405,1574150400"; 
   d="scan'208";a="264228156"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Feb 2020 05:56:18 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1izLAA-00093H-08; Wed, 05 Feb 2020 21:56:18 +0800
Date:   Wed, 05 Feb 2020 21:55:30 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 fdbfb51ae760d1bba3f89e4fa00da83016ec4dbe
Message-ID: <5e3ac952.KqibitT7dUiJnFk7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  x86/cpu
branch HEAD: fdbfb51ae760d1bba3f89e4fa00da83016ec4dbe  x86/split_lock: Enable split lock detection by kernel

elapsed time: 9836m

configs tested: 192
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

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
sparc                            allyesconfig
sparc64                             defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
ia64                             alldefconfig
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
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                             defconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
arc                                 defconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
parisc                            allyesonfig
x86_64               randconfig-a001-20200203
x86_64               randconfig-a002-20200203
x86_64               randconfig-a003-20200203
i386                 randconfig-a001-20200203
i386                 randconfig-a002-20200203
i386                 randconfig-a003-20200203
alpha                randconfig-a001-20200129
m68k                 randconfig-a001-20200129
mips                 randconfig-a001-20200129
nds32                randconfig-a001-20200129
parisc               randconfig-a001-20200129
riscv                randconfig-a001-20200129
alpha                randconfig-a001-20200204
m68k                 randconfig-a001-20200204
mips                 randconfig-a001-20200204
nds32                randconfig-a001-20200204
parisc               randconfig-a001-20200204
riscv                randconfig-a001-20200204
h8300                randconfig-a001-20200130
nios2                randconfig-a001-20200130
c6x                  randconfig-a001-20200130
sparc64              randconfig-a001-20200130
c6x                  randconfig-a001-20200204
h8300                randconfig-a001-20200204
microblaze           randconfig-a001-20200204
nios2                randconfig-a001-20200204
sparc64              randconfig-a001-20200204
microblaze           randconfig-a001-20200130
xtensa               randconfig-a001-20200130
openrisc             randconfig-a001-20200130
csky                 randconfig-a001-20200130
sh                   randconfig-a001-20200130
s390                 randconfig-a001-20200130
csky                 randconfig-a001-20200202
openrisc             randconfig-a001-20200202
s390                 randconfig-a001-20200202
sh                   randconfig-a001-20200202
xtensa               randconfig-a001-20200202
x86_64               randconfig-b001-20200204
x86_64               randconfig-b002-20200204
x86_64               randconfig-b003-20200204
i386                 randconfig-b001-20200204
i386                 randconfig-b002-20200204
i386                 randconfig-b003-20200204
x86_64               randconfig-b002-20200129
i386                 randconfig-b003-20200129
i386                 randconfig-b001-20200129
i386                 randconfig-b002-20200129
x86_64               randconfig-b001-20200129
x86_64               randconfig-b003-20200129
i386                 randconfig-c003-20200129
x86_64               randconfig-c003-20200129
x86_64               randconfig-c002-20200129
x86_64               randconfig-c001-20200129
i386                 randconfig-c001-20200129
i386                 randconfig-c002-20200129
x86_64               randconfig-c001-20200204
x86_64               randconfig-c002-20200204
x86_64               randconfig-c003-20200204
i386                 randconfig-c001-20200204
i386                 randconfig-c002-20200204
i386                 randconfig-c003-20200204
x86_64               randconfig-e001-20200204
x86_64               randconfig-e002-20200204
x86_64               randconfig-e003-20200204
i386                 randconfig-e001-20200204
i386                 randconfig-e002-20200204
i386                 randconfig-e003-20200204
x86_64               randconfig-f001-20200204
x86_64               randconfig-f002-20200204
x86_64               randconfig-f003-20200204
i386                 randconfig-f001-20200204
i386                 randconfig-f002-20200204
i386                 randconfig-f003-20200204
x86_64               randconfig-g001-20200129
x86_64               randconfig-g002-20200129
x86_64               randconfig-g003-20200129
i386                 randconfig-g001-20200129
i386                 randconfig-g002-20200129
i386                 randconfig-g003-20200129
x86_64               randconfig-g001-20200205
x86_64               randconfig-g002-20200205
x86_64               randconfig-g003-20200205
i386                 randconfig-g001-20200205
i386                 randconfig-g002-20200205
i386                 randconfig-g003-20200205
x86_64               randconfig-g001-20200202
x86_64               randconfig-g002-20200202
x86_64               randconfig-g003-20200202
i386                 randconfig-g001-20200202
i386                 randconfig-g002-20200202
i386                 randconfig-g003-20200202
x86_64               randconfig-h001-20200204
x86_64               randconfig-h002-20200204
x86_64               randconfig-h003-20200204
i386                 randconfig-h001-20200204
i386                 randconfig-h002-20200204
i386                 randconfig-h003-20200204
arc                  randconfig-a001-20200204
arm                  randconfig-a001-20200204
arm64                randconfig-a001-20200204
ia64                 randconfig-a001-20200204
powerpc              randconfig-a001-20200204
sparc                randconfig-a001-20200204
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
sparc                               defconfig
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
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
