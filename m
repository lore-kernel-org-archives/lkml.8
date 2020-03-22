Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC550C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E87F20724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCVQDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:03:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:39159 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgCVQDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:03:00 -0400
IronPort-SDR: EON68pOvPonYUdWNe3zBc+yt8wMTMH0FeDmMbSRYLML7Lx/sr2KFeR7R6jhFfWsYoxglrEEcG8
 hIde99uRyfHw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:02:58 -0700
IronPort-SDR: ViSR3TJG1Cxn9F/ZaLFWq7+gvwl6jNq8ynTDuwhkkxUKwN6uPi9/JG1YhQNBKbLeKiTXnnzmaP
 x2GQHZEf/VwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,293,1580803200"; 
   d="scan'208";a="419249220"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2020 09:02:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jG33v-000EQl-Ln; Mon, 23 Mar 2020 00:02:55 +0800
Date:   Mon, 23 Mar 2020 00:02:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/test] BUILD SUCCESS
 e19d2829fed163f76ebea82bfd0d305d9e1e258d
Message-ID: <5e778bf8.cJGWdk6Tq+AfZxe8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/test
branch HEAD: e19d2829fed163f76ebea82bfd0d305d9e1e258d  Merge remote-tracking branch 'linus/master' into HEAD

elapsed time: 797m

configs tested: 154
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
sparc                            allyesconfig
ia64                             allmodconfig
arc                              allyesconfig
arm                         at91_dt_defconfig
arm                          exynos_defconfig
arm                           sunxi_defconfig
mips                      fuloong2e_defconfig
arm                        multi_v5_defconfig
h8300                    h8300h-sim_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
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
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200322
x86_64               randconfig-a002-20200322
x86_64               randconfig-a003-20200322
i386                 randconfig-a001-20200322
i386                 randconfig-a002-20200322
i386                 randconfig-a003-20200322
alpha                randconfig-a001-20200322
m68k                 randconfig-a001-20200322
mips                 randconfig-a001-20200322
nds32                randconfig-a001-20200322
parisc               randconfig-a001-20200322
riscv                randconfig-a001-20200322
csky                 randconfig-a001-20200322
openrisc             randconfig-a001-20200322
s390                 randconfig-a001-20200322
sh                   randconfig-a001-20200322
xtensa               randconfig-a001-20200322
i386                 randconfig-b003-20200322
i386                 randconfig-b001-20200322
x86_64               randconfig-b003-20200322
i386                 randconfig-b002-20200322
x86_64               randconfig-b002-20200322
x86_64               randconfig-c001-20200322
x86_64               randconfig-c002-20200322
x86_64               randconfig-c003-20200322
i386                 randconfig-c001-20200322
i386                 randconfig-c002-20200322
i386                 randconfig-c003-20200322
x86_64               randconfig-d001-20200322
x86_64               randconfig-d002-20200322
x86_64               randconfig-d003-20200322
i386                 randconfig-d001-20200322
i386                 randconfig-d002-20200322
i386                 randconfig-d003-20200322
x86_64               randconfig-e001-20200322
x86_64               randconfig-e002-20200322
x86_64               randconfig-e003-20200322
i386                 randconfig-e001-20200322
i386                 randconfig-e002-20200322
i386                 randconfig-e003-20200322
x86_64               randconfig-f001-20200322
x86_64               randconfig-f002-20200322
x86_64               randconfig-f003-20200322
i386                 randconfig-f001-20200322
i386                 randconfig-f002-20200322
i386                 randconfig-f003-20200322
x86_64               randconfig-g001-20200322
x86_64               randconfig-g002-20200322
x86_64               randconfig-g003-20200322
i386                 randconfig-g001-20200322
i386                 randconfig-g002-20200322
i386                 randconfig-g003-20200322
x86_64               randconfig-h001-20200322
x86_64               randconfig-h002-20200322
x86_64               randconfig-h003-20200322
i386                 randconfig-h001-20200322
i386                 randconfig-h002-20200322
i386                 randconfig-h003-20200322
arc                  randconfig-a001-20200322
arm                  randconfig-a001-20200322
arm64                randconfig-a001-20200322
ia64                 randconfig-a001-20200322
powerpc              randconfig-a001-20200322
sparc                randconfig-a001-20200322
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
