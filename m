Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A13AC35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A34A20725
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEGWNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:13:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:33917 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgEGWNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:13:21 -0400
IronPort-SDR: x1Ry7qvJd5W2PYZ+o0qqt8GwWtMdPWmwHvRoR4UFY9If33DXePYiInOAxv1cwTOR2i5BS14wvJ
 8JtFhX/8IJuw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 15:13:17 -0700
IronPort-SDR: 4jtAvSsBi5kAonW03A7goVUjjneJAglScga+XpOKdggf1hUzVsla192c5CSEa6GCa4JCEyOB/Y
 FY/0iuTldBHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,365,1583222400"; 
   d="scan'208";a="407796997"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 May 2020 15:13:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWolY-0004iO-3o; Fri, 08 May 2020 06:13:16 +0800
Date:   Fri, 08 May 2020 06:12:29 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/timers] BUILD SUCCESS
 cec5f268cd02d25d2d74807843d8ae0292fe0fb7
Message-ID: <5eb487cd.WZRvsH7FcsklL7eF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/timers
branch HEAD: cec5f268cd02d25d2d74807843d8ae0292fe0fb7  x86/delay: Introduce TPAUSE delay

i386-tinyconfig vmlinux size:

+-------+------------------------------------+--------------------------------------------------------------------+
| DELTA |               SYMBOL               |                               COMMIT                               |
+-------+------------------------------------+--------------------------------------------------------------------+
|   +72 | TOTAL                              | 3c40cdb0e93e..cec5f268cd02 (ALL COMMITS)                           |
|   +48 | TOTAL                              | cec5f268cd02 x86/delay: Introduce TPAUSE delay                     |
|   +32 | TOTAL                              | 46f90c7aad62 x86/delay: Refactor delay_mwaitx() for TPAUSE support |
|   +67 | TEXT                               | 3c40cdb0e93e..cec5f268cd02 (ALL COMMITS)                           |
|   +47 | TEXT                               | cec5f268cd02 x86/delay: Introduce TPAUSE delay                     |
|  +136 | arch/x86/events/zhaoxin/built-in.* | e88248902493 x86/delay: Preparatory code cleanup                   |
|   +98 | delay_halt()                       | 46f90c7aad62 x86/delay: Refactor delay_mwaitx() for TPAUSE support |
|  -126 | delay_mwaitx()                     | 46f90c7aad62 x86/delay: Refactor delay_mwaitx() for TPAUSE support |
+-------+------------------------------------+--------------------------------------------------------------------+

elapsed time: 484m

configs tested: 88
configs skipped: 60

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
i386                             allyesconfig
mips                             allmodconfig
alpha                               defconfig
s390                              allnoconfig
m68k                              allnoconfig
um                                  defconfig
alpha                            allyesconfig
sh                               allmodconfig
openrisc                            defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
mips                             allyesconfig
mips                              allnoconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
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
x86_64               randconfig-a004-20200507
x86_64               randconfig-a006-20200507
x86_64               randconfig-a002-20200507
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc64                             defconfig
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
