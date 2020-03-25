Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702FBC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4558E20777
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCYSpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:45:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:64344 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbgCYSpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:45:08 -0400
IronPort-SDR: vbw/+O65bJSFkWbgp3TALPN5qQ7YjWytjAuAqZIUu3EOKUfxOhg6iFyI0xQIIzywJOX1f/C5kX
 Z8pMczcXZtUA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 11:45:07 -0700
IronPort-SDR: +2JpBfMSgxJRdsXMqbVx3+2rJ18EuoVFAXyEFeK8SkEdqR6KGszggKiDp1qAclqmtnLI3IOKm/
 i9CNi1IAojuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; 
   d="scan'208";a="446714169"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Mar 2020 11:45:06 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jHB1V-000E8l-PQ; Thu, 26 Mar 2020 02:45:05 +0800
Date:   Thu, 26 Mar 2020 02:44:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 290a4474d019c7e49c186100e157fff5e273ab3b
Message-ID: <5e7ba6ab.AOhPROOgE2Hekqae%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/entry
branch HEAD: 290a4474d019c7e49c186100e157fff5e273ab3b  x86/entry: Fix build error x86 with !CONFIG_POSIX_TIMERS

elapsed time: 483m

configs tested: 164
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
h8300                     edosk2674_defconfig
mips                      malta_kvm_defconfig
mips                             allmodconfig
xtensa                       common_defconfig
microblaze                    nommu_defconfig
s390                                defconfig
h8300                       h8s-sim_defconfig
m68k                           sun3_defconfig
s390                             allyesconfig
csky                                defconfig
sparc64                           allnoconfig
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
xtensa                          iss_defconfig
alpha                               defconfig
nds32                             allnoconfig
nds32                               defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
mips                      fuloong2e_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                             allyesconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200325
x86_64               randconfig-a002-20200325
x86_64               randconfig-a003-20200325
i386                 randconfig-a001-20200325
i386                 randconfig-a002-20200325
i386                 randconfig-a003-20200325
mips                 randconfig-a001-20200325
nds32                randconfig-a001-20200325
m68k                 randconfig-a001-20200325
parisc               randconfig-a001-20200325
alpha                randconfig-a001-20200325
riscv                randconfig-a001-20200325
h8300                randconfig-a001-20200325
nios2                randconfig-a001-20200325
c6x                  randconfig-a001-20200325
sparc64              randconfig-a001-20200325
microblaze           randconfig-a001-20200325
s390                 randconfig-a001-20200325
xtensa               randconfig-a001-20200325
csky                 randconfig-a001-20200325
openrisc             randconfig-a001-20200325
sh                   randconfig-a001-20200325
x86_64               randconfig-b001-20200325
x86_64               randconfig-b002-20200325
x86_64               randconfig-b003-20200325
i386                 randconfig-b001-20200325
i386                 randconfig-b002-20200325
i386                 randconfig-b003-20200325
x86_64               randconfig-c001-20200325
x86_64               randconfig-c002-20200325
x86_64               randconfig-c003-20200325
i386                 randconfig-c001-20200325
i386                 randconfig-c002-20200325
i386                 randconfig-c003-20200325
x86_64               randconfig-d001-20200325
x86_64               randconfig-d002-20200325
x86_64               randconfig-d003-20200325
i386                 randconfig-d001-20200325
i386                 randconfig-d002-20200325
i386                 randconfig-d003-20200325
x86_64               randconfig-e001-20200325
x86_64               randconfig-e002-20200325
x86_64               randconfig-e003-20200325
i386                 randconfig-e001-20200325
i386                 randconfig-e002-20200325
i386                 randconfig-e003-20200325
x86_64               randconfig-f001-20200325
x86_64               randconfig-f002-20200325
x86_64               randconfig-f003-20200325
i386                 randconfig-f001-20200325
i386                 randconfig-f002-20200325
i386                 randconfig-f003-20200325
x86_64               randconfig-g001-20200325
x86_64               randconfig-g002-20200325
x86_64               randconfig-g003-20200325
i386                 randconfig-g001-20200325
i386                 randconfig-g002-20200325
i386                 randconfig-g003-20200325
x86_64               randconfig-h001-20200325
x86_64               randconfig-h002-20200325
x86_64               randconfig-h003-20200325
i386                 randconfig-h001-20200325
i386                 randconfig-h002-20200325
i386                 randconfig-h003-20200325
arc                  randconfig-a001-20200325
arm                  randconfig-a001-20200325
arm64                randconfig-a001-20200325
ia64                 randconfig-a001-20200325
powerpc              randconfig-a001-20200325
sparc                randconfig-a001-20200325
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
