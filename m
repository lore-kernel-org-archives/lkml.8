Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34E8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 03:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADE32071A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 03:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFMDrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 23:47:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:17410 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgFMDrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 23:47:47 -0400
IronPort-SDR: pbmUJD+N9ll7hTXaMz//RwFwiW7o5z7k8ynGY5hgXoJK9QffpfnBSlOQpCv4ezsiwBW32dsZ06
 YpezmaNp7EsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 20:47:47 -0700
IronPort-SDR: zK1OuGv2HXRvqHMN3cx1ncdKn29kGGGzymJ3x+pVf7vdkY8xDmGYrD42cMGKKZrQziZrrbsQEI
 qmAXhBOIPASA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,505,1583222400"; 
   d="scan'208";a="275943497"
Received: from lkp-server02.sh.intel.com (HELO de5642daf266) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Jun 2020 20:47:46 -0700
Received: from kbuild by de5642daf266 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jjx8z-0000Cw-99; Sat, 13 Jun 2020 03:47:45 +0000
Date:   Sat, 13 Jun 2020 11:47:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 0bf3924bfabd13ba21aa702344fc00b3b3263e5a
Message-ID: <5ee44c5d.SUUL8DkbLfXO37It%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/entry
branch HEAD: 0bf3924bfabd13ba21aa702344fc00b3b3263e5a  x86/entry: Force rcu_irq_enter() when in idle task

elapsed time: 481m

configs tested: 115
configs skipped: 12

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
xtensa                         virt_defconfig
arm                          moxart_defconfig
arm                              zx_defconfig
sh                   sh7770_generic_defconfig
arm                          imote2_defconfig
sh                               alldefconfig
arc                            hsdk_defconfig
mips                         cobalt_defconfig
mips                        bcm63xx_defconfig
arm                        clps711x_defconfig
sh                 kfr2r09-romimage_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                          iss_defconfig
riscv                          rv32_defconfig
c6x                        evmc6474_defconfig
s390                          debug_defconfig
mips                            ar7_defconfig
arm                        keystone_defconfig
arm                        mvebu_v7_defconfig
arm                         assabet_defconfig
sh                          urquell_defconfig
powerpc                    amigaone_defconfig
microblaze                          defconfig
arm                          lpd270_defconfig
arm                           efm32_defconfig
powerpc                     pq2fads_defconfig
arm                          tango4_defconfig
c6x                        evmc6472_defconfig
arm                          ixp4xx_defconfig
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
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a015-20200612
i386                 randconfig-a011-20200612
i386                 randconfig-a014-20200612
i386                 randconfig-a016-20200612
i386                 randconfig-a013-20200612
i386                 randconfig-a012-20200612
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
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
um                               allmodconfig
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
