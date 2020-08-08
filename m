Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66572C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 14:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4406120748
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 14:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgHHOPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 10:15:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:5963 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgHHOP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 10:15:26 -0400
IronPort-SDR: Vq4LCGGi9/vhMwZi5GOGkpxlbUNzCGTlYm130ByuBK4bi2c1QgKI9Q/xPAEz3dXLc41KJptoZu
 VdBIIn1Ef1YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9707"; a="171353291"
X-IronPort-AV: E=Sophos;i="5.75,449,1589266800"; 
   d="scan'208";a="171353291"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2020 07:15:21 -0700
IronPort-SDR: jgf0cMfi9O5x+BAvKSSBn6NGjYRZd9BXNJDWpOcI3ZHr0QBd/bTIWY4UNyZn5sY11Ea/KNWOPp
 W0Qb6QUe6s7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,449,1589266800"; 
   d="scan'208";a="324028868"
Received: from lkp-server02.sh.intel.com (HELO 65e25449d42f) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2020 07:15:20 -0700
Received: from kbuild by 65e25449d42f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k4Pd1-00009z-EB; Sat, 08 Aug 2020 14:15:19 +0000
Date:   Sat, 08 Aug 2020 22:14:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.08.05a] BUILD SUCCESS
 3893c86425fd2f1480d8740aa6b9f55e72497c4d
Message-ID: <5f2eb351.orB13Yoz51rhBHNA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.08.05a
branch HEAD: 3893c86425fd2f1480d8740aa6b9f55e72497c4d  rcu: Provide optional RCU-reader exit delay for strict GPs

elapsed time: 723m

configs tested: 75
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
s390                       zfcpdump_defconfig
mips                        workpad_defconfig
sh                                  defconfig
powerpc                     powernv_defconfig
h8300                            alldefconfig
x86_64                           allyesconfig
powerpc                      mgcoge_defconfig
arm                         palmz72_defconfig
powerpc                     mpc83xx_defconfig
xtensa                       common_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a004-20200808
i386                 randconfig-a005-20200808
i386                 randconfig-a001-20200808
i386                 randconfig-a003-20200808
i386                 randconfig-a002-20200808
i386                 randconfig-a006-20200808
x86_64               randconfig-a013-20200807
x86_64               randconfig-a011-20200807
x86_64               randconfig-a012-20200807
x86_64               randconfig-a016-20200807
x86_64               randconfig-a015-20200807
x86_64               randconfig-a014-20200807
i386                 randconfig-a011-20200808
i386                 randconfig-a014-20200808
i386                 randconfig-a015-20200808
i386                 randconfig-a013-20200808
i386                 randconfig-a012-20200808
i386                 randconfig-a016-20200808
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
