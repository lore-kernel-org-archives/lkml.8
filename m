Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F5CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92255207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgETFwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:52:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:50453 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgETFwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:52:04 -0400
IronPort-SDR: haZydlc9YcJTqhdvtxNFn+BKBA3Q1ZiBu+U0TXswybznaLUm86KUaoZ9yRxRgrqDmJpItZNpNL
 fEjXqI9UXciA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 22:52:03 -0700
IronPort-SDR: UqobXSmEwRTjlptyugyavpbdTWpj1ZhPLIJjNN1KtkVe7cqWqZH3AOOCQL2FrBwAP0N8H8NYOA
 QUKnztn5vTHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; 
   d="scan'208";a="282569337"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2020 22:52:01 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jbHe5-00063D-02; Wed, 20 May 2020 13:52:00 +0800
Date:   Wed, 20 May 2020 13:51:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 d505b8af58912ae1e1a211fabc9995b19bd40828
Message-ID: <5ec4c564.tEoeFobhBZzwk409%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  sched/core
branch HEAD: d505b8af58912ae1e1a211fabc9995b19bd40828  sched: Defend cfs and rt bandwidth quota against overflow

i386-tinyconfig vmlinux size:

+-------+------------------------------------+------------------------------------------+
| DELTA |               SYMBOL               |                  COMMIT                  |
+-------+------------------------------------+------------------------------------------+
|  +485 | TOTAL                              | 2a0a24ebb499..d505b8af5891 (ALL COMMITS) |
|  +466 | TOTAL                              | 9013196a467e Merge branch 'sched/urgent' |
|  +410 | TEXT                               | 2a0a24ebb499..d505b8af5891 (ALL COMMITS) |
|  +391 | TEXT                               | 9013196a467e Merge branch 'sched/urgent' |
|   +72 | DATA                               | 9013196a467e Merge branch 'sched/urgent' |
| +1355 | balance_dirty_pages()              | 9013196a467e Merge branch 'sched/urgent' |
|  +615 | __setup_rt_frame()                 | 9013196a467e Merge branch 'sched/urgent' |
|  +113 | klist_release()                    | 9013196a467e Merge branch 'sched/urgent' |
|   +93 | change_clocksource()               | 9013196a467e Merge branch 'sched/urgent' |
|   +86 | release_bdi()                      | 9013196a467e Merge branch 'sched/urgent' |
|   +84 | kobject_release()                  | 9013196a467e Merge branch 'sched/urgent' |
|   +64 | noop_backing_dev_info              | 9013196a467e Merge branch 'sched/urgent' |
|   -68 | bdi_put()                          | 9013196a467e Merge branch 'sched/urgent' |
|   -77 | kobject_put()                      | 9013196a467e Merge branch 'sched/urgent' |
|   -79 | timekeeping_notify()               | 9013196a467e Merge branch 'sched/urgent' |
|   -99 | klist_dec_and_del()                | 9013196a467e Merge branch 'sched/urgent' |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 9013196a467e Merge branch 'sched/urgent' |
|  -555 | do_signal()                        | 9013196a467e Merge branch 'sched/urgent' |
| -1383 | balance_dirty_pages_ratelimited()  | 9013196a467e Merge branch 'sched/urgent' |
+-------+------------------------------------+------------------------------------------+

elapsed time: 487m

configs tested: 98
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
sparc                            allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
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
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
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
i386                 randconfig-a012-20200519
i386                 randconfig-a014-20200519
i386                 randconfig-a016-20200519
i386                 randconfig-a011-20200519
i386                 randconfig-a015-20200519
i386                 randconfig-a013-20200519
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
