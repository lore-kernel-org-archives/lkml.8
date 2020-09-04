Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F358C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5EB20709
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgIDIkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:40:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:64482 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgIDIkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:40:31 -0400
IronPort-SDR: y5DrQhgmYU/xjLuUrVOcbyiRKlAckVjPy1cMhx1dhNiAywbHRJ0GB1YF9z7qddlv2ZpRifugdw
 71qXOw28oWKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="156974555"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="156974555"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 01:40:30 -0700
IronPort-SDR: WrD3sY4RqDKc+ad+G1qlt/7orueLhfvZHRYC/JB/WV+VWvp+nTNBCNMgTA2QRoCggjjkt8ZWAF
 FoquEbaOi4XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="326575522"
Received: from lkp-server02.sh.intel.com (HELO c089623da072) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 04 Sep 2020 01:40:29 -0700
Received: from kbuild by c089623da072 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kE7Gm-00002U-Iu; Fri, 04 Sep 2020 08:40:28 +0000
Date:   Fri, 04 Sep 2020 16:39:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/kspp] BUILD SUCCESS WITH WARNING
 cb0938372de0016cb264d87ef862d07868d8dff2
Message-ID: <5f51fd4e.8My+1r5vT25jEb+z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  for-next/kspp
branch HEAD: cb0938372de0016cb264d87ef862d07868d8dff2  Merge branch 'for-next/clang' into for-next/kspp

Warning in current branch:

drivers/gpu/drm/drm_dp_helper.c:495 drm_dp_downstream_max_bpc() warn: ignoring unreachable code.

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-m021-20200902
    `-- drivers-gpu-drm-drm_dp_helper.c-drm_dp_downstream_max_bpc()-warn:ignoring-unreachable-code.

elapsed time: 724m

configs tested: 105
configs skipped: 4

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         cm_x300_defconfig
xtensa                generic_kc705_defconfig
sparc                               defconfig
arm                           spitz_defconfig
powerpc                      pmac32_defconfig
sh                          rsk7203_defconfig
m68k                            q40_defconfig
arm                           sama5_defconfig
mips                     cu1000-neo_defconfig
sh                   sh7770_generic_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                          r7780mp_defconfig
powerpc                          g5_defconfig
um                             i386_defconfig
sh                            shmin_defconfig
sh                          urquell_defconfig
powerpc64                           defconfig
mips                        nlm_xlr_defconfig
powerpc                     mpc512x_defconfig
sh                   sh7724_generic_defconfig
mips                           mtx1_defconfig
arm                           stm32_defconfig
arm                            hisi_defconfig
microblaze                    nommu_defconfig
sh                          lboxre2_defconfig
arm                        spear6xx_defconfig
arc                             nps_defconfig
arm                        keystone_defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200904
i386                 randconfig-a005-20200904
i386                 randconfig-a006-20200904
i386                 randconfig-a002-20200904
i386                 randconfig-a003-20200904
i386                 randconfig-a001-20200904
i386                 randconfig-a016-20200903
i386                 randconfig-a015-20200903
i386                 randconfig-a011-20200903
i386                 randconfig-a013-20200903
i386                 randconfig-a014-20200903
i386                 randconfig-a012-20200903
i386                 randconfig-a016-20200902
i386                 randconfig-a015-20200902
i386                 randconfig-a011-20200902
i386                 randconfig-a013-20200902
i386                 randconfig-a014-20200902
i386                 randconfig-a012-20200902
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20200902
x86_64               randconfig-a006-20200902
x86_64               randconfig-a003-20200902
x86_64               randconfig-a005-20200902
x86_64               randconfig-a001-20200902
x86_64               randconfig-a002-20200902
x86_64               randconfig-a013-20200903
x86_64               randconfig-a016-20200903
x86_64               randconfig-a011-20200903
x86_64               randconfig-a012-20200903
x86_64               randconfig-a015-20200903
x86_64               randconfig-a014-20200903

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
