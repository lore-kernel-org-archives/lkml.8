Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61091C33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 06:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3653F2467C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 06:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgARGpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 01:45:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:59018 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgARGpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 01:45:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 22:45:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,333,1574150400"; 
   d="scan'208";a="258094952"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jan 2020 22:45:07 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ishr1-000E5z-2U; Sat, 18 Jan 2020 14:45:07 +0800
Date:   Sat, 18 Jan 2020 14:44:49 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/pti] BUILD SUCCESS
 a84de2fa962c1b0551653fe245d6cb5f6129179c
Message-ID: <5e22a961.4Y7qgo1KaDE0zZ/X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/pti
branch HEAD: a84de2fa962c1b0551653fe245d6cb5f6129179c  x86/speculation/swapgs: Exclude Zhaoxin CPUs from SWAPGS vulnerability

elapsed time: 667m

configs tested: 121
configs skipped: 95

The following configs have been built successfully.
More configs may be tested in the coming days.

csky                 randconfig-a001-20200118
openrisc             randconfig-a001-20200118
s390                 randconfig-a001-20200118
sh                   randconfig-a001-20200118
xtensa               randconfig-a001-20200118
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
arc                  randconfig-a001-20200118
arm                  randconfig-a001-20200118
arm64                randconfig-a001-20200118
ia64                 randconfig-a001-20200118
powerpc              randconfig-a001-20200118
sparc                randconfig-a001-20200118
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
x86_64               randconfig-e001-20200118
x86_64               randconfig-e002-20200118
x86_64               randconfig-e003-20200118
i386                 randconfig-e001-20200118
i386                 randconfig-e002-20200118
i386                 randconfig-e003-20200118
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
c6x                  randconfig-a001-20200118
h8300                randconfig-a001-20200118
microblaze           randconfig-a001-20200118
nios2                randconfig-a001-20200118
sparc64              randconfig-a001-20200118
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
alpha                randconfig-a001-20200118
m68k                 randconfig-a001-20200118
mips                 randconfig-a001-20200118
nds32                randconfig-a001-20200118
parisc               randconfig-a001-20200118
riscv                randconfig-a001-20200118
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64               randconfig-f001-20200118
x86_64               randconfig-f002-20200118
x86_64               randconfig-f003-20200118
i386                 randconfig-f001-20200118
i386                 randconfig-f002-20200118
i386                 randconfig-f003-20200118
x86_64               randconfig-b001-20200118
x86_64               randconfig-b002-20200118
x86_64               randconfig-b003-20200118
i386                 randconfig-b001-20200118
i386                 randconfig-b002-20200118
i386                 randconfig-b003-20200118
x86_64               randconfig-c001-20200118
x86_64               randconfig-c002-20200118
x86_64               randconfig-c003-20200118
i386                 randconfig-c001-20200118
i386                 randconfig-c002-20200118
i386                 randconfig-c003-20200118
x86_64               randconfig-h001-20200118
x86_64               randconfig-h002-20200118
x86_64               randconfig-h003-20200118
i386                 randconfig-h001-20200118
i386                 randconfig-h002-20200118
i386                 randconfig-h003-20200118
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
