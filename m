Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C106C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2638E20409
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCTUNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:13:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:54528 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTUNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:13:52 -0400
IronPort-SDR: pBoDGcGOPU4J1AM+Nkt+/9JwZbadsLdtMVL0ItcRVXut97BxvE8lec4QfIa9dwZLV9+vXG9gxq
 o9vpth4tgInA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 13:13:51 -0700
IronPort-SDR: Nq6IV8NleKxjSVCUbKn+i2+wxxPmRgOo4WpodjLoIjfNlvryv06FuChiT/Vp8b9jHq+rd+wPEW
 qGtSrpl/Sc2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="418832686"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Mar 2020 13:13:50 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jFO1d-00039O-Pv; Sat, 21 Mar 2020 04:13:49 +0800
Date:   Sat, 21 Mar 2020 04:13:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD REGRESSION
 b1a032f147e1013d82555a39f0fdb5967bd5ffce
Message-ID: <5e7523cc.xmhVKInWe4iZhNBY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  perf/core
branch HEAD: b1a032f147e1013d82555a39f0fdb5967bd5ffce  perf/x86/intel/uncore: Add Ice Lake server uncore support

Regressions in current branch:

arch/x86/events/intel/uncore_snbep.c:4425 __snr_uncore_mmio_init_box() warn: should '(pci_dword & 536870911) << 23' be a 64 bit type?

Error ids grouped by kconfigs:

recent_errors
`-- x86_64-defconfig
    `-- arch-x86-events-intel-uncore_snbep.c-__snr_uncore_mmio_init_box()-warn:should-(pci_dword-)-be-a-bit-type

elapsed time: 483m

configs tested: 176
configs skipped: 0

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
ia64                             allyesconfig
nds32                             allnoconfig
nios2                         3c120_defconfig
ia64                             allmodconfig
i386                                defconfig
s390                             allyesconfig
parisc                generic-32bit_defconfig
c6x                        evmc6678_defconfig
powerpc                           allnoconfig
riscv                          rv32_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                       m5475evb_defconfig
m68k                           sun3_defconfig
m68k                             allmodconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                             defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200320
x86_64               randconfig-a002-20200320
x86_64               randconfig-a003-20200320
i386                 randconfig-a001-20200320
i386                 randconfig-a002-20200320
i386                 randconfig-a003-20200320
x86_64               randconfig-a001-20200321
x86_64               randconfig-a002-20200321
x86_64               randconfig-a003-20200321
i386                 randconfig-a001-20200321
i386                 randconfig-a002-20200321
i386                 randconfig-a003-20200321
alpha                randconfig-a001-20200320
mips                 randconfig-a001-20200320
nds32                randconfig-a001-20200320
parisc               randconfig-a001-20200320
alpha                randconfig-a001-20200321
m68k                 randconfig-a001-20200321
mips                 randconfig-a001-20200321
nds32                randconfig-a001-20200321
parisc               randconfig-a001-20200321
riscv                randconfig-a001-20200321
m68k                 randconfig-a001-20200320
riscv                randconfig-a001-20200320
c6x                  randconfig-a001-20200320
h8300                randconfig-a001-20200320
microblaze           randconfig-a001-20200320
nios2                randconfig-a001-20200320
sparc64              randconfig-a001-20200320
csky                 randconfig-a001-20200320
openrisc             randconfig-a001-20200320
s390                 randconfig-a001-20200320
sh                   randconfig-a001-20200320
xtensa               randconfig-a001-20200320
x86_64               randconfig-b001-20200320
x86_64               randconfig-b002-20200320
x86_64               randconfig-b003-20200320
i386                 randconfig-b001-20200320
i386                 randconfig-b002-20200320
i386                 randconfig-b003-20200320
x86_64               randconfig-c001-20200320
x86_64               randconfig-c002-20200320
x86_64               randconfig-c003-20200320
i386                 randconfig-c001-20200320
i386                 randconfig-c002-20200320
i386                 randconfig-c003-20200320
x86_64               randconfig-d001-20200320
x86_64               randconfig-d002-20200320
x86_64               randconfig-d003-20200320
i386                 randconfig-d001-20200320
i386                 randconfig-d002-20200320
i386                 randconfig-d003-20200320
x86_64               randconfig-e001-20200320
x86_64               randconfig-e002-20200320
x86_64               randconfig-e003-20200320
i386                 randconfig-e001-20200320
i386                 randconfig-e002-20200320
i386                 randconfig-e003-20200320
x86_64               randconfig-f001-20200320
x86_64               randconfig-f002-20200320
x86_64               randconfig-f003-20200320
i386                 randconfig-f001-20200320
i386                 randconfig-f002-20200320
i386                 randconfig-f003-20200320
x86_64               randconfig-g001-20200320
x86_64               randconfig-g002-20200320
x86_64               randconfig-g003-20200320
i386                 randconfig-g001-20200320
i386                 randconfig-g002-20200320
i386                 randconfig-g003-20200320
x86_64               randconfig-h001-20200320
x86_64               randconfig-h002-20200320
x86_64               randconfig-h003-20200320
i386                 randconfig-h001-20200320
i386                 randconfig-h002-20200320
i386                 randconfig-h003-20200320
arc                  randconfig-a001-20200320
arm                  randconfig-a001-20200320
arm64                randconfig-a001-20200320
ia64                 randconfig-a001-20200320
powerpc              randconfig-a001-20200320
sparc                randconfig-a001-20200320
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
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
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
