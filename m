Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A09C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C676020674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbgCPTPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:15:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:28320 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732298AbgCPTPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 15:15:19 -0400
IronPort-SDR: c1FbiCFViZYm+fZ54f8oLPRRdXM7ndOWlbSYCRp3oj481YxWrYCBxPu5dhcBRKEed6I5JAK8GJ
 +oq+sJunK4+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 12:15:18 -0700
IronPort-SDR: zr2HA6jfFi3z9/IfmBSiXAu3LfPgttYzVNziSRuGH2FU7sF1HGmfSAE+yLI0O6Tkm1ZtaHSb1x
 N2cIH2eCCF0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="390808662"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2020 12:15:17 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jDvCm-0003Q0-Go; Tue, 17 Mar 2020 03:15:16 +0800
Date:   Tue, 17 Mar 2020 03:15:06 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 c5bac160f2befdea8c2f70908be94151449aee7f
Message-ID: <5e6fd03a.3AgcwWKzcNmftm0M%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: c5bac160f2befdea8c2f70908be94151449aee7f  fixup! rcutorture: Add torture tests for RCU Tasks Trace

elapsed time: 712m

configs tested: 158
configs skipped: 0

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
riscv                               defconfig
mips                      malta_kvm_defconfig
m68k                       m5475evb_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                           sun3_defconfig
parisc                           allyesconfig
sh                            titan_defconfig
powerpc                       ppc64_defconfig
sh                                allnoconfig
um                                  defconfig
sparc                               defconfig
powerpc                           allnoconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
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
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
parisc                            allnoconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200316
x86_64               randconfig-a002-20200316
x86_64               randconfig-a003-20200316
i386                 randconfig-a001-20200316
i386                 randconfig-a002-20200316
i386                 randconfig-a003-20200316
alpha                randconfig-a001-20200316
m68k                 randconfig-a001-20200316
mips                 randconfig-a001-20200316
nds32                randconfig-a001-20200316
parisc               randconfig-a001-20200316
riscv                randconfig-a001-20200316
c6x                  randconfig-a001-20200316
h8300                randconfig-a001-20200316
microblaze           randconfig-a001-20200316
nios2                randconfig-a001-20200316
sparc64              randconfig-a001-20200316
csky                 randconfig-a001-20200316
openrisc             randconfig-a001-20200316
s390                 randconfig-a001-20200316
sh                   randconfig-a001-20200316
xtensa               randconfig-a001-20200316
x86_64               randconfig-b001-20200316
x86_64               randconfig-b002-20200316
x86_64               randconfig-b003-20200316
i386                 randconfig-b001-20200316
i386                 randconfig-b002-20200316
i386                 randconfig-b003-20200316
x86_64               randconfig-d001-20200316
x86_64               randconfig-d002-20200316
x86_64               randconfig-d003-20200316
i386                 randconfig-d001-20200316
i386                 randconfig-d002-20200316
i386                 randconfig-d003-20200316
x86_64               randconfig-e001-20200316
x86_64               randconfig-e002-20200316
x86_64               randconfig-e003-20200316
i386                 randconfig-e001-20200316
i386                 randconfig-e002-20200316
i386                 randconfig-e003-20200316
x86_64               randconfig-f001-20200316
x86_64               randconfig-f002-20200316
x86_64               randconfig-f003-20200316
i386                 randconfig-f001-20200316
i386                 randconfig-f002-20200316
i386                 randconfig-f003-20200316
x86_64               randconfig-g001-20200316
x86_64               randconfig-g002-20200316
x86_64               randconfig-g003-20200316
i386                 randconfig-g001-20200316
i386                 randconfig-g002-20200316
i386                 randconfig-g003-20200316
x86_64               randconfig-h001-20200316
x86_64               randconfig-h002-20200316
x86_64               randconfig-h003-20200316
i386                 randconfig-h001-20200316
i386                 randconfig-h002-20200316
i386                 randconfig-h003-20200316
arc                  randconfig-a001-20200316
arm                  randconfig-a001-20200316
arm64                randconfig-a001-20200316
ia64                 randconfig-a001-20200316
powerpc              randconfig-a001-20200316
sparc                randconfig-a001-20200316
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
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                           x86_64_defconfig
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
