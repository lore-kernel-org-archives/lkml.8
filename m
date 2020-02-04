Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8667CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594482082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgBDKzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:55:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:5374 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgBDKzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:55:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 02:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,401,1574150400"; 
   d="scan'208";a="263796497"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2020 02:55:46 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iyvrt-000I6Q-J1; Tue, 04 Feb 2020 18:55:45 +0800
Date:   Tue, 04 Feb 2020 18:55:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.01.24a] BUILD SUCCESS
 1f24afba500958f147e76f07e22e5771493cd6f9
Message-ID: <5e394d99.7pLNKonGMNtp5O6f%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.01.24a
branch HEAD: 1f24afba500958f147e76f07e22e5771493cd6f9  squash! rcutorture: Suppress forward-progress complaints during early boot

elapsed time: 7953m

configs tested: 157
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                         at91_dt_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allmodconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
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
arc                                 defconfig
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
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64               randconfig-a001-20200130
x86_64               randconfig-a002-20200130
x86_64               randconfig-a003-20200130
i386                 randconfig-a001-20200130
i386                 randconfig-a002-20200130
i386                 randconfig-a003-20200130
c6x                  randconfig-a001-20200130
h8300                randconfig-a001-20200130
microblaze           randconfig-a001-20200130
nios2                randconfig-a001-20200130
sparc64              randconfig-a001-20200130
csky                 randconfig-a001-20200129
openrisc             randconfig-a001-20200129
s390                 randconfig-a001-20200129
sh                   randconfig-a001-20200129
xtensa               randconfig-a001-20200129
sh                   randconfig-a001-20200203
s390                 randconfig-a001-20200203
csky                 randconfig-a001-20200203
xtensa               randconfig-a001-20200203
openrisc             randconfig-a001-20200203
x86_64               randconfig-b001-20200129
x86_64               randconfig-b002-20200129
x86_64               randconfig-b003-20200129
i386                 randconfig-b001-20200129
i386                 randconfig-b002-20200129
i386                 randconfig-b003-20200129
x86_64               randconfig-c001-20200129
x86_64               randconfig-c002-20200129
x86_64               randconfig-c003-20200129
i386                 randconfig-c001-20200129
i386                 randconfig-c002-20200129
i386                 randconfig-c003-20200129
x86_64               randconfig-d001-20200130
x86_64               randconfig-d002-20200130
x86_64               randconfig-d003-20200130
i386                 randconfig-d001-20200130
i386                 randconfig-d002-20200130
i386                 randconfig-d003-20200130
x86_64               randconfig-e001-20200129
x86_64               randconfig-e002-20200129
x86_64               randconfig-e003-20200129
i386                 randconfig-e001-20200129
i386                 randconfig-e002-20200129
i386                 randconfig-e003-20200129
x86_64               randconfig-g001-20200129
x86_64               randconfig-g002-20200129
x86_64               randconfig-g003-20200129
i386                 randconfig-g001-20200129
i386                 randconfig-g002-20200129
i386                 randconfig-g003-20200129
x86_64               randconfig-h001-20200129
x86_64               randconfig-h002-20200129
x86_64               randconfig-h003-20200129
i386                 randconfig-h001-20200129
i386                 randconfig-h002-20200129
i386                 randconfig-h003-20200129
arc                  randconfig-a001-20200203
ia64                 randconfig-a001-20200203
sparc                randconfig-a001-20200203
arm64                randconfig-a001-20200203
arm                  randconfig-a001-20200203
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
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
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
