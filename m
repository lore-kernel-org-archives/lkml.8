Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CF8C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1FB21D7B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgGNKbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:31:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:19804 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgGNKbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:31:52 -0400
IronPort-SDR: dqN0V/VZZrJkRvpZs9u4kUzSDuX7BQOxJo/li913WFU3Jqbz8PzmCXTlWhMHreugbf3w8dZaWN
 qup0uEZUiUaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="233727001"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="233727001"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 03:31:52 -0700
IronPort-SDR: Iqkd1gFlRluL6OhPCtM8nCOvqYt9SGDZOpxA1NUXCY12pnQdBSf+4Gd+46EkVYExeM5I2v2iV9
 bSSJE3aldnBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="485318219"
Received: from lkp-server02.sh.intel.com (HELO 393d9bdf0d5c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jul 2020 03:31:50 -0700
Received: from kbuild by 393d9bdf0d5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jvIE2-00003G-61; Tue, 14 Jul 2020 10:31:50 +0000
Date:   Tue, 14 Jul 2020 18:30:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 f9ad4a5f3f20bee022b1bdde94e5ece6dc0b0edc
Message-ID: <5f0d894b.bsNzGinxQ2dgE+V0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  locking/core
branch HEAD: f9ad4a5f3f20bee022b1bdde94e5ece6dc0b0edc  lockdep: Remove lockdep_hardirq{s_enabled,_context}() argument

elapsed time: 5764m

configs tested: 163
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
xtensa                           allyesconfig
sh                           se7712_defconfig
arm                     am200epdkit_defconfig
csky                             allyesconfig
m68k                       m5249evb_defconfig
arm                            dove_defconfig
sh                        sh7757lcr_defconfig
mips                    maltaup_xpa_defconfig
powerpc                        cell_defconfig
arm                         axm55xx_defconfig
arm                           sama5_defconfig
sh                         apsh4a3a_defconfig
riscv                    nommu_virt_defconfig
m68k                                defconfig
arm                         shannon_defconfig
arm                         ebsa110_defconfig
m68k                       m5475evb_defconfig
arm                      pxa255-idp_defconfig
s390                             alldefconfig
arm                           h5000_defconfig
mips                      pic32mzda_defconfig
sparc                               defconfig
arm                          iop32x_defconfig
sparc64                          allyesconfig
sh                           se7206_defconfig
powerpc                    amigaone_defconfig
openrisc                    or1ksim_defconfig
nios2                         10m50_defconfig
mips                            ar7_defconfig
arm                        realview_defconfig
powerpc                  storcenter_defconfig
arm                         mv78xx0_defconfig
ia64                      gensparse_defconfig
powerpc                         ps3_defconfig
sh                      rts7751r2d1_defconfig
arm                      tct_hammer_defconfig
sh                             shx3_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
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
i386                 randconfig-a001-20200710
i386                 randconfig-a005-20200710
i386                 randconfig-a006-20200710
i386                 randconfig-a002-20200710
i386                 randconfig-a003-20200710
i386                 randconfig-a004-20200710
i386                 randconfig-a001-20200712
i386                 randconfig-a005-20200712
i386                 randconfig-a006-20200712
i386                 randconfig-a002-20200712
i386                 randconfig-a003-20200712
i386                 randconfig-a004-20200712
x86_64               randconfig-a005-20200713
x86_64               randconfig-a002-20200713
x86_64               randconfig-a006-20200713
x86_64               randconfig-a001-20200713
x86_64               randconfig-a003-20200713
x86_64               randconfig-a004-20200713
x86_64               randconfig-a012-20200710
x86_64               randconfig-a011-20200710
x86_64               randconfig-a016-20200710
x86_64               randconfig-a014-20200710
x86_64               randconfig-a015-20200710
x86_64               randconfig-a013-20200710
x86_64               randconfig-a012-20200712
x86_64               randconfig-a011-20200712
x86_64               randconfig-a016-20200712
x86_64               randconfig-a014-20200712
x86_64               randconfig-a015-20200712
x86_64               randconfig-a013-20200712
i386                 randconfig-a016-20200710
i386                 randconfig-a015-20200710
i386                 randconfig-a011-20200710
i386                 randconfig-a012-20200710
i386                 randconfig-a013-20200710
i386                 randconfig-a014-20200710
i386                 randconfig-a016-20200712
i386                 randconfig-a015-20200712
i386                 randconfig-a011-20200712
i386                 randconfig-a012-20200712
i386                 randconfig-a013-20200712
i386                 randconfig-a014-20200712
i386                 randconfig-a016-20200713
i386                 randconfig-a015-20200713
i386                 randconfig-a011-20200713
i386                 randconfig-a012-20200713
i386                 randconfig-a013-20200713
i386                 randconfig-a014-20200713
i386                 randconfig-a016-20200711
i386                 randconfig-a015-20200711
i386                 randconfig-a011-20200711
i386                 randconfig-a012-20200711
i386                 randconfig-a013-20200711
i386                 randconfig-a014-20200711
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allmodconfig
um                                  defconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
