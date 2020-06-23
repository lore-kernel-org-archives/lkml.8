Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5240C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A732076A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbgFWDWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 23:22:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:12011 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731706AbgFWDWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 23:22:33 -0400
IronPort-SDR: oNAINDhuAGM516EY6u4zGc80P9PomFZiHMURVfEBSnN9EGiPjCYfv6J8FFrhb7dAAILrJBKUi5
 X9SOhsadhPBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="131361050"
X-IronPort-AV: E=Sophos;i="5.75,269,1589266800"; 
   d="scan'208";a="131361050"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 20:22:30 -0700
IronPort-SDR: +hW+LxONlNml7B4wiQdck9Zu0nKwAcK8/6Hgd+5LHH0yBRngSAgB+UT02dC4EwXv/g0q5nY71e
 csMRo/oK0UnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,269,1589266800"; 
   d="scan'208";a="293059795"
Received: from lkp-server01.sh.intel.com (HELO f484c95e4fd1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2020 20:22:29 -0700
Received: from kbuild by f484c95e4fd1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jnZW0-0000aG-HO; Tue, 23 Jun 2020 03:22:28 +0000
Date:   Tue, 23 Jun 2020 11:22:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 99e40204e014e06644072c39001a269d9689e0d1
Message-ID: <5ef1755c.GU1RLv2sOZdYeBKj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 99e40204e014e06644072c39001a269d9689e0d1  x86/msr: Move the F15h MSRs where they belong

elapsed time: 722m

configs tested: 127
configs skipped: 48

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
nds32                            alldefconfig
mips                         mpc30x_defconfig
arm                            dove_defconfig
arm                          lpd270_defconfig
arm                           corgi_defconfig
arm                        realview_defconfig
xtensa                           allyesconfig
arm                            mmp2_defconfig
mips                malta_kvm_guest_defconfig
arm                         s3c6400_defconfig
xtensa                           alldefconfig
sh                  sh7785lcr_32bit_defconfig
parisc                           alldefconfig
mips                malta_qemu_32r6_defconfig
arc                    vdk_hs38_smp_defconfig
arm                       netwinder_defconfig
mips                          ath79_defconfig
sh                           se7724_defconfig
powerpc64                           defconfig
arm                       versatile_defconfig
arm                        multi_v5_defconfig
ia64                             allyesconfig
xtensa                    xip_kc705_defconfig
arm                        keystone_defconfig
m68k                            mac_defconfig
sh                           sh2007_defconfig
arm                           efm32_defconfig
m68k                             alldefconfig
m68k                         apollo_defconfig
powerpc                     pseries_defconfig
sh                        sh7785lcr_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
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
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
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
x86_64               randconfig-a004-20200622
x86_64               randconfig-a002-20200622
x86_64               randconfig-a003-20200622
x86_64               randconfig-a005-20200622
x86_64               randconfig-a001-20200622
x86_64               randconfig-a006-20200622
i386                 randconfig-a006-20200622
i386                 randconfig-a002-20200622
i386                 randconfig-a003-20200622
i386                 randconfig-a001-20200622
i386                 randconfig-a005-20200622
i386                 randconfig-a004-20200622
i386                 randconfig-a013-20200622
i386                 randconfig-a016-20200622
i386                 randconfig-a012-20200622
i386                 randconfig-a014-20200622
i386                 randconfig-a015-20200622
i386                 randconfig-a011-20200622
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
