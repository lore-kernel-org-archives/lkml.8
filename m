Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000DAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D39DF20643
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgESCGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:06:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:35941 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgESCGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:06:14 -0400
IronPort-SDR: H03rVvYym6DVGCu3BurasZS85kMkAB036JFNhRNl13+kB43eG9jFCY+EIQoDdkzp6esyAp38SC
 jxHer6ufjG2A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 19:06:13 -0700
IronPort-SDR: +ehNVNOjJZquRZsp+oO8BlVBeeDro1NHIO8NuMC2i/eFScXPVzRESjTgNg/vxtOgyDcXpQluJQ
 jFzPDa6K1HBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; 
   d="scan'208";a="439443229"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 May 2020 19:06:12 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jardz-0003V2-EF; Tue, 19 May 2020 10:06:11 +0800
Date:   Tue, 19 May 2020 10:05:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 3d81b3d1e55a518837c3d1f722c6d93abe34aa85
Message-ID: <5ec33f07.b4wJuoPNNmSlrlHY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cpu
branch HEAD: 3d81b3d1e55a518837c3d1f722c6d93abe34aa85  x86/cpu: Use RDRAND and RDSEED mnemonics in archrandom.h

i386-tinyconfig vmlinux size:

+-------+------------------------------------+-----------------------------------------------------------------------+
| DELTA |               SYMBOL               |                                COMMIT                                 |
+-------+------------------------------------+-----------------------------------------------------------------------+
|  +284 | TOTAL                              | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
|  +203 | TOTAL                              | e9d7144597b1 x86/cpu: Add a steppings field to struct x86_cpu_id      |
|  +252 | TEXT                               | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
|  +172 | TEXT                               | e9d7144597b1 x86/cpu: Add a steppings field to struct x86_cpu_id      |
| +1355 | balance_dirty_pages()              | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
|  +615 | __setup_rt_frame()                 | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
|  +160 | init.data                          | e9d7144597b1 x86/cpu: Add a steppings field to struct x86_cpu_id      |
|  +124 | cpu_vuln_whitelist()               | e9d7144597b1 x86/cpu: Add a steppings field to struct x86_cpu_id      |
|  +113 | klist_release()                    | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
|   +93 | change_clocksource()               | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
|   +86 | release_bdi()                      | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
|   +84 | kobject_release()                  | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
|   -68 | bdi_put()                          | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
|   -77 | kobject_put()                      | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
|   -79 | timekeeping_notify()               | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
|   -99 | klist_dec_and_del()                | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 3d81b3d1e55a x86/cpu: Use RDRAND and RDSEED mnemonics in archrandom.h |
|  -555 | do_signal()                        | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
| -1383 | balance_dirty_pages_ratelimited()  | ae83d0b416db..3d81b3d1e55a (ALL COMMITS)                              |
+-------+------------------------------------+-----------------------------------------------------------------------+

elapsed time: 482m

configs tested: 110
configs skipped: 3

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
mips                         tb0219_defconfig
mips                 pnx8335_stb225_defconfig
powerpc                       holly_defconfig
m68k                       bvme6000_defconfig
arm                       multi_v4t_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                       imx_v6_v7_defconfig
mips                        maltaup_defconfig
m68k                            mac_defconfig
um                               alldefconfig
um                                  defconfig
mips                         rt305x_defconfig
sh                            hp6xx_defconfig
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
i386                 randconfig-a006-20200518
i386                 randconfig-a005-20200518
i386                 randconfig-a001-20200518
i386                 randconfig-a003-20200518
i386                 randconfig-a004-20200518
i386                 randconfig-a002-20200518
x86_64               randconfig-a016-20200518
x86_64               randconfig-a012-20200518
x86_64               randconfig-a015-20200518
x86_64               randconfig-a013-20200518
x86_64               randconfig-a011-20200518
x86_64               randconfig-a014-20200518
i386                 randconfig-a012-20200518
i386                 randconfig-a014-20200518
i386                 randconfig-a016-20200518
i386                 randconfig-a011-20200518
i386                 randconfig-a015-20200518
i386                 randconfig-a013-20200518
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
