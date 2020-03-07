Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DAAC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 15:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC6520675
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 15:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgCGPiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 10:38:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:49003 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgCGPiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 10:38:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2020 07:38:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,526,1574150400"; 
   d="scan'208";a="288273311"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2020 07:38:08 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jAbWe-0007ab-Ol; Sat, 07 Mar 2020 23:38:04 +0800
Date:   Sat, 07 Mar 2020 23:37:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 798048f85093901f475d25b2ac8d9ea1bc6d471a
Message-ID: <5e63bfaf.JxFgeWCQ4wzGvzwg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/urgent
branch HEAD: 798048f85093901f475d25b2ac8d9ea1bc6d471a  Merge tag 'perf-urgent-for-mingo-5.6-20200306' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

elapsed time: 481m

configs tested: 163
configs skipped: 14

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
h8300                     edosk2674_defconfig
ia64                                defconfig
powerpc                             defconfig
s390                              allnoconfig
ia64                              allnoconfig
riscv                          rv32_defconfig
sh                            titan_defconfig
sparc                               defconfig
sh                                allnoconfig
s390                       zfcpdump_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                             alldefconfig
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
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200307
x86_64               randconfig-a002-20200307
x86_64               randconfig-a003-20200307
i386                 randconfig-a001-20200307
i386                 randconfig-a002-20200307
i386                 randconfig-a003-20200307
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
csky                 randconfig-a001-20200307
openrisc             randconfig-a001-20200307
s390                 randconfig-a001-20200307
sh                   randconfig-a001-20200307
xtensa               randconfig-a001-20200307
x86_64               randconfig-b002-20200307
x86_64               randconfig-b001-20200307
i386                 randconfig-b001-20200307
i386                 randconfig-b003-20200307
i386                 randconfig-b002-20200307
x86_64               randconfig-b003-20200307
x86_64               randconfig-c001-20200307
x86_64               randconfig-c002-20200307
x86_64               randconfig-c003-20200307
i386                 randconfig-c001-20200307
i386                 randconfig-c002-20200307
i386                 randconfig-c003-20200307
x86_64               randconfig-d001-20200307
x86_64               randconfig-d002-20200307
x86_64               randconfig-d003-20200307
i386                 randconfig-d001-20200307
i386                 randconfig-d002-20200307
i386                 randconfig-d003-20200307
i386                 randconfig-e001-20200307
i386                 randconfig-e003-20200307
x86_64               randconfig-e002-20200307
x86_64               randconfig-e001-20200307
x86_64               randconfig-e003-20200307
i386                 randconfig-e002-20200307
x86_64               randconfig-f001-20200307
x86_64               randconfig-f002-20200307
x86_64               randconfig-f003-20200307
i386                 randconfig-f001-20200307
i386                 randconfig-f002-20200307
i386                 randconfig-f003-20200307
x86_64               randconfig-g001-20200307
x86_64               randconfig-g002-20200307
x86_64               randconfig-g003-20200307
i386                 randconfig-g001-20200307
i386                 randconfig-g002-20200307
i386                 randconfig-g003-20200307
x86_64               randconfig-h001-20200307
x86_64               randconfig-h002-20200307
x86_64               randconfig-h003-20200307
i386                 randconfig-h001-20200307
i386                 randconfig-h002-20200307
i386                 randconfig-h003-20200307
arc                  randconfig-a001-20200307
arm                  randconfig-a001-20200307
arm64                randconfig-a001-20200307
ia64                 randconfig-a001-20200307
powerpc              randconfig-a001-20200307
sparc                randconfig-a001-20200307
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                  sh7785lcr_32bit_defconfig
sparc                            allyesconfig
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
