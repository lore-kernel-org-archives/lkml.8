Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAA5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F03220671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgEOB3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 21:29:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:22776 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgEOB3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 21:29:38 -0400
IronPort-SDR: dk6njbxqK2xWe5uHowYbMpyFfWtt5INfENTJ/ygKdEq22/C8FwJAPca4mG5u9a/gMotvsHvpSc
 nFOI9QUZ7w0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 18:29:37 -0700
IronPort-SDR: 7HD2/yQHqaC0COFyHhYp7PRg9Ols82vKZufeVMlQffsDF67O2328DeFOn3Ss6+4a37ModLelLp
 oG9as4ICQbMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,393,1583222400"; 
   d="scan'208";a="281056676"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 May 2020 18:29:36 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZPAN-000GD7-Fr; Fri, 15 May 2020 09:29:35 +0800
Date:   Fri, 15 May 2020 09:28:57 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.05.14a] BUILD SUCCESS
 514375f17d28a6d9bc86d0ad441bea7d81a0c068
Message-ID: <5ebdf059.eLl/fNlzxq7Cos1t%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.05.14a
branch HEAD: 514375f17d28a6d9bc86d0ad441bea7d81a0c068  ubsan, kcsan: Don't combine sanitizer with kcov on clang

elapsed time: 491m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arc                 nsimosci_hs_smp_defconfig
mips                          malta_defconfig
arm                          exynos_defconfig
powerpc                      pmac32_defconfig
mips                         rt305x_defconfig
arm                           corgi_defconfig
m68k                       m5208evb_defconfig
powerpc                       holly_defconfig
arm                        oxnas_v6_defconfig
powerpc                           allnoconfig
powerpc                      tqm8xx_defconfig
mips                           ip28_defconfig
arm                        clps711x_defconfig
mips                   sb1250_swarm_defconfig
arm                           efm32_defconfig
nios2                         3c120_defconfig
um                             i386_defconfig
arm                         lubbock_defconfig
arm                       multi_v4t_defconfig
arc                          axs103_defconfig
arc                      axs103_smp_defconfig
arm                         cm_x2xx_defconfig
arm                         palmz72_defconfig
arm                         socfpga_defconfig
mips                        bcm63xx_defconfig
mips                      fuloong2e_defconfig
m68k                          atari_defconfig
m68k                          sun3x_defconfig
mips                        jmr3927_defconfig
arm                        cerfcube_defconfig
ia64                         bigsur_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
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
i386                 randconfig-a006-20200514
i386                 randconfig-a005-20200514
i386                 randconfig-a003-20200514
i386                 randconfig-a001-20200514
i386                 randconfig-a004-20200514
i386                 randconfig-a002-20200514
i386                 randconfig-a012-20200514
i386                 randconfig-a016-20200514
i386                 randconfig-a014-20200514
i386                 randconfig-a011-20200514
i386                 randconfig-a013-20200514
i386                 randconfig-a015-20200514
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
