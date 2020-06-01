Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB42C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBEC2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgFAFTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:19:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:61700 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFAFTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:19:01 -0400
IronPort-SDR: /11biu3XvXI4E8XVhWsGUTtOXGlpJ/O3VIXwxr6B5aW/zxx2TfNfWwMBq0xAbL71itHB988XfB
 Xb9uiAlCz+kg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:19:01 -0700
IronPort-SDR: jtdHF+iEdturQTb17iAbw4CYPLyFIRS9iWMyK5rNbKxd/t5mTf+IT0QoOHiYJh+vsUr9qbyW5J
 1G8M/PlDPycg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="470167852"
Received: from lkp-server01.sh.intel.com (HELO 49d03d9b0ee7) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 May 2020 22:19:00 -0700
Received: from kbuild by 49d03d9b0ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfcqh-0000E0-Ex; Mon, 01 Jun 2020 05:18:59 +0000
Date:   Mon, 01 Jun 2020 13:18:11 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:WIP.locking/core] BUILD SUCCESS
 19f545b6e07f753c4dc639c2f0ab52345733b6a8
Message-ID: <5ed48f93.gv+bfRsBeTAnL55u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  WIP.locking/core
branch HEAD: 19f545b6e07f753c4dc639c2f0ab52345733b6a8  zram: Use local lock to protect per-CPU data

elapsed time: 5454m

configs tested: 126
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                              allyesconfig
arm                              allmodconfig
sparc                       sparc64_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
powerpc                      pasemi_defconfig
h8300                            allyesconfig
sh                             sh03_defconfig
sh                           se7343_defconfig
arm                          badge4_defconfig
sh                           se7780_defconfig
xtensa                         virt_defconfig
arm                   milbeaut_m10v_defconfig
arm                          lpd270_defconfig
sh                          rsk7269_defconfig
mips                             allyesconfig
ia64                        generic_defconfig
m68k                            q40_defconfig
sh                           se7724_defconfig
mips                malta_qemu_32r6_defconfig
mips                            e55_defconfig
mips                       lemote2f_defconfig
arm                            pleb_defconfig
sh                             espt_defconfig
arm                           omap1_defconfig
arm                       spear13xx_defconfig
sparc64                          allyesconfig
microblaze                    nommu_defconfig
arc                          axs101_defconfig
powerpc                       maple_defconfig
nds32                             allnoconfig
sh                               allmodconfig
arm                        mvebu_v5_defconfig
arc                        nsim_700_defconfig
arm                        mvebu_v7_defconfig
mips                      maltaaprp_defconfig
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
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                              allyesconfig
sh                                allnoconfig
arc                                 defconfig
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
i386                 randconfig-a004-20200529
i386                 randconfig-a001-20200529
i386                 randconfig-a002-20200529
i386                 randconfig-a006-20200529
i386                 randconfig-a003-20200529
i386                 randconfig-a005-20200529
x86_64               randconfig-a002-20200529
x86_64               randconfig-a006-20200529
x86_64               randconfig-a005-20200529
x86_64               randconfig-a001-20200529
x86_64               randconfig-a004-20200529
x86_64               randconfig-a003-20200529
i386                 randconfig-a013-20200529
i386                 randconfig-a011-20200529
i386                 randconfig-a012-20200529
i386                 randconfig-a015-20200529
i386                 randconfig-a016-20200529
i386                 randconfig-a014-20200529
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
s390                              allnoconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
um                               allmodconfig
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
