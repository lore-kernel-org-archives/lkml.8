Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154D1C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB819208B3
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 15:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgIEPjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 11:39:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:31934 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbgIEPiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 11:38:18 -0400
IronPort-SDR: kJlxygLw+Z4e67Xj4AdwmUIrj4E/w9eGmCH13CKK6PZzhkQMuk1SSn4omWxKeptO6DW1VNimzH
 Qo+EeJ7JjEUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="155269136"
X-IronPort-AV: E=Sophos;i="5.76,394,1592895600"; 
   d="scan'208";a="155269136"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2020 08:38:08 -0700
IronPort-SDR: dMeQCOEO02VcL3gAx3XQImn4654P4ytx9Fc4Ytp+Mmjs4JM9nEoydnn7YftGmJVu6xAbYrcnmt
 PA4ITNLnazMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,394,1592895600"; 
   d="scan'208";a="503940016"
Received: from lkp-server02.sh.intel.com (HELO c089623da072) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2020 08:38:07 -0700
Received: from kbuild by c089623da072 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kEaGU-0000Ge-DW; Sat, 05 Sep 2020 15:38:06 +0000
Date:   Sat, 05 Sep 2020 23:37:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 60fd60941f88ef4dd448ecdf3e664986974639e6
Message-ID: <5f53b0b1.J8jQ0WLhsxXnfjj6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 60fd60941f88ef4dd448ecdf3e664986974639e6  rcu: Panic after fixed number of stalls

elapsed time: 767m

configs tested: 111
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                 nsimosci_hs_smp_defconfig
m68k                          atari_defconfig
mips                     loongson1c_defconfig
mips                       bmips_be_defconfig
xtensa                              defconfig
mips                      maltaaprp_defconfig
nios2                               defconfig
sh                           se7751_defconfig
m68k                         apollo_defconfig
sh                        edosk7760_defconfig
arc                         haps_hs_defconfig
arm                              zx_defconfig
powerpc                      ppc64e_defconfig
arm                       imx_v6_v7_defconfig
parisc                           allyesconfig
sh                         ecovec24_defconfig
h8300                            allyesconfig
arm                      footbridge_defconfig
arm                          iop32x_defconfig
xtensa                       common_defconfig
arc                     haps_hs_smp_defconfig
arm                      tct_hammer_defconfig
sh                             sh03_defconfig
mips                      loongson3_defconfig
sh                        edosk7705_defconfig
powerpc                           allnoconfig
arc                              allyesconfig
sh                   sh7724_generic_defconfig
riscv                             allnoconfig
ia64                         bigsur_defconfig
arc                     nsimosci_hs_defconfig
sh                           se7750_defconfig
mips                      fuloong2e_defconfig
powerpc                       ppc64_defconfig
arm                         palmz72_defconfig
s390                             alldefconfig
arm                  colibri_pxa270_defconfig
xtensa                           allyesconfig
mips                            ar7_defconfig
mips                           xway_defconfig
m68k                       m5275evb_defconfig
arm                            qcom_defconfig
openrisc                         alldefconfig
m68k                        stmark2_defconfig
powerpc                      ep88xc_defconfig
mips                          ath25_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20200905
x86_64               randconfig-a004-20200905
x86_64               randconfig-a003-20200905
x86_64               randconfig-a005-20200905
x86_64               randconfig-a001-20200905
x86_64               randconfig-a002-20200905
i386                 randconfig-a004-20200904
i386                 randconfig-a005-20200904
i386                 randconfig-a006-20200904
i386                 randconfig-a002-20200904
i386                 randconfig-a003-20200904
i386                 randconfig-a001-20200904
x86_64               randconfig-a013-20200904
x86_64               randconfig-a011-20200904
x86_64               randconfig-a016-20200904
x86_64               randconfig-a012-20200904
x86_64               randconfig-a015-20200904
x86_64               randconfig-a014-20200904
i386                 randconfig-a016-20200904
i386                 randconfig-a015-20200904
i386                 randconfig-a011-20200904
i386                 randconfig-a013-20200904
i386                 randconfig-a014-20200904
i386                 randconfig-a012-20200904
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
