Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E94C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C17F20C56
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgESVle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:41:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:44926 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgESVle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:41:34 -0400
IronPort-SDR: N+tCbAD/YQIaX0haWQ+dZpOzQnvdtidtMe1BAmbE8E4DFzM5hJ2tcV4NsHFu3wiNLr9LN8hIIP
 loK/h8NRrETg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 14:41:33 -0700
IronPort-SDR: 176L1nHLkifBP7xOT8nDNOoV4SWzQiVXJAbc2EZPe1hzS7aV+FADfa/tiI8VwNLrhEnIMhHZ08
 1HUZ/7GJFmbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,411,1583222400"; 
   d="scan'208";a="268032056"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2020 14:41:31 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jb9zO-0003SX-L6; Wed, 20 May 2020 05:41:30 +0800
Date:   Wed, 20 May 2020 05:41:23 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 5214028dd89e49ba27007c3ee475279e584261f0
Message-ID: <5ec45283.7H/ZXIjlxQzCaywp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/boot
branch HEAD: 5214028dd89e49ba27007c3ee475279e584261f0  x86/boot: Correct relocation destination on old linkers

i386-tinyconfig vmlinux size:

+-------+-----------------------------------+------------------------------------------+
| DELTA |              SYMBOL               |                  COMMIT                  |
+-------+-----------------------------------+------------------------------------------+
|   +97 | TOTAL                             | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
|   +96 | TEXT                              | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
| +1355 | balance_dirty_pages()             | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
|  +615 | __setup_rt_frame()                | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
|  +113 | klist_release()                   | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
|   +93 | change_clocksource()              | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
|   +86 | release_bdi()                     | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
|   +84 | kobject_release()                 | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
|   -68 | bdi_put()                         | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
|   -77 | kobject_put()                     | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
|   -79 | timekeeping_notify()              | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
|   -99 | klist_dec_and_del()               | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
|  -555 | do_signal()                       | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
| -1383 | balance_dirty_pages_ratelimited() | 6a8b55ed4056..5214028dd89e (ALL COMMITS) |
+-------+-----------------------------------+------------------------------------------+

elapsed time: 484m

configs tested: 94
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm                                 defconfig
arm64                               defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                            allmodconfig
sparc                            allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
mips                        bcm47xx_defconfig
arm                            mps2_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
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
i386                 randconfig-a006-20200519
i386                 randconfig-a005-20200519
i386                 randconfig-a001-20200519
i386                 randconfig-a003-20200519
i386                 randconfig-a004-20200519
i386                 randconfig-a002-20200519
x86_64               randconfig-a003-20200519
x86_64               randconfig-a005-20200519
x86_64               randconfig-a004-20200519
x86_64               randconfig-a006-20200519
x86_64               randconfig-a002-20200519
x86_64               randconfig-a001-20200519
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
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
