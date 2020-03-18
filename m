Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA297C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B847820777
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCRVNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:13:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:16234 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRVNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:13:42 -0400
IronPort-SDR: 1afHXWylspGnHMAiDgSwnhYxxmqsT9BOXp1UbVfPa9K/GevnGEWNdEntLE8X3z5KtrLzzI4OWp
 mv999VhxJ9Yg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 14:13:41 -0700
IronPort-SDR: K6lBN/lGkJmaHbRpCNSbFxqShfgmfVb7/FnsMVhd+MKl5JyYZNBUg6STTd4QzWpiB05LpQiojV
 hfGV2TjllezQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,569,1574150400"; 
   d="scan'208";a="233966752"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Mar 2020 14:13:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jEg0R-00018U-7J; Thu, 19 Mar 2020 05:13:39 +0800
Date:   Thu, 19 Mar 2020 05:13:10 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 51565924ebd9dce938be77b1d5601c890075bb3b
Message-ID: <5e728ee6.clmITcSOe9eZEcSr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 51565924ebd9dce938be77b1d5601c890075bb3b  Merge branch 'linus'

elapsed time: 666m

configs tested: 141
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
m68k                             allmodconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
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
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
i386                 randconfig-a003-20200318
i386                 randconfig-a001-20200318
x86_64               randconfig-a001-20200318
x86_64               randconfig-a002-20200318
i386                 randconfig-a002-20200318
x86_64               randconfig-a003-20200318
riscv                randconfig-a001-20200318
m68k                 randconfig-a001-20200318
nds32                randconfig-a001-20200318
alpha                randconfig-a001-20200318
parisc               randconfig-a001-20200318
mips                 randconfig-a001-20200318
h8300                randconfig-a001-20200318
sparc64              randconfig-a001-20200318
c6x                  randconfig-a001-20200318
nios2                randconfig-a001-20200318
microblaze           randconfig-a001-20200318
xtensa               randconfig-a001-20200318
csky                 randconfig-a001-20200318
openrisc             randconfig-a001-20200318
sh                   randconfig-a001-20200318
s390                 randconfig-a001-20200318
x86_64               randconfig-b001-20200318
x86_64               randconfig-b002-20200318
x86_64               randconfig-b003-20200318
i386                 randconfig-b001-20200318
i386                 randconfig-b002-20200318
i386                 randconfig-b003-20200318
x86_64               randconfig-c001-20200318
i386                 randconfig-c001-20200318
x86_64               randconfig-c002-20200318
i386                 randconfig-c003-20200318
x86_64               randconfig-c003-20200318
i386                 randconfig-c002-20200318
x86_64               randconfig-d001-20200318
i386                 randconfig-d001-20200318
i386                 randconfig-d003-20200318
i386                 randconfig-d002-20200318
x86_64               randconfig-d002-20200318
x86_64               randconfig-d003-20200318
x86_64               randconfig-f001-20200318
x86_64               randconfig-f002-20200318
x86_64               randconfig-f003-20200318
i386                 randconfig-f001-20200318
i386                 randconfig-f002-20200318
i386                 randconfig-f003-20200318
x86_64               randconfig-g001-20200318
x86_64               randconfig-g002-20200318
x86_64               randconfig-g003-20200318
i386                 randconfig-g001-20200318
i386                 randconfig-g002-20200318
i386                 randconfig-g003-20200318
arc                  randconfig-a001-20200318
ia64                 randconfig-a001-20200318
arm                  randconfig-a001-20200318
arm64                randconfig-a001-20200318
sparc                randconfig-a001-20200318
powerpc              randconfig-a001-20200318
riscv                          rv32_defconfig
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
