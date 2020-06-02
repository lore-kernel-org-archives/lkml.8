Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDE4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88975206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgFBX4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:56:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:39951 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgFBX4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:56:49 -0400
IronPort-SDR: kqR33ZJX/9W0wSPixUR5SnrGGjYJruHrYYOGDOEF9nDgemrWQYGfsOHJ/EJ/h6w31D791gGLj1
 amrl1ji3SR/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 16:56:48 -0700
IronPort-SDR: WIrurRnezpseoyf7XUinRjJlrFZ3bnLFDFmIEKnv5hCZHWOvHoS4ZG2mh2n8ZFyWXvqWa9RuMe
 oFgNY4iNRP3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; 
   d="scan'208";a="444892104"
Received: from lkp-server01.sh.intel.com (HELO e5a7ad696f24) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Jun 2020 16:56:47 -0700
Received: from kbuild by e5a7ad696f24 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jgGly-0000Ft-Id; Tue, 02 Jun 2020 23:56:46 +0000
Date:   Wed, 03 Jun 2020 07:55:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:urgent-for-mingo] BUILD SUCCESS
 b3e2d20973db3ec87a6dd2fee0c88d3c2e7c2f61
Message-ID: <5ed6e6ff.3jAh0rAFx8uajkdK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  urgent-for-mingo
branch HEAD: b3e2d20973db3ec87a6dd2fee0c88d3c2e7c2f61  rcuperf: Fix printk format warning

elapsed time: 485m

configs tested: 99
configs skipped: 7

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
arm                       imx_v4_v5_defconfig
h8300                     edosk2674_defconfig
parisc                generic-64bit_defconfig
m68k                         amcore_defconfig
arm                          moxart_defconfig
sh                               j2_defconfig
sparc64                          allyesconfig
arm                            mps2_defconfig
arm                          prima2_defconfig
s390                              allnoconfig
mips                              allnoconfig
mips                            gpr_defconfig
sh                     sh7710voipgw_defconfig
powerpc                  storcenter_defconfig
mips                  decstation_64_defconfig
sh                   rts7751r2dplus_defconfig
sh                     magicpanelr2_defconfig
ia64                             allmodconfig
s390                             alldefconfig
c6x                        evmc6472_defconfig
sh                          rsk7203_defconfig
arm                       netwinder_defconfig
arm                          badge4_defconfig
arc                        nsimosci_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
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
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allyesconfig
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
