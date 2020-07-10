Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E352BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A3F2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGJFp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 01:45:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:8821 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgGJFp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:45:58 -0400
IronPort-SDR: w6d9pamLU2loniUPy6x4isGsok4kWBb9VKHDr/N9eaJHRMxtrqnCzXXLnwHfZp2a99QhFN7Xta
 TSe9DEKVAYdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="213043203"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="213043203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 22:45:57 -0700
IronPort-SDR: 3lzHHSmVB3M60izl6pInT9zZ5MZS3Cr0pw8YBzQPlR03N2bCTiSqZNdN3/Zu93ySTMu+1ZtQWl
 GpNu7LPOQWqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="389383213"
Received: from lkp-server02.sh.intel.com (HELO 0fc60ea15964) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jul 2020 22:45:45 -0700
Received: from kbuild by 0fc60ea15964 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtlqy-00002U-FW; Fri, 10 Jul 2020 05:45:44 +0000
Date:   Fri, 10 Jul 2020 13:45:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.07.09a] BUILD SUCCESS
 f40a25f3eefe71e02df81089e3331eb271ff55be
Message-ID: <5f080067.vb+ijlbLV2xUEmhl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.07.09a
branch HEAD: f40a25f3eefe71e02df81089e3331eb271ff55be  squash! scftorture: Add smp_call_function_single() memory-ordering checks

elapsed time: 722m

configs tested: 106
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                               defconfig
mips                         rt305x_defconfig
sh                                  defconfig
nios2                            alldefconfig
m68k                         apollo_defconfig
mips                        omega2p_defconfig
powerpc                     mpc512x_defconfig
arm                        spear6xx_defconfig
m68k                       m5249evb_defconfig
arm                        multi_v7_defconfig
powerpc                       holly_defconfig
x86_64                              defconfig
arm                         ebsa110_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      ep88xc_defconfig
arm                         at91_dt_defconfig
m68k                          hp300_defconfig
powerpc                  mpc866_ads_defconfig
powerpc64                           defconfig
um                             i386_defconfig
openrisc                         allyesconfig
sh                        edosk7705_defconfig
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
i386                 randconfig-a002-20200709
i386                 randconfig-a001-20200709
i386                 randconfig-a006-20200709
i386                 randconfig-a005-20200709
i386                 randconfig-a004-20200709
i386                 randconfig-a003-20200709
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
um                               allyesconfig
um                                allnoconfig
um                                  defconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
