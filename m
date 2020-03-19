Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BEFC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DD92076E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCSWIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:08:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:62688 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgCSWIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:08:06 -0400
IronPort-SDR: n70nsZVUn99SuX6ZLTuKnMvtZd4F+X04gu+FbwCBFA2ebeoE80AXcwB8EwarJYV7oS7AdtMcRK
 Fg7T/MzRszsg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 15:08:06 -0700
IronPort-SDR: /K4UFAeyFQq8RdMRyqYH63nBs9EihkCCvfJNxqtQQ7B5c569im80Ly+GeNgj79uLYq34MYsWtr
 7BJKYJz7d12g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,573,1574150400"; 
   d="scan'208";a="418507365"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2020 15:08:04 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jF3Kd-0005oQ-RJ; Fri, 20 Mar 2020 06:08:03 +0800
Date:   Fri, 20 Mar 2020 06:07:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 db5d85ce82487331b06ec0e076b85b5a3968bf53
Message-ID: <5e73ed1d.kVFmO2ZjeGdWnDc2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/urgent
branch HEAD: db5d85ce82487331b06ec0e076b85b5a3968bf53  Merge tag 'perf-urgent-for-mingo-5.6-20200309' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

elapsed time: 485m

configs tested: 164
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
s390                          debug_defconfig
s390                                defconfig
arc                              allyesconfig
nds32                               defconfig
s390                              allnoconfig
c6x                              allyesconfig
sparc64                           allnoconfig
ia64                                defconfig
powerpc                             defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
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
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
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
x86_64               randconfig-a001-20200319
x86_64               randconfig-a002-20200319
x86_64               randconfig-a003-20200319
i386                 randconfig-a001-20200319
i386                 randconfig-a002-20200319
i386                 randconfig-a003-20200319
alpha                randconfig-a001-20200319
m68k                 randconfig-a001-20200319
mips                 randconfig-a001-20200319
nds32                randconfig-a001-20200319
parisc               randconfig-a001-20200319
riscv                randconfig-a001-20200319
c6x                  randconfig-a001-20200319
h8300                randconfig-a001-20200319
microblaze           randconfig-a001-20200319
nios2                randconfig-a001-20200319
sparc64              randconfig-a001-20200319
csky                 randconfig-a001-20200319
openrisc             randconfig-a001-20200319
s390                 randconfig-a001-20200319
sh                   randconfig-a001-20200319
xtensa               randconfig-a001-20200319
x86_64               randconfig-b001-20200319
x86_64               randconfig-b002-20200319
x86_64               randconfig-b003-20200319
i386                 randconfig-b001-20200319
i386                 randconfig-b002-20200319
i386                 randconfig-b003-20200319
x86_64               randconfig-c001-20200319
x86_64               randconfig-c002-20200319
x86_64               randconfig-c003-20200319
i386                 randconfig-c001-20200319
i386                 randconfig-c002-20200319
i386                 randconfig-c003-20200319
x86_64               randconfig-d001-20200319
x86_64               randconfig-d002-20200319
x86_64               randconfig-d003-20200319
i386                 randconfig-d001-20200319
i386                 randconfig-d002-20200319
i386                 randconfig-d003-20200319
x86_64               randconfig-e001-20200319
x86_64               randconfig-e002-20200319
x86_64               randconfig-e003-20200319
i386                 randconfig-e001-20200319
i386                 randconfig-e002-20200319
i386                 randconfig-e003-20200319
x86_64               randconfig-f001-20200319
x86_64               randconfig-f002-20200319
x86_64               randconfig-f003-20200319
i386                 randconfig-f001-20200319
i386                 randconfig-f002-20200319
i386                 randconfig-f003-20200319
x86_64               randconfig-g001-20200319
x86_64               randconfig-g002-20200319
x86_64               randconfig-g003-20200319
i386                 randconfig-g001-20200319
i386                 randconfig-g002-20200319
i386                 randconfig-g003-20200319
x86_64               randconfig-h001-20200319
x86_64               randconfig-h002-20200319
x86_64               randconfig-h003-20200319
i386                 randconfig-h001-20200319
i386                 randconfig-h002-20200319
i386                 randconfig-h003-20200319
arc                  randconfig-a001-20200319
ia64                 randconfig-a001-20200319
arm                  randconfig-a001-20200319
arm64                randconfig-a001-20200319
powerpc              randconfig-a001-20200319
sparc                randconfig-a001-20200319
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             alldefconfig
s390                             allmodconfig
s390                             allyesconfig
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
