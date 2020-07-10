Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0F5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36022076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgGJSoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:44:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:8996 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbgGJSoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:44:07 -0400
IronPort-SDR: q8PKtIlIkz9R7ZWoW2LjwjzcjwvkzFsf6E4nUvZgYimERCSn50Is5Qur2UwCr9wbJOvGjH1wUL
 G1eAwOGHMcsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="233143998"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="233143998"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 11:44:06 -0700
IronPort-SDR: bWHVgr/NOckXsufDbBhaSvSHfZ4EqNWmn+fvxFPge2zKn1lx8sBEeoBteidS6beR6TeR8Amtgp
 Sx4//pJUvvcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="280735961"
Received: from lkp-server02.sh.intel.com (HELO 0fc60ea15964) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Jul 2020 11:44:05 -0700
Received: from kbuild by 0fc60ea15964 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jty0C-000106-HU; Fri, 10 Jul 2020 18:44:04 +0000
Date:   Sat, 11 Jul 2020 02:43:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 3bb1d1bb0740ca3b5ffbbf2bd994175932b6dcb4
Message-ID: <5f08b6df.WrxX1twfw0yIGv/B%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 3bb1d1bb0740ca3b5ffbbf2bd994175932b6dcb4  rcu: Fix kerneldoc comments in rcuupdate.h

elapsed time: 727m

configs tested: 98
configs skipped: 2

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
sh                      rts7751r2d1_defconfig
arm                          gemini_defconfig
sh                        edosk7760_defconfig
arm                      footbridge_defconfig
ia64                            zx1_defconfig
arm                        spear3xx_defconfig
mips                      pic32mzda_defconfig
arm                          iop32x_defconfig
sh                         ap325rxa_defconfig
sh                          urquell_defconfig
powerpc                     skiroot_defconfig
arc                     nsimosci_hs_defconfig
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
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a001-20200710
i386                 randconfig-a005-20200710
i386                 randconfig-a006-20200710
i386                 randconfig-a002-20200710
i386                 randconfig-a003-20200710
i386                 randconfig-a004-20200710
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
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
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
