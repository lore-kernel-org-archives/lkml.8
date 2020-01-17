Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087C2C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB71C2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgAQMTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:19:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:57225 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbgAQMTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:19:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 04:19:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="424444740"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jan 2020 04:19:40 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1isQbD-000408-Tk; Fri, 17 Jan 2020 20:19:39 +0800
Date:   Fri, 17 Jan 2020 20:18:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 bb02e2cb715a3f3552dbe765ea4a07799e4dff43
Message-ID: <5e21a62d.EtGxFRrOfG3cJm+z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cpu
branch HEAD: bb02e2cb715a3f3552dbe765ea4a07799e4dff43  x86/cpu: Print "VMX disabled" error message iff KVM is enabled

elapsed time: 1791m

configs tested: 117
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
ia64                             alldefconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
sparc64              randconfig-a001-20200117
nios2                randconfig-a001-20200117
c6x                  randconfig-a001-20200117
h8300                randconfig-a001-20200117
riscv                randconfig-a001-20200117
parisc               randconfig-a001-20200117
m68k                 randconfig-a001-20200117
alpha                randconfig-a001-20200117
nds32                randconfig-a001-20200117
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
arc                  randconfig-a001-20200116
arm                  randconfig-a001-20200116
arm64                randconfig-a001-20200116
ia64                 randconfig-a001-20200116
powerpc              randconfig-a001-20200116
sparc                randconfig-a001-20200116
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64               randconfig-b001-20200116
x86_64               randconfig-b002-20200116
x86_64               randconfig-b003-20200116
i386                 randconfig-b001-20200116
i386                 randconfig-b002-20200116
i386                 randconfig-b003-20200116
x86_64               randconfig-g001-20200116
x86_64               randconfig-g002-20200116
x86_64               randconfig-g003-20200116
i386                 randconfig-g001-20200116
i386                 randconfig-g002-20200116
i386                 randconfig-g003-20200116
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
arm64                            allyesconfig
arm                               allnoconfig
arm64                             allnoconfig
arm64                            allmodconfig
s390                 randconfig-a001-20200117
sh                   randconfig-a001-20200117
xtensa               randconfig-a001-20200117
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
mips                             allmodconfig
mips                           32r2_defconfig
mips                             allyesconfig
mips                              allnoconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
i386                              allnoconfig
i386                                defconfig
i386                             allyesconfig
i386                             alldefconfig
x86_64               randconfig-d001-20200116
x86_64               randconfig-d002-20200116
x86_64               randconfig-d003-20200116
i386                 randconfig-d001-20200116
i386                 randconfig-d002-20200116
i386                 randconfig-d003-20200116
s390                              allnoconfig
s390                             alldefconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
