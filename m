Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46A6C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE502051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgCWTM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:12:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:7322 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbgCWTM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:12:26 -0400
IronPort-SDR: Nlhab+YLo89nKwi42Ca1CiKbu+i7FaN95TFu2AryNnbVGSENK/KdO3Pu65sg6l+PIuMTeyibr1
 KxF8zRDle+tQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 12:12:25 -0700
IronPort-SDR: 12XoA8zrSjgnQZGvEA+dYDqw2zhSk3KdsxgcfHQ8P2s62F3MQ0xGuM0RzzdSHDXkytE/+n3Xmz
 p47wXTYIBBmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="249729812"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2020 12:12:23 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jGSUp-000FC4-1a; Tue, 24 Mar 2020 03:12:23 +0800
Date:   Tue, 24 Mar 2020 03:11:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 0e79ad863df43b01090ae18c97de5c3787f069c6
Message-ID: <5e7909ef.EHPWIMJRcSKMsT4C%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 0e79ad863df43b01090ae18c97de5c3787f069c6  x86/cpu: Fix a -Wmissing-prototypes warning for init_ia32_feat_ctl()

elapsed time: 484m

configs tested: 170
configs skipped: 106

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
sparc64                             defconfig
i386                              allnoconfig
ia64                             allyesconfig
riscv                               defconfig
s390                              allnoconfig
ia64                                defconfig
powerpc                             defconfig
arc                              allyesconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
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
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
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
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200323
x86_64               randconfig-a002-20200323
x86_64               randconfig-a003-20200323
i386                 randconfig-a001-20200323
i386                 randconfig-a002-20200323
i386                 randconfig-a003-20200323
x86_64               randconfig-a001-20200322
x86_64               randconfig-a002-20200322
x86_64               randconfig-a003-20200322
i386                 randconfig-a001-20200322
i386                 randconfig-a002-20200322
i386                 randconfig-a003-20200322
alpha                randconfig-a001-20200323
m68k                 randconfig-a001-20200323
mips                 randconfig-a001-20200323
nds32                randconfig-a001-20200323
parisc               randconfig-a001-20200323
c6x                  randconfig-a001-20200323
h8300                randconfig-a001-20200323
microblaze           randconfig-a001-20200323
nios2                randconfig-a001-20200323
sparc64              randconfig-a001-20200323
c6x                  randconfig-a001-20200322
h8300                randconfig-a001-20200322
microblaze           randconfig-a001-20200322
nios2                randconfig-a001-20200322
sparc64              randconfig-a001-20200322
csky                 randconfig-a001-20200323
openrisc             randconfig-a001-20200323
s390                 randconfig-a001-20200323
sh                   randconfig-a001-20200323
xtensa               randconfig-a001-20200323
x86_64               randconfig-b001-20200323
x86_64               randconfig-b002-20200323
x86_64               randconfig-b003-20200323
i386                 randconfig-b001-20200323
i386                 randconfig-b002-20200323
i386                 randconfig-b003-20200323
x86_64               randconfig-c001-20200323
x86_64               randconfig-c002-20200323
x86_64               randconfig-c003-20200323
i386                 randconfig-c001-20200323
i386                 randconfig-c002-20200323
i386                 randconfig-c003-20200323
x86_64               randconfig-d001-20200323
x86_64               randconfig-d002-20200323
x86_64               randconfig-d003-20200323
i386                 randconfig-d001-20200323
i386                 randconfig-d002-20200323
i386                 randconfig-d003-20200323
x86_64               randconfig-e001-20200323
x86_64               randconfig-e002-20200323
x86_64               randconfig-e003-20200323
i386                 randconfig-e001-20200323
i386                 randconfig-e002-20200323
i386                 randconfig-e003-20200323
x86_64               randconfig-f001-20200323
x86_64               randconfig-f002-20200323
x86_64               randconfig-f003-20200323
i386                 randconfig-f001-20200323
i386                 randconfig-f002-20200323
i386                 randconfig-f003-20200323
x86_64               randconfig-g001-20200323
x86_64               randconfig-g002-20200323
x86_64               randconfig-g003-20200323
i386                 randconfig-g001-20200323
i386                 randconfig-g002-20200323
i386                 randconfig-g003-20200323
x86_64               randconfig-h001-20200323
x86_64               randconfig-h002-20200323
x86_64               randconfig-h003-20200323
i386                 randconfig-h001-20200323
i386                 randconfig-h002-20200323
i386                 randconfig-h003-20200323
arc                  randconfig-a001-20200323
arm                  randconfig-a001-20200323
arm64                randconfig-a001-20200323
ia64                 randconfig-a001-20200323
powerpc              randconfig-a001-20200323
sparc                randconfig-a001-20200323
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
