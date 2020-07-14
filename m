Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBE9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7840522206
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGNKnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:43:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:20076 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgGNKnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:43:42 -0400
IronPort-SDR: DPJnmS+1xO+Iw7xWwfgRn1ERBjmXKmJFkEX+p1bYrjt0bg3qFM9WP2cWJqJan9IyfZXSP3daCC
 G91enF9dWmhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="146872985"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="146872985"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 03:43:41 -0700
IronPort-SDR: 8wt9OQrIOOx1dnxjvevXfQjJcqi1Pf4WAYbeDYNznEXfDbLQx7cu1iiqmrbKJRSYM15AMLGLBI
 jcCm67Cv16AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="429721978"
Received: from lkp-server02.sh.intel.com (HELO 393d9bdf0d5c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Jul 2020 03:43:40 -0700
Received: from kbuild by 393d9bdf0d5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jvIPT-00006u-RN; Tue, 14 Jul 2020 10:43:39 +0000
Date:   Tue, 14 Jul 2020 18:43:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS WITH WARNING
 bccf9048549afe54b3c6bc8979ebfddea748da85
Message-ID: <5f0d8c51.HXExvWlUTk2EWsT4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: bccf9048549afe54b3c6bc8979ebfddea748da85  Merge branch 'locking/core'

Warning in current branch:

arch/x86/kernel/process.c:548 __speculation_ctrl_update() warn: ignoring unreachable code.
arch/x86/kernel/smpboot.c:1137 native_cpu_up() warn: ignoring unreachable code.
arch/x86/kernel/smpboot.c:1350 (null)() warn: inconsistent indenting
arch/x86/kernel/smpboot.c:1351 (null)() warn: ignoring unreachable code.

Warning ids grouped by kconfigs:

recent_errors
`-- i386-randconfig-m021-20200713
    |-- arch-x86-kernel-process.c-__speculation_ctrl_update()-warn:ignoring-unreachable-code.
    |-- arch-x86-kernel-smpboot.c-(null)()-warn:ignoring-unreachable-code.
    |-- arch-x86-kernel-smpboot.c-(null)()-warn:inconsistent-indenting
    `-- arch-x86-kernel-smpboot.c-native_cpu_up()-warn:ignoring-unreachable-code.

elapsed time: 2793m

configs tested: 109
configs skipped: 3

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arc                     haps_hs_smp_defconfig
mips                      bmips_stb_defconfig
arm                       cns3420vb_defconfig
xtensa                              defconfig
riscv                          rv32_defconfig
ia64                              allnoconfig
arm                            mmp2_defconfig
arm                            hisi_defconfig
i386                                defconfig
powerpc                     skiroot_defconfig
mips                 decstation_r4k_defconfig
i386                             alldefconfig
arm                      tct_hammer_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         hackkit_defconfig
m68k                       m5249evb_defconfig
alpha                            allyesconfig
arm                  colibri_pxa270_defconfig
arm                      jornada720_defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200712
i386                 randconfig-a005-20200712
i386                 randconfig-a006-20200712
i386                 randconfig-a002-20200712
i386                 randconfig-a003-20200712
i386                 randconfig-a004-20200712
x86_64               randconfig-a012-20200712
x86_64               randconfig-a011-20200712
x86_64               randconfig-a016-20200712
x86_64               randconfig-a014-20200712
x86_64               randconfig-a015-20200712
x86_64               randconfig-a013-20200712
i386                 randconfig-a016-20200712
i386                 randconfig-a015-20200712
i386                 randconfig-a011-20200712
i386                 randconfig-a012-20200712
i386                 randconfig-a013-20200712
i386                 randconfig-a014-20200712
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
