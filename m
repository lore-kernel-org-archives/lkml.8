Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621CBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 04:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C382078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 04:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFIEjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 00:39:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:4768 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgFIEjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 00:39:17 -0400
IronPort-SDR: OOK9jRk9qij8IwYjftLNQaj5eTw65P+dmvIjbxXrmcvrCmqf3XbsTu2y18pRyBc6a+Jbl8Y9ki
 flAZvtUOknUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 21:39:16 -0700
IronPort-SDR: xjBL8gVvuXTH8rdjogXWjAYxCKa/9woe95ofaqb6owWNVhkSJFx+vhbHb0p90EdpAlAx1l4cv+
 mgnQl2dyTEyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,490,1583222400"; 
   d="scan'208";a="295707984"
Received: from lkp-server01.sh.intel.com (HELO 4b5ef61a2c2e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jun 2020 21:39:15 -0700
Received: from kbuild by 4b5ef61a2c2e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jiW2c-00002a-VV; Tue, 09 Jun 2020 04:39:14 +0000
Date:   Tue, 09 Jun 2020 12:39:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu-tasks.2020.06.08a.v5.6] BUILD SUCCESS
 5366602725fe22519c438d9f69c4af9403256a4a
Message-ID: <5edf126f.jRUdRxoM0vX2ZxQK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu-tasks.2020.06.08a.v5.6
branch HEAD: 5366602725fe22519c438d9f69c4af9403256a4a  ftrace: Use synchronize_rcu_tasks_rude() instead of ftrace_sync()

elapsed time: 483m

configs tested: 98
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm                         shannon_defconfig
arm                         socfpga_defconfig
sh                   sh7724_generic_defconfig
arm                     davinci_all_defconfig
mips                  maltasmvp_eva_defconfig
arm                            xcep_defconfig
arm                         mv78xx0_defconfig
sh                     magicpanelr2_defconfig
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
i386                 randconfig-a001-20200607
i386                 randconfig-a006-20200607
i386                 randconfig-a002-20200607
i386                 randconfig-a005-20200607
i386                 randconfig-a004-20200607
i386                 randconfig-a003-20200607
i386                 randconfig-a015-20200607
i386                 randconfig-a011-20200607
i386                 randconfig-a016-20200607
i386                 randconfig-a012-20200607
i386                 randconfig-a013-20200607
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
