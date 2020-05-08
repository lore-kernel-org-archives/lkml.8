Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6421C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6B12173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgEHVJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:09:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:47831 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgEHVJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:09:27 -0400
IronPort-SDR: QO0FxIEqTehsgRPWcWhn8OHH+9Tg6Ok9g5yi5cVANRlkFFGlmbC6ZWyXuABWC651F8Z7VXPJDA
 EqW426tMwqKQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 14:09:26 -0700
IronPort-SDR: t8aaeoiPvCzOsEvHLJZqAjj+9C+nJFuYFvskqaR0vlh09eQuAezALf37FWPrOromuz1phYNjBv
 46F3pt5Fq19A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,369,1583222400"; 
   d="scan'208";a="264510152"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 May 2020 14:09:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jXAFI-000B77-Rl; Sat, 09 May 2020 05:09:24 +0800
Date:   Sat, 09 May 2020 05:08:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 059c6d68cfc5f85ba3ab71d71a6de380016f7936
Message-ID: <5eb5ca5f.JfnaeVrQ3S0+Hpp2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/core
branch HEAD: 059c6d68cfc5f85ba3ab71d71a6de380016f7936  Merge tag 'perf-core-for-mingo-5.8-20200506' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core

elapsed time: 483m

configs tested: 98
configs skipped: 21

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
sparc                            allyesconfig
m68k                             allyesconfig
parisc                              defconfig
parisc                            allnoconfig
s390                                defconfig
c6x                              allyesconfig
alpha                            allyesconfig
nds32                               defconfig
powerpc                             defconfig
sparc64                             defconfig
alpha                               defconfig
arc                              allyesconfig
ia64                                defconfig
riscv                             allnoconfig
microblaze                        allnoconfig
c6x                               allnoconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
openrisc                         allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
microblaze                       allyesconfig
sh                               allmodconfig
sh                                allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20200508
i386                 randconfig-a004-20200508
i386                 randconfig-a003-20200508
i386                 randconfig-a002-20200508
i386                 randconfig-a001-20200508
i386                 randconfig-a006-20200508
x86_64               randconfig-a015-20200509
x86_64               randconfig-a014-20200509
x86_64               randconfig-a011-20200509
x86_64               randconfig-a013-20200509
x86_64               randconfig-a012-20200509
x86_64               randconfig-a016-20200509
i386                 randconfig-a012-20200508
i386                 randconfig-a014-20200508
i386                 randconfig-a016-20200508
i386                 randconfig-a011-20200508
i386                 randconfig-a013-20200508
i386                 randconfig-a015-20200508
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
sparc                               defconfig
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
