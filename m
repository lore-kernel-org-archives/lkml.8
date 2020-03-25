Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D14C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE95F206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgCYHP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:15:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:37140 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgCYHP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:15:26 -0400
IronPort-SDR: doOGr04Ejd5RbuN4Usg0l+gOiDV+xAMlJ8mkcxwu1A3HfuTMX0nrDBsF226OQfNuOaknDrRopm
 WIaYmDh1jSxQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 00:15:25 -0700
IronPort-SDR: ufgKdX6nZu0I/KT3CbCpizxpZhREsuvarfu9lIgfsESQHJYhcKOyK7w+Gc1xAVVRNj1SvyLgKB
 ctVFCfOXj1Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; 
   d="scan'208";a="293274097"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2020 00:15:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jH0G3-000BAw-UW; Wed, 25 Mar 2020 15:15:23 +0800
Date:   Wed, 25 Mar 2020 15:14:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/vmware] BUILD SUCCESS
 8fefe9dacdb0a1347d3dac871bb1bba3cbc32945
Message-ID: <5e7b04e7.5SosBEfLqhKcTJY7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/vmware
branch HEAD: 8fefe9dacdb0a1347d3dac871bb1bba3cbc32945  x86/vmware: Use bool type for vmw_sched_clock

elapsed time: 732m

configs tested: 163
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
parisc                generic-64bit_defconfig
powerpc                       ppc64_defconfig
s390                             alldefconfig
um                             i386_defconfig
nds32                               defconfig
i386                                defconfig
m68k                       m5475evb_defconfig
sparc                               defconfig
sparc64                             defconfig
i386                             allyesconfig
i386                             alldefconfig
i386                              allnoconfig
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
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
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
x86_64               randconfig-a001-20200324
x86_64               randconfig-a002-20200324
x86_64               randconfig-a003-20200324
i386                 randconfig-a001-20200324
i386                 randconfig-a002-20200324
i386                 randconfig-a003-20200324
alpha                randconfig-a001-20200324
m68k                 randconfig-a001-20200324
mips                 randconfig-a001-20200324
nds32                randconfig-a001-20200324
parisc               randconfig-a001-20200324
riscv                randconfig-a001-20200324
c6x                  randconfig-a001-20200324
h8300                randconfig-a001-20200324
microblaze           randconfig-a001-20200324
nios2                randconfig-a001-20200324
sparc64              randconfig-a001-20200324
csky                 randconfig-a001-20200324
openrisc             randconfig-a001-20200324
s390                 randconfig-a001-20200324
xtensa               randconfig-a001-20200324
sh                   randconfig-a001-20200324
x86_64               randconfig-b001-20200324
x86_64               randconfig-b002-20200324
x86_64               randconfig-b003-20200324
i386                 randconfig-b001-20200324
i386                 randconfig-b002-20200324
i386                 randconfig-b003-20200324
x86_64               randconfig-c001-20200324
x86_64               randconfig-c002-20200324
x86_64               randconfig-c003-20200324
i386                 randconfig-c001-20200324
i386                 randconfig-c002-20200324
i386                 randconfig-c003-20200324
x86_64               randconfig-d001-20200324
x86_64               randconfig-d002-20200324
x86_64               randconfig-d003-20200324
i386                 randconfig-d001-20200324
i386                 randconfig-d002-20200324
i386                 randconfig-d003-20200324
x86_64               randconfig-e001-20200324
x86_64               randconfig-e002-20200324
x86_64               randconfig-e003-20200324
i386                 randconfig-e001-20200324
i386                 randconfig-e002-20200324
i386                 randconfig-e003-20200324
x86_64               randconfig-f001-20200324
x86_64               randconfig-f002-20200324
x86_64               randconfig-f003-20200324
i386                 randconfig-f001-20200324
i386                 randconfig-f002-20200324
i386                 randconfig-f003-20200324
x86_64               randconfig-g001-20200324
x86_64               randconfig-g002-20200324
x86_64               randconfig-g003-20200324
i386                 randconfig-g001-20200324
i386                 randconfig-g002-20200324
i386                 randconfig-g003-20200324
x86_64               randconfig-g001-20200325
x86_64               randconfig-g002-20200325
x86_64               randconfig-g003-20200325
i386                 randconfig-g001-20200325
i386                 randconfig-g002-20200325
i386                 randconfig-g003-20200325
x86_64               randconfig-h001-20200324
x86_64               randconfig-h002-20200324
x86_64               randconfig-h003-20200324
i386                 randconfig-h001-20200324
i386                 randconfig-h002-20200324
i386                 randconfig-h003-20200324
arc                  randconfig-a001-20200324
arm                  randconfig-a001-20200324
arm64                randconfig-a001-20200324
ia64                 randconfig-a001-20200324
powerpc              randconfig-a001-20200324
sparc                randconfig-a001-20200324
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                           x86_64_defconfig
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
