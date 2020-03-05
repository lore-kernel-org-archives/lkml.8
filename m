Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9BEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4C32146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgCEFtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:49:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:61611 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgCEFtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:49:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 21:49:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574150400"; 
   d="scan'208";a="240696692"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Mar 2020 21:49:10 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j9jNd-000J0u-BO; Thu, 05 Mar 2020 13:49:09 +0800
Date:   Thu, 05 Mar 2020 13:48:44 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.02.27a] BUILD SUCCESS
 e19cea56dc1dae146c7f347c9d2d36bc1b2ed9c8
Message-ID: <5e6092bc.m32SGHXcGzB1QKno%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.02.27a
branch HEAD: e19cea56dc1dae146c7f347c9d2d36bc1b2ed9c8  Default enable RCU list lockdep debugging with PROVE_RCU

elapsed time: 5778m

configs tested: 227
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
s390                             alldefconfig
s390                          debug_defconfig
sh                                allnoconfig
parisc                generic-32bit_defconfig
s390                             allyesconfig
nds32                               defconfig
ia64                              allnoconfig
h8300                       h8s-sim_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
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
parisc                           allyesconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200302
x86_64               randconfig-a002-20200302
x86_64               randconfig-a003-20200302
i386                 randconfig-a001-20200302
i386                 randconfig-a002-20200302
i386                 randconfig-a003-20200302
i386                 randconfig-a003-20200301
i386                 randconfig-a001-20200301
x86_64               randconfig-a001-20200301
i386                 randconfig-a002-20200301
x86_64               randconfig-a003-20200301
x86_64               randconfig-a002-20200301
alpha                randconfig-a001-20200302
m68k                 randconfig-a001-20200302
mips                 randconfig-a001-20200302
nds32                randconfig-a001-20200302
parisc               randconfig-a001-20200302
riscv                randconfig-a001-20200302
riscv                randconfig-a001-20200301
alpha                randconfig-a001-20200301
m68k                 randconfig-a001-20200301
mips                 randconfig-a001-20200301
nds32                randconfig-a001-20200301
parisc               randconfig-a001-20200301
sparc64              randconfig-a001-20200301
c6x                  randconfig-a001-20200301
nios2                randconfig-a001-20200301
h8300                randconfig-a001-20200301
c6x                  randconfig-a001-20200302
h8300                randconfig-a001-20200302
microblaze           randconfig-a001-20200302
nios2                randconfig-a001-20200302
sparc64              randconfig-a001-20200302
sh                   randconfig-a001-20200301
openrisc             randconfig-a001-20200301
csky                 randconfig-a001-20200301
s390                 randconfig-a001-20200301
xtensa               randconfig-a001-20200301
csky                 randconfig-a001-20200302
openrisc             randconfig-a001-20200302
s390                 randconfig-a001-20200302
sh                   randconfig-a001-20200302
xtensa               randconfig-a001-20200302
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
x86_64               randconfig-c001-20200302
x86_64               randconfig-c002-20200302
x86_64               randconfig-c003-20200302
i386                 randconfig-c001-20200302
i386                 randconfig-c002-20200302
i386                 randconfig-c003-20200302
i386                 randconfig-c002-20200301
x86_64               randconfig-c003-20200301
i386                 randconfig-c001-20200301
x86_64               randconfig-c002-20200301
i386                 randconfig-c003-20200301
x86_64               randconfig-c001-20200301
x86_64               randconfig-d001-20200302
x86_64               randconfig-d002-20200302
x86_64               randconfig-d003-20200302
i386                 randconfig-d001-20200302
i386                 randconfig-d002-20200302
i386                 randconfig-d003-20200302
i386                 randconfig-d001-20200301
x86_64               randconfig-d003-20200301
x86_64               randconfig-d001-20200301
i386                 randconfig-d003-20200301
i386                 randconfig-d002-20200301
x86_64               randconfig-d002-20200301
i386                 randconfig-e001-20200301
i386                 randconfig-e003-20200301
x86_64               randconfig-e002-20200301
x86_64               randconfig-e001-20200301
i386                 randconfig-e002-20200301
x86_64               randconfig-e003-20200301
x86_64               randconfig-e001-20200302
x86_64               randconfig-e002-20200302
x86_64               randconfig-e003-20200302
i386                 randconfig-e001-20200302
i386                 randconfig-e002-20200302
i386                 randconfig-e003-20200302
i386                 randconfig-f003-20200301
x86_64               randconfig-f001-20200301
i386                 randconfig-f001-20200301
i386                 randconfig-f002-20200301
x86_64               randconfig-f002-20200301
x86_64               randconfig-f003-20200301
x86_64               randconfig-f001-20200302
x86_64               randconfig-f002-20200302
x86_64               randconfig-f003-20200302
i386                 randconfig-f001-20200302
i386                 randconfig-f002-20200302
i386                 randconfig-f003-20200302
x86_64               randconfig-g001-20200302
x86_64               randconfig-g002-20200302
x86_64               randconfig-g003-20200302
i386                 randconfig-g001-20200302
i386                 randconfig-g002-20200302
i386                 randconfig-g003-20200302
i386                 randconfig-g003-20200301
x86_64               randconfig-g003-20200301
i386                 randconfig-g001-20200301
x86_64               randconfig-g001-20200301
x86_64               randconfig-g002-20200301
i386                 randconfig-g002-20200301
i386                 randconfig-h001-20200301
x86_64               randconfig-h002-20200301
x86_64               randconfig-h001-20200301
x86_64               randconfig-h003-20200301
i386                 randconfig-h003-20200301
i386                 randconfig-h002-20200301
x86_64               randconfig-h001-20200302
x86_64               randconfig-h002-20200302
x86_64               randconfig-h003-20200302
i386                 randconfig-h001-20200302
i386                 randconfig-h002-20200302
i386                 randconfig-h003-20200302
arc                  randconfig-a001-20200302
arm                  randconfig-a001-20200302
arm64                randconfig-a001-20200302
ia64                 randconfig-a001-20200302
powerpc              randconfig-a001-20200302
sparc                randconfig-a001-20200302
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                              allnoconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
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
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
