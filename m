Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E0AC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75E4208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgEHHN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:13:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:23845 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgEHHNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:13:25 -0400
IronPort-SDR: Xju6Eq9ewAE/XcztQ70vBf6CX0wsd9OCtlf4kEmEPv1rRqRcwouBwV0A6CjQ2J77LUsawZoU/i
 QotsN6M83jtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 00:13:25 -0700
IronPort-SDR: J9t310eHLmB3Du0D1IUsXpj+qkKcZupddzfiylr2llsJzqFydQmQDZ568ZhNcpN9C76iy0yBET
 heda81K1xsOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="295988789"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2020 00:13:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWxCF-0006cv-Ia; Fri, 08 May 2020 15:13:23 +0800
Date:   Fri, 08 May 2020 15:12:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 d13fee049fa8e94649aa9914fd1ab5d07da51da4
Message-ID: <5eb5067b.d5MUalfbbwtMa77D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: d13fee049fa8e94649aa9914fd1ab5d07da51da4  Default enable RCU list lockdep debugging with PROVE_RCU

elapsed time: 507m

configs tested: 98
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
sparc                            allyesconfig
m68k                             allyesconfig
sh                                allnoconfig
sparc64                             defconfig
c6x                              allyesconfig
nds32                             allnoconfig
microblaze                        allnoconfig
sparc                               defconfig
mips                             allmodconfig
um                                  defconfig
m68k                                defconfig
parisc                           allyesconfig
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
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
sh                               allmodconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                       allyesconfig
mips                             allyesconfig
mips                              allnoconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20200507
i386                 randconfig-a004-20200507
i386                 randconfig-a001-20200507
i386                 randconfig-a002-20200507
i386                 randconfig-a003-20200507
i386                 randconfig-a006-20200507
x86_64               randconfig-a015-20200507
x86_64               randconfig-a014-20200507
x86_64               randconfig-a012-20200507
x86_64               randconfig-a013-20200507
x86_64               randconfig-a011-20200507
x86_64               randconfig-a016-20200507
i386                 randconfig-a012-20200507
i386                 randconfig-a016-20200507
i386                 randconfig-a014-20200507
i386                 randconfig-a011-20200507
i386                 randconfig-a015-20200507
i386                 randconfig-a013-20200507
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
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
