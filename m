Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9426FC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7712A214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgD0TK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:10:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:53128 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgD0TK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:10:56 -0400
IronPort-SDR: 8gt3OIBenhBxuVnxAEQsaddsMDVjEHTSWprjxriuCmZWWjvioawsQbnzRh3ntv8jD1XbF+/FWF
 XYFfEdfA/SeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 12:10:55 -0700
IronPort-SDR: LPeFoGkj26QoBoEPmlhoWEyn+1+68gfpjfC9nhZGmvywJ/0M7jFen537nA1XoSjfa8SXbRNWFN
 dK8l3UkGZjag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="248957715"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Apr 2020 12:10:54 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jT99Z-0008r5-KN; Tue, 28 Apr 2020 03:10:53 +0800
Date:   Tue, 28 Apr 2020 03:10:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 23b5ae2e8e1326c91b5dfdbb6ebcd5a6820074ae
Message-ID: <5ea72e29.Q6/G6M8tnHQnWlJd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/core
branch HEAD: 23b5ae2e8e1326c91b5dfdbb6ebcd5a6820074ae  locking/rtmutex: Remove unused rt_mutex_cmpxchg_relaxed()

elapsed time: 503m

configs tested: 170
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
powerpc                             defconfig
ia64                                defconfig
i386                             alldefconfig
h8300                    h8300h-sim_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
i386                                defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                              allnoconfig
ia64                        generic_defconfig
ia64                          tiger_defconfig
ia64                         bigsur_defconfig
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
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
mips                malta_kvm_guest_defconfig
mips                         tb0287_defconfig
mips                       capcella_defconfig
mips                           ip32_defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                          ath79_defconfig
mips                        bcm63xx_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
parisc                           allmodconfig
parisc               randconfig-a001-20200427
alpha                randconfig-a001-20200427
mips                 randconfig-a001-20200427
m68k                 randconfig-a001-20200427
riscv                randconfig-a001-20200427
nds32                randconfig-a001-20200427
nios2                randconfig-a001-20200427
c6x                  randconfig-a001-20200427
h8300                randconfig-a001-20200427
sparc64              randconfig-a001-20200427
microblaze           randconfig-a001-20200427
sh                   randconfig-a001-20200427
csky                 randconfig-a001-20200427
xtensa               randconfig-a001-20200427
openrisc             randconfig-a001-20200427
i386                 randconfig-b002-20200427
x86_64               randconfig-b001-20200427
i386                 randconfig-b001-20200427
i386                 randconfig-b003-20200427
x86_64               randconfig-b002-20200427
x86_64               randconfig-b003-20200427
i386                 randconfig-c002-20200427
i386                 randconfig-c001-20200427
x86_64               randconfig-c002-20200427
x86_64               randconfig-c001-20200427
i386                 randconfig-c003-20200427
x86_64               randconfig-c003-20200427
i386                 randconfig-a003-20200427
i386                 randconfig-a001-20200427
i386                 randconfig-a002-20200427
x86_64               randconfig-a002-20200427
x86_64               randconfig-d001-20200427
x86_64               randconfig-d002-20200427
i386                 randconfig-d002-20200427
i386                 randconfig-d001-20200427
x86_64               randconfig-d003-20200427
i386                 randconfig-d003-20200427
i386                 randconfig-e003-20200427
x86_64               randconfig-e002-20200427
x86_64               randconfig-e003-20200427
i386                 randconfig-e002-20200427
i386                 randconfig-e001-20200427
x86_64               randconfig-e001-20200427
x86_64               randconfig-f002-20200427
i386                 randconfig-f002-20200427
i386                 randconfig-f003-20200427
i386                 randconfig-f001-20200427
i386                 randconfig-g003-20200427
i386                 randconfig-g001-20200427
x86_64               randconfig-g001-20200427
i386                 randconfig-g002-20200427
x86_64               randconfig-g003-20200427
i386                 randconfig-h003-20200427
x86_64               randconfig-h002-20200427
i386                 randconfig-h002-20200427
i386                 randconfig-h001-20200427
sparc                randconfig-a001-20200427
ia64                 randconfig-a001-20200427
arm                  randconfig-a001-20200427
arm64                randconfig-a001-20200427
arc                  randconfig-a001-20200427
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
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
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
