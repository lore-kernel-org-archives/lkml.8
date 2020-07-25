Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F92C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2134206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGYO1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 10:27:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:59113 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgGYO1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 10:27:09 -0400
IronPort-SDR: W7Ic5KTimq5paDhmlaaDJk6awYo7F1LnraaOKO78PHo7IM6VSvr9FS7ptnjQAnGgI9CqxlvuRv
 SCdZQjyG4sLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9693"; a="152111422"
X-IronPort-AV: E=Sophos;i="5.75,394,1589266800"; 
   d="scan'208";a="152111422"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2020 07:27:08 -0700
IronPort-SDR: ZStQ/9Wz/FI48OqFwcJvpsPcrFRrclPvSNlfklYxTAYxb6/Vy2TQv3gukqVjDITAlXtTXmBO5u
 fKLCzFm8mBfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,394,1589266800"; 
   d="scan'208";a="433375477"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Jul 2020 07:27:07 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzL8l-0000yh-1I; Sat, 25 Jul 2020 14:27:07 +0000
Date:   Sat, 25 Jul 2020 22:25:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.07.20a] BUILD SUCCESS
 80f707206fe3d3ab5b83f8180538f8a70e095ead
Message-ID: <5f1c40f6.ES2Rfe0TnqyWlS2x%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.07.20a
branch HEAD: 80f707206fe3d3ab5b83f8180538f8a70e095ead  fixup! kernel/smp: Provide CSD lock timeout diagnostics

elapsed time: 1112m

configs tested: 74
configs skipped: 1

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
x86_64                                    lkp
x86_64                              fedora-25
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
