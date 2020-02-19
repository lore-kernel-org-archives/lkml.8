Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242BBC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E040A20801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgBSRj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:39:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:40792 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgBSRj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:39:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 09:39:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,461,1574150400"; 
   d="scan'208";a="254169055"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Feb 2020 09:39:25 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j4TJl-000AES-08; Thu, 20 Feb 2020 01:39:25 +0800
Date:   Thu, 20 Feb 2020 01:38:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.02.15b] BUILD REGRESSION
 163cebf16e83ee2e6494976e396ab1a8f8aa9b17
Message-ID: <5e4d72af.Gwpz8H0VOESp1FkR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.02.15b
branch HEAD: 163cebf16e83ee2e6494976e396ab1a8f8aa9b17  rcu: Don't use negative nesting depth in __rcu_read_unlock()

Regressions in current branch:

kernel/rcu/tree_plugin.h:396:2: error: expected identifier or '(' before 'if'
kernel/rcu/tree_plugin.h:401:1: error: expected identifier or '(' before '}' token

Error ids grouped by kconfigs:

recent_errors
|-- arc-defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arc-randconfig-a001-20200219
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-am200epdkit_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-efm32_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-exynos_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-imx_v4_v5_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-keystone_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-lpc32xx_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-magician_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-multi_v5_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-mvebu_v5_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-pxa3xx_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-pxa910_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-qcom_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-s5pv210_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm-tegra_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm64-defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- arm64-mt7622_bpi-r64_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- i386-randconfig-a001-20200218
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- i386-randconfig-c002-20200218
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- i386-randconfig-c002-20200219
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- i386-randconfig-d002-20200218
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- i386-randconfig-e002-20200219
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- i386-randconfig-f001-20200218
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- i386-randconfig-f002-20200219
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- i386-randconfig-g002-20200218
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- i386-randconfig-h001-20200219
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- i386-randconfig-h003-20200218
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- i386-randconfig-h003-20200219
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- ia64-randconfig-a001-20200219
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- nds32-defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- parisc-randconfig-a001-20200219
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- s390-debug_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- sh-se7206_defconfig
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- x86_64-randconfig-a002-20200218
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- x86_64-randconfig-a003-20200218
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- x86_64-randconfig-b001-20200219
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- x86_64-randconfig-b002-20200218
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- x86_64-randconfig-b002-20200219
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- x86_64-randconfig-b003-20200219
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- x86_64-randconfig-d002-20200219
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- x86_64-randconfig-e002-20200219
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- x86_64-randconfig-e003-20200218
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- x86_64-randconfig-f001-20200219
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
|-- x86_64-randconfig-f002-20200218
|   |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
|   `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token
`-- x86_64-randconfig-g003-20200218
    |-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-if
    `-- kernel-rcu-tree_plugin.h:error:expected-identifier-or-(-before-token

elapsed time: 2883m

configs tested: 209
configs skipped: 0

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
s390                       zfcpdump_defconfig
riscv                            allyesconfig
microblaze                    nommu_defconfig
m68k                           sun3_defconfig
parisc                generic-32bit_defconfig
riscv                    nommu_virt_defconfig
h8300                    h8300h-sim_defconfig
riscv                               defconfig
csky                                defconfig
s390                             allmodconfig
nds32                               defconfig
parisc                generic-64bit_defconfig
s390                          debug_defconfig
sh                  sh7785lcr_32bit_defconfig
alpha                               defconfig
mips                              allnoconfig
i386                              allnoconfig
mips                             allmodconfig
mips                      malta_kvm_defconfig
i386                             allyesconfig
i386                             alldefconfig
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
nds32                             allnoconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200218
x86_64               randconfig-a002-20200218
x86_64               randconfig-a003-20200218
i386                 randconfig-a001-20200218
i386                 randconfig-a002-20200218
i386                 randconfig-a003-20200218
x86_64               randconfig-a001-20200219
x86_64               randconfig-a002-20200219
x86_64               randconfig-a003-20200219
i386                 randconfig-a001-20200219
i386                 randconfig-a002-20200219
i386                 randconfig-a003-20200219
alpha                randconfig-a001-20200219
m68k                 randconfig-a001-20200219
nds32                randconfig-a001-20200219
parisc               randconfig-a001-20200219
c6x                  randconfig-a001-20200219
h8300                randconfig-a001-20200219
microblaze           randconfig-a001-20200219
nios2                randconfig-a001-20200219
sparc64              randconfig-a001-20200219
csky                 randconfig-a001-20200219
openrisc             randconfig-a001-20200219
s390                 randconfig-a001-20200219
xtensa               randconfig-a001-20200219
x86_64               randconfig-b001-20200218
x86_64               randconfig-b002-20200218
x86_64               randconfig-b003-20200218
i386                 randconfig-b001-20200218
i386                 randconfig-b002-20200218
i386                 randconfig-b003-20200218
x86_64               randconfig-b001-20200219
x86_64               randconfig-b002-20200219
x86_64               randconfig-b003-20200219
i386                 randconfig-b001-20200219
i386                 randconfig-b002-20200219
i386                 randconfig-b003-20200219
x86_64               randconfig-c001-20200219
x86_64               randconfig-c002-20200219
x86_64               randconfig-c003-20200219
i386                 randconfig-c001-20200219
i386                 randconfig-c002-20200219
i386                 randconfig-c003-20200219
x86_64               randconfig-c001-20200218
x86_64               randconfig-c002-20200218
x86_64               randconfig-c003-20200218
i386                 randconfig-c001-20200218
i386                 randconfig-c002-20200218
i386                 randconfig-c003-20200218
x86_64               randconfig-d001-20200218
x86_64               randconfig-d002-20200218
x86_64               randconfig-d003-20200218
i386                 randconfig-d001-20200218
i386                 randconfig-d002-20200218
i386                 randconfig-d003-20200218
x86_64               randconfig-d001-20200219
x86_64               randconfig-d002-20200219
x86_64               randconfig-d003-20200219
i386                 randconfig-d001-20200219
i386                 randconfig-d002-20200219
i386                 randconfig-d003-20200219
x86_64               randconfig-e001-20200219
x86_64               randconfig-e002-20200219
x86_64               randconfig-e003-20200219
i386                 randconfig-e001-20200219
i386                 randconfig-e002-20200219
i386                 randconfig-e003-20200219
x86_64               randconfig-e001-20200218
x86_64               randconfig-e002-20200218
x86_64               randconfig-e003-20200218
i386                 randconfig-e001-20200218
i386                 randconfig-e002-20200218
i386                 randconfig-e003-20200218
x86_64               randconfig-f001-20200218
x86_64               randconfig-f002-20200218
x86_64               randconfig-f003-20200218
i386                 randconfig-f001-20200218
i386                 randconfig-f002-20200218
i386                 randconfig-f003-20200218
x86_64               randconfig-f001-20200219
x86_64               randconfig-f002-20200219
x86_64               randconfig-f003-20200219
i386                 randconfig-f001-20200219
i386                 randconfig-f002-20200219
i386                 randconfig-f003-20200219
x86_64               randconfig-g001-20200218
x86_64               randconfig-g002-20200218
x86_64               randconfig-g003-20200218
i386                 randconfig-g001-20200218
i386                 randconfig-g002-20200218
i386                 randconfig-g003-20200218
x86_64               randconfig-h001-20200218
x86_64               randconfig-h002-20200218
x86_64               randconfig-h003-20200218
i386                 randconfig-h001-20200218
i386                 randconfig-h002-20200218
i386                 randconfig-h003-20200218
x86_64               randconfig-h001-20200219
x86_64               randconfig-h002-20200219
x86_64               randconfig-h003-20200219
i386                 randconfig-h001-20200219
i386                 randconfig-h002-20200219
i386                 randconfig-h003-20200219
arc                  randconfig-a001-20200218
arm                  randconfig-a001-20200218
arm64                randconfig-a001-20200218
ia64                 randconfig-a001-20200218
powerpc              randconfig-a001-20200218
sparc                randconfig-a001-20200218
arc                  randconfig-a001-20200219
arm                  randconfig-a001-20200219
arm64                randconfig-a001-20200219
ia64                 randconfig-a001-20200219
powerpc              randconfig-a001-20200219
sparc                randconfig-a001-20200219
riscv                            allmodconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                              allnoconfig
s390                             allyesconfig
s390                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
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
