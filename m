Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B81AC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 17:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E4D206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 17:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgCGRK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 12:10:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:64122 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgCGRK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 12:10:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2020 09:10:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,526,1574150400"; 
   d="scan'208";a="264806692"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2020 09:10:26 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jAcy2-000IFx-AE; Sun, 08 Mar 2020 01:10:26 +0800
Date:   Sun, 08 Mar 2020 01:10:07 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 94c24ce61149d718dd6d295cf53006f9d6dc0580
Message-ID: <5e63d56f.aln2D7VxXbepBIxb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 94c24ce61149d718dd6d295cf53006f9d6dc0580  Merge branch 'perf/urgent'

elapsed time: 574m

configs tested: 151
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
s390                              allnoconfig
riscv                          rv32_defconfig
sh                            titan_defconfig
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
powerpc                             defconfig
powerpc                       ppc64_defconfig
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
i386                 randconfig-a003-20200307
x86_64               randconfig-a001-20200307
i386                 randconfig-a001-20200307
i386                 randconfig-a002-20200307
x86_64               randconfig-a003-20200307
x86_64               randconfig-a002-20200307
riscv                randconfig-a001-20200307
alpha                randconfig-a001-20200307
m68k                 randconfig-a001-20200307
nds32                randconfig-a001-20200307
mips                 randconfig-a001-20200307
parisc               randconfig-a001-20200307
sparc64              randconfig-a001-20200307
c6x                  randconfig-a001-20200307
nios2                randconfig-a001-20200307
h8300                randconfig-a001-20200307
sh                   randconfig-a001-20200307
openrisc             randconfig-a001-20200307
csky                 randconfig-a001-20200307
s390                 randconfig-a001-20200307
xtensa               randconfig-a001-20200307
x86_64               randconfig-b002-20200307
x86_64               randconfig-b001-20200307
i386                 randconfig-b001-20200307
i386                 randconfig-b003-20200307
i386                 randconfig-b002-20200307
x86_64               randconfig-b003-20200307
i386                 randconfig-c002-20200307
x86_64               randconfig-c003-20200307
i386                 randconfig-c001-20200307
x86_64               randconfig-c002-20200307
i386                 randconfig-c003-20200307
x86_64               randconfig-c001-20200307
x86_64               randconfig-d003-20200307
i386                 randconfig-d001-20200307
x86_64               randconfig-d001-20200307
i386                 randconfig-d003-20200307
i386                 randconfig-d002-20200307
x86_64               randconfig-d002-20200307
i386                 randconfig-e001-20200307
i386                 randconfig-e003-20200307
x86_64               randconfig-e002-20200307
x86_64               randconfig-e001-20200307
x86_64               randconfig-e003-20200307
i386                 randconfig-e002-20200307
i386                 randconfig-f003-20200307
x86_64               randconfig-f001-20200307
i386                 randconfig-f001-20200307
i386                 randconfig-f002-20200307
x86_64               randconfig-f002-20200307
x86_64               randconfig-f003-20200307
arc                  randconfig-a001-20200307
ia64                 randconfig-a001-20200307
sparc                randconfig-a001-20200307
arm                  randconfig-a001-20200307
arm64                randconfig-a001-20200307
powerpc              randconfig-a001-20200307
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
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
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
