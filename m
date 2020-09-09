Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76395C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D6B2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIIFdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:33:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:34317 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIFdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:33:41 -0400
IronPort-SDR: sq4MHifeGwk7Y1dwJvHKXEWdSbvoe7/rLwc7NZLvbhxXDk4EMrzwTm7vP8Gw+KwwD09cc5WisW
 3G2+1Q2ue1Ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="219830130"
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="219830130"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 22:33:39 -0700
IronPort-SDR: 2rbFnqxom2SN1wqdhm3foc6JhRkXBKtUHrTQpAgxGO5BhFYbti0TrEDGxF0jIgaV4FaTE8MGM6
 1LwHAgABXL/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="300035011"
Received: from lkp-server01.sh.intel.com (HELO 12ff3cf3f2e9) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Sep 2020 22:33:34 -0700
Received: from kbuild by 12ff3cf3f2e9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kFsjb-00002O-Me; Wed, 09 Sep 2020 05:33:31 +0000
Date:   Wed, 09 Sep 2020 13:33:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 d3f3d87569786ca7c672fe75af446ab346455682
Message-ID: <5f586912.JhZsVvdYGVQUs+vE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: d3f3d87569786ca7c672fe75af446ab346455682  rcu: Panic after fixed number of stalls

elapsed time: 723m

configs tested: 166
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
powerpc                    adder875_defconfig
mips                            ar7_defconfig
arm                           omap1_defconfig
sh                           se7619_defconfig
mips                           ip28_defconfig
mips                          malta_defconfig
powerpc                       holly_defconfig
arm                        mvebu_v7_defconfig
arc                     nsimosci_hs_defconfig
sh                        sh7763rdp_defconfig
sh                          r7785rp_defconfig
mips                           rs90_defconfig
m68k                       m5275evb_defconfig
arm                          exynos_defconfig
m68k                       m5475evb_defconfig
mips                     decstation_defconfig
i386                                defconfig
h8300                    h8300h-sim_defconfig
arm                            zeus_defconfig
sh                           se7705_defconfig
riscv                    nommu_k210_defconfig
arm                       spear13xx_defconfig
mips                         tb0287_defconfig
riscv                            alldefconfig
m68k                         amcore_defconfig
arm                           h5000_defconfig
sh                          lboxre2_defconfig
sh                                  defconfig
arm                              zx_defconfig
arm                  colibri_pxa270_defconfig
arm                          pxa168_defconfig
arm                        spear6xx_defconfig
ia64                          tiger_defconfig
microblaze                      mmu_defconfig
powerpc                     mpc512x_defconfig
arm                          collie_defconfig
arm                          moxart_defconfig
mips                     cu1000-neo_defconfig
arc                            hsdk_defconfig
powerpc                          allmodconfig
s390                                defconfig
arm                         hackkit_defconfig
powerpc                 linkstation_defconfig
arm                      footbridge_defconfig
xtensa                              defconfig
nios2                         3c120_defconfig
arm                       aspeed_g5_defconfig
h8300                            allyesconfig
sh                 kfr2r09-romimage_defconfig
sh                         microdev_defconfig
mips                            gpr_defconfig
powerpc                         ps3_defconfig
arc                        vdk_hs38_defconfig
arm                        trizeps4_defconfig
arc                          axs101_defconfig
sh                        apsh4ad0a_defconfig
xtensa                generic_kc705_defconfig
sparc                               defconfig
parisc                generic-32bit_defconfig
arm                         s5pv210_defconfig
h8300                               defconfig
c6x                        evmc6472_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200907
x86_64               randconfig-a004-20200907
x86_64               randconfig-a003-20200907
x86_64               randconfig-a005-20200907
x86_64               randconfig-a001-20200907
x86_64               randconfig-a002-20200907
i386                 randconfig-a004-20200908
i386                 randconfig-a005-20200908
i386                 randconfig-a006-20200908
i386                 randconfig-a002-20200908
i386                 randconfig-a001-20200908
i386                 randconfig-a003-20200908
i386                 randconfig-a004-20200907
i386                 randconfig-a005-20200907
i386                 randconfig-a006-20200907
i386                 randconfig-a002-20200907
i386                 randconfig-a003-20200907
i386                 randconfig-a001-20200907
i386                 randconfig-a004-20200909
i386                 randconfig-a005-20200909
i386                 randconfig-a006-20200909
i386                 randconfig-a002-20200909
i386                 randconfig-a001-20200909
i386                 randconfig-a003-20200909
x86_64               randconfig-a013-20200908
x86_64               randconfig-a016-20200908
x86_64               randconfig-a011-20200908
x86_64               randconfig-a012-20200908
x86_64               randconfig-a015-20200908
x86_64               randconfig-a014-20200908
i386                 randconfig-a016-20200907
i386                 randconfig-a015-20200907
i386                 randconfig-a011-20200907
i386                 randconfig-a013-20200907
i386                 randconfig-a014-20200907
i386                 randconfig-a012-20200907
i386                 randconfig-a016-20200908
i386                 randconfig-a015-20200908
i386                 randconfig-a011-20200908
i386                 randconfig-a013-20200908
i386                 randconfig-a014-20200908
i386                 randconfig-a012-20200908
i386                 randconfig-a016-20200909
i386                 randconfig-a015-20200909
i386                 randconfig-a011-20200909
i386                 randconfig-a013-20200909
i386                 randconfig-a014-20200909
i386                 randconfig-a012-20200909
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                               defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20200908
x86_64               randconfig-a006-20200908
x86_64               randconfig-a003-20200908
x86_64               randconfig-a001-20200908
x86_64               randconfig-a005-20200908
x86_64               randconfig-a002-20200908
x86_64               randconfig-a013-20200909
x86_64               randconfig-a016-20200909
x86_64               randconfig-a011-20200909
x86_64               randconfig-a012-20200909
x86_64               randconfig-a015-20200909
x86_64               randconfig-a014-20200909

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
