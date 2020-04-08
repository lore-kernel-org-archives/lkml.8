Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42746C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12878206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgDHUXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:23:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:1753 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgDHUXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:23:15 -0400
IronPort-SDR: hddEMPoyI4RZDre3uzselfBdGCNBlEkGOsh3gt+2JCaIj8W/W23l0IQr1+9zD/ravwcTLvLs6I
 nlAJsp5bOexg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 13:23:14 -0700
IronPort-SDR: oNiI2qCReI8/8IoJip/SrNSensKgUAJ5s7+49fxle9m3+mYpRXtFv4DbyyKQXP/W01JKAsTXwC
 g0ZeMbmSMwzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="254437308"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Apr 2020 13:23:13 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jMHE8-000CP3-JT; Thu, 09 Apr 2020 04:23:12 +0800
Date:   Thu, 09 Apr 2020 04:22:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 9a019db0b6bebc84d6b64636faf73ed6d64cd4bb
Message-ID: <5e8e3278.QVIQ8DNEFtpxxAKx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/urgent
branch HEAD: 9a019db0b6bebc84d6b64636faf73ed6d64cd4bb  locking/lockdep: Improve 'invalid wait context' splat

elapsed time: 481m

configs tested: 149
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
s390                          debug_defconfig
parisc                generic-32bit_defconfig
nios2                         3c120_defconfig
s390                             alldefconfig
openrisc                    or1ksim_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
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
x86_64               randconfig-a001-20200408
x86_64               randconfig-a002-20200408
x86_64               randconfig-a003-20200408
i386                 randconfig-a001-20200408
i386                 randconfig-a002-20200408
i386                 randconfig-a003-20200408
alpha                randconfig-a001-20200408
m68k                 randconfig-a001-20200408
mips                 randconfig-a001-20200408
nds32                randconfig-a001-20200408
parisc               randconfig-a001-20200408
riscv                randconfig-a001-20200408
c6x                  randconfig-a001-20200408
h8300                randconfig-a001-20200408
microblaze           randconfig-a001-20200408
nios2                randconfig-a001-20200408
sparc64              randconfig-a001-20200408
csky                 randconfig-a001-20200408
openrisc             randconfig-a001-20200408
s390                 randconfig-a001-20200408
sh                   randconfig-a001-20200408
xtensa               randconfig-a001-20200408
x86_64               randconfig-b001-20200408
x86_64               randconfig-b002-20200408
x86_64               randconfig-b003-20200408
i386                 randconfig-b001-20200408
i386                 randconfig-b002-20200408
i386                 randconfig-b003-20200408
x86_64               randconfig-c001-20200408
x86_64               randconfig-c002-20200408
x86_64               randconfig-c003-20200408
i386                 randconfig-c001-20200408
i386                 randconfig-c002-20200408
i386                 randconfig-c003-20200408
x86_64               randconfig-d001-20200408
x86_64               randconfig-d002-20200408
x86_64               randconfig-d003-20200408
i386                 randconfig-d001-20200408
i386                 randconfig-d002-20200408
i386                 randconfig-d003-20200408
x86_64               randconfig-e001-20200408
x86_64               randconfig-e002-20200408
x86_64               randconfig-e003-20200408
i386                 randconfig-e001-20200408
i386                 randconfig-e002-20200408
i386                 randconfig-e003-20200408
x86_64               randconfig-h001-20200408
x86_64               randconfig-h002-20200408
x86_64               randconfig-h003-20200408
i386                 randconfig-h001-20200408
i386                 randconfig-h002-20200408
i386                 randconfig-h003-20200408
arc                  randconfig-a001-20200408
arm                  randconfig-a001-20200408
arm64                randconfig-a001-20200408
ia64                 randconfig-a001-20200408
powerpc              randconfig-a001-20200408
sparc                randconfig-a001-20200408
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
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
