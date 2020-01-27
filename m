Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0C9C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A972467B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgA0XG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:06:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:11434 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgA0XG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:06:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 15:05:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,371,1574150400"; 
   d="scan'208";a="277040817"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jan 2020 15:05:47 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iwDRz-000Ij1-C4; Tue, 28 Jan 2020 07:05:47 +0800
Date:   Tue, 28 Jan 2020 07:05:30 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD INCOMPLETE
 59d8cc6b2e375ff486b030da6703b1d481e186e6
Message-ID: <5e2f6cba.b3LtdzF4X+TfTcmx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 59d8cc6b2e375ff486b030da6703b1d481e186e6  rcu: Forgive slow expedited grace periods at boot time

TIMEOUT after 2887m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 21

arm                              allmodconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
mips                         64r6el_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig

configs tested: 129
configs skipped: 1

i386                 randconfig-d003-20200127
i386                 randconfig-e002-20200128
x86_64               randconfig-e002-20200128
i386                 randconfig-e001-20200128
i386                 randconfig-e003-20200128
x86_64               randconfig-e003-20200128
x86_64               randconfig-e001-20200128
x86_64               randconfig-g003-20200127
i386                 randconfig-g003-20200127
i386                 randconfig-g001-20200127
x86_64               randconfig-g001-20200127
i386                 randconfig-g002-20200127
x86_64               randconfig-g002-20200127
i386                              allnoconfig
i386                                defconfig
i386                             allyesconfig
i386                             alldefconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
arm64                randconfig-a001-20200126
ia64                 randconfig-a001-20200126
arm                  randconfig-a001-20200126
arc                  randconfig-a001-20200126
sparc                randconfig-a001-20200126
x86_64               randconfig-c003-20200127
i386                 randconfig-c003-20200127
x86_64               randconfig-c002-20200127
x86_64               randconfig-c001-20200127
i386                 randconfig-c001-20200127
i386                 randconfig-c002-20200127
x86_64               randconfig-b002-20200127
i386                 randconfig-b003-20200127
i386                 randconfig-b001-20200127
i386                 randconfig-b002-20200127
x86_64               randconfig-b001-20200127
x86_64               randconfig-b003-20200127
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
ia64                             alldefconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
mips                             allmodconfig
mips                           32r2_defconfig
mips                             allyesconfig
mips                              allnoconfig
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
sparc64                          allmodconfig
sparc                            allyesconfig
sparc64                          allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
arc                                 defconfig
powerpc                           allnoconfig
s390                              allnoconfig
s390                             alldefconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
i386                 randconfig-a001-20200126
x86_64               randconfig-a001-20200126
x86_64               randconfig-a002-20200126
i386                 randconfig-a002-20200126
i386                 randconfig-a003-20200126
x86_64               randconfig-a003-20200126
openrisc             randconfig-a001-20200127
csky                 randconfig-a001-20200127
xtensa               randconfig-a001-20200127
s390                 randconfig-a001-20200127
sh                   randconfig-a001-20200127
h8300                randconfig-a001-20200127
nios2                randconfig-a001-20200127
c6x                  randconfig-a001-20200127
sparc64              randconfig-a001-20200127
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
riscv                randconfig-a001-20200126
alpha                randconfig-a001-20200126
m68k                 randconfig-a001-20200126
parisc               randconfig-a001-20200126
nds32                randconfig-a001-20200126
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
x86_64                         rhel-7.2-clear
x86_64               randconfig-f003-20200127
x86_64               randconfig-f001-20200127
x86_64               randconfig-f002-20200127
i386                 randconfig-f002-20200127
i386                 randconfig-f003-20200127
i386                 randconfig-f001-20200127
nds32                               defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
