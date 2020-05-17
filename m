Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF10BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5BEB206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgEQVKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 17:10:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:47389 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbgEQVKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 17:10:15 -0400
IronPort-SDR: +SX/0V4I/5cdTUOPuiEdNPnKIOuqhhtv6cyUpLWEPl2x9MmGNDaosyJrA0Qhs+thOiMB3xSYG4
 2vomjtlsTiOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 14:10:14 -0700
IronPort-SDR: 7PMwZuYeBxTskAainX4UPquFrmSyqsK18fweWJkm76WQ+YRceuVx80QPL679ubS1tn3W3ysybu
 F1+NUlMVeUjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,404,1583222400"; 
   d="scan'208";a="465363206"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 May 2020 14:10:13 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jaQY1-000GoD-4b; Mon, 18 May 2020 05:10:13 +0800
Date:   Mon, 18 May 2020 05:09:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 6648d60543cd73f2bc743ab53ac6d3fabb8b5a4d
Message-ID: <5ec1a826.BvZVGK9xvKtuYk18%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 6648d60543cd73f2bc743ab53ac6d3fabb8b5a4d  Merge branch 'core/core'

elapsed time: 484m

configs tested: 126
configs skipped: 8

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
mips                  cavium_octeon_defconfig
microblaze                          defconfig
powerpc64                        alldefconfig
arm                      integrator_defconfig
arc                     nsimosci_hs_defconfig
s390                                defconfig
powerpc                      ppc6xx_defconfig
m68k                       bvme6000_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                  colibri_pxa300_defconfig
arm                        clps711x_defconfig
mips                  maltasmvp_eva_defconfig
arm                        magician_defconfig
sh                                allnoconfig
mips                          malta_defconfig
arm                         assabet_defconfig
arm                          exynos_defconfig
m68k                                defconfig
sparc64                             defconfig
arm                       multi_v4t_defconfig
sh                        dreamcast_defconfig
powerpc                     skiroot_defconfig
c6x                        evmc6457_defconfig
c6x                        evmc6678_defconfig
arm                        realview_defconfig
sh                             shx3_defconfig
arm                       spear13xx_defconfig
powerpc                    amigaone_defconfig
mips                           mtx1_defconfig
parisc                generic-64bit_defconfig
c6x                         dsk6455_defconfig
sh                           sh2007_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
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
x86_64               randconfig-a005-20200517
x86_64               randconfig-a003-20200517
x86_64               randconfig-a006-20200517
x86_64               randconfig-a004-20200517
x86_64               randconfig-a001-20200517
x86_64               randconfig-a002-20200517
i386                 randconfig-a006-20200517
i386                 randconfig-a005-20200517
i386                 randconfig-a003-20200517
i386                 randconfig-a001-20200517
i386                 randconfig-a004-20200517
i386                 randconfig-a002-20200517
i386                 randconfig-a012-20200517
i386                 randconfig-a016-20200517
i386                 randconfig-a014-20200517
i386                 randconfig-a011-20200517
i386                 randconfig-a013-20200517
i386                 randconfig-a015-20200517
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
x86_64                              defconfig
sparc                            allyesconfig
sparc                               defconfig
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
