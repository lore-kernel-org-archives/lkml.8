Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C822C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 01:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D10D2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 01:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgCaB2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 21:28:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:18110 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbgCaB2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 21:28:43 -0400
IronPort-SDR: gWb37o6JyiBwPiUhTC6q6jxPCNPYCsoji62WMPgxZJgKLMwAKIn+tKE9pzbzRjm2mOl2iUVH8w
 dEBR81Godhdw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 18:28:42 -0700
IronPort-SDR: FCJQvFXU5lUHFAZeNaNc28Zjj57PGvKNKm7wCh8sGjiPEVZT2f0Pc8Xa+85pDW/GHatdJkee+3
 Tb/Rzs69wicg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,326,1580803200"; 
   d="scan'208";a="272572115"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2020 18:28:41 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jJ5ho-0007O8-QH; Tue, 31 Mar 2020 09:28:40 +0800
Date:   Tue, 31 Mar 2020 09:28:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu-trace-v5.6] BUILD SUCCESS
 a3f1e387f80965242f5ebeb2972ec37c7296c747
Message-ID: <5e829cbb.zm51KP88NmJo6lQ4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu-trace-v5.6
branch HEAD: a3f1e387f80965242f5ebeb2972ec37c7296c747  rcutorture: Add test of holding scheduler locks across rcu_read_unlock()

elapsed time: 483m

configs tested: 185
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                            allyesconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
powerpc                             defconfig
arm64                             allnoconfig
i386                             allyesconfig
i386                             alldefconfig
ia64                                defconfig
s390                             alldefconfig
xtensa                          iss_defconfig
i386                              allnoconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
powerpc                          rhel-kconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                       ppc64_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
parisc                            allnoconfig
x86_64               randconfig-a001-20200330
x86_64               randconfig-a002-20200330
x86_64               randconfig-a003-20200330
i386                 randconfig-a001-20200330
i386                 randconfig-a002-20200330
i386                 randconfig-a003-20200330
alpha                randconfig-a001-20200330
m68k                 randconfig-a001-20200330
nds32                randconfig-a001-20200330
parisc               randconfig-a001-20200330
riscv                randconfig-a001-20200330
mips                 randconfig-a001-20200330
microblaze           randconfig-a001-20200331
h8300                randconfig-a001-20200331
nios2                randconfig-a001-20200331
c6x                  randconfig-a001-20200331
sparc64              randconfig-a001-20200331
c6x                  randconfig-a001-20200330
h8300                randconfig-a001-20200330
microblaze           randconfig-a001-20200330
nios2                randconfig-a001-20200330
sparc64              randconfig-a001-20200330
csky                 randconfig-a001-20200330
s390                 randconfig-a001-20200330
openrisc             randconfig-a001-20200330
sh                   randconfig-a001-20200330
xtensa               randconfig-a001-20200330
csky                 randconfig-a001-20200331
openrisc             randconfig-a001-20200331
s390                 randconfig-a001-20200331
sh                   randconfig-a001-20200331
xtensa               randconfig-a001-20200331
x86_64               randconfig-b001-20200330
x86_64               randconfig-b002-20200330
x86_64               randconfig-b003-20200330
i386                 randconfig-b001-20200330
i386                 randconfig-b002-20200330
i386                 randconfig-b003-20200330
x86_64               randconfig-c001-20200330
x86_64               randconfig-c002-20200330
x86_64               randconfig-c003-20200330
i386                 randconfig-c001-20200330
i386                 randconfig-c002-20200330
i386                 randconfig-c003-20200330
i386                 randconfig-d003-20200330
i386                 randconfig-d001-20200330
i386                 randconfig-d002-20200330
x86_64               randconfig-d001-20200330
x86_64               randconfig-d003-20200330
x86_64               randconfig-d002-20200330
x86_64               randconfig-d001-20200331
x86_64               randconfig-d002-20200331
x86_64               randconfig-d003-20200331
i386                 randconfig-d001-20200331
i386                 randconfig-d002-20200331
i386                 randconfig-d003-20200331
x86_64               randconfig-e001-20200330
x86_64               randconfig-e002-20200330
x86_64               randconfig-e003-20200330
i386                 randconfig-e001-20200330
i386                 randconfig-e002-20200330
i386                 randconfig-e003-20200330
x86_64               randconfig-f001-20200331
x86_64               randconfig-f002-20200331
x86_64               randconfig-f003-20200331
i386                 randconfig-f001-20200331
i386                 randconfig-f002-20200331
i386                 randconfig-f003-20200331
x86_64               randconfig-f001-20200330
x86_64               randconfig-f002-20200330
x86_64               randconfig-f003-20200330
i386                 randconfig-f001-20200330
i386                 randconfig-f002-20200330
i386                 randconfig-f003-20200330
x86_64               randconfig-g001-20200330
x86_64               randconfig-g002-20200330
x86_64               randconfig-g003-20200330
i386                 randconfig-g001-20200330
i386                 randconfig-g002-20200330
i386                 randconfig-g003-20200330
x86_64               randconfig-h001-20200330
x86_64               randconfig-h002-20200330
x86_64               randconfig-h003-20200330
i386                 randconfig-h001-20200330
i386                 randconfig-h002-20200330
i386                 randconfig-h003-20200330
arc                  randconfig-a001-20200330
arm                  randconfig-a001-20200330
arm64                randconfig-a001-20200330
ia64                 randconfig-a001-20200330
powerpc              randconfig-a001-20200330
sparc                randconfig-a001-20200330
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                                defconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
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
