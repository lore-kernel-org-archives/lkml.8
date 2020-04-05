Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991C2C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 00:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603D120739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 00:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDEAgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 20:36:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:41028 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgDEAgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 20:36:33 -0400
IronPort-SDR: loZeyCuccoFaoDUpx7OCHdcGlcIAAiaKxlKVvMcA7N5zTTQA6DW3aYjJOW6MPLnZ5q6fdapYkF
 s8MKaCXowzYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2020 17:36:32 -0700
IronPort-SDR: qiaQn/L8q0jTVK10nfNPIrey6v45gv9jvjok5trc8SEjiYrKXfkVgodsiL1ak0S41sdL0f4QcE
 2/5MWROO5Crw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,345,1580803200"; 
   d="scan'208";a="253731755"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2020 17:36:30 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKtH4-00030L-5D; Sun, 05 Apr 2020 08:36:30 +0800
Date:   Sun, 05 Apr 2020 08:36:10 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 7dc41b9b99cd0037a418ac47e342d56a438df649
Message-ID: <5e8927fa.WVljxzvo4V++SuMo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/urgent
branch HEAD: 7dc41b9b99cd0037a418ac47e342d56a438df649  Merge tag 'perf-urgent-for-mingo-5.7-20200403' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

elapsed time: 957m

configs tested: 124
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
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
i386                 randconfig-a002-20200404
x86_64               randconfig-a002-20200404
x86_64               randconfig-a001-20200404
i386                 randconfig-a001-20200404
i386                 randconfig-a003-20200404
mips                 randconfig-a001-20200404
nds32                randconfig-a001-20200404
m68k                 randconfig-a001-20200404
parisc               randconfig-a001-20200404
alpha                randconfig-a001-20200404
riscv                randconfig-a001-20200404
sparc64              randconfig-a001-20200404
h8300                randconfig-a001-20200404
nios2                randconfig-a001-20200404
microblaze           randconfig-a001-20200404
c6x                  randconfig-a001-20200404
i386                 randconfig-c003-20200404
i386                 randconfig-c001-20200404
x86_64               randconfig-c002-20200404
x86_64               randconfig-c003-20200404
i386                 randconfig-c002-20200404
x86_64               randconfig-c001-20200404
i386                 randconfig-f001-20200404
x86_64               randconfig-f003-20200404
i386                 randconfig-f003-20200404
x86_64               randconfig-f002-20200404
i386                 randconfig-f002-20200404
arm64                randconfig-a001-20200404
sparc                randconfig-a001-20200404
ia64                 randconfig-a001-20200404
arc                  randconfig-a001-20200404
arm                  randconfig-a001-20200404
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
sparc                            allyesconfig
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
