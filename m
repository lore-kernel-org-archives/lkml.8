Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1D1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3BF62087D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHXLBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:01:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:6052 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgHXLBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:01:10 -0400
IronPort-SDR: GuGpA6V+mkAFiDz3D306ChD1Ge/A55Hfupkwr5MFwNSko677nxu2b9dl4ocpZxlgrBbueYDGAz
 RJP/SBomZq+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="155133956"
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="155133956"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 04:01:09 -0700
IronPort-SDR: oMsjOCIEV053hHPecxYkjTxeHLvzzfYB0Tz7AdejFDNPSnsjdmNWjQ2Xs8pDrbkyEyd3nX5URY
 Vz/svkvX+Pgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="294558350"
Received: from lkp-server01.sh.intel.com (HELO c420d4f0765f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Aug 2020 04:01:07 -0700
Received: from kbuild by c420d4f0765f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kAADr-00005l-2U; Mon, 24 Aug 2020 11:01:07 +0000
Date:   Mon, 24 Aug 2020 19:00:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/fallthrough] BUILD SUCCESS
 df561f6688fef775baa341a0f5d960becd248b11
Message-ID: <5f439dc0.UziH39z9YtuR8FCr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/fallthrough
branch HEAD: df561f6688fef775baa341a0f5d960becd248b11  treewide: Use fallthrough pseudo-keyword

elapsed time: 722m

configs tested: 129
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                             alldefconfig
arc                        vdk_hs38_defconfig
arm                           u8500_defconfig
sh                     sh7710voipgw_defconfig
mips                      maltasmvp_defconfig
mips                           jazz_defconfig
c6x                         dsk6455_defconfig
arm                         lpc32xx_defconfig
arm                      integrator_defconfig
arm                           sunxi_defconfig
xtensa                         virt_defconfig
powerpc                      mgcoge_defconfig
ia64                          tiger_defconfig
sh                        dreamcast_defconfig
xtensa                           alldefconfig
mips                     loongson1b_defconfig
m68k                             allmodconfig
arm                         mv78xx0_defconfig
sh                          landisk_defconfig
powerpc                     ep8248e_defconfig
mips                       rbtx49xx_defconfig
m68k                           sun3_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                          alldefconfig
m68k                         amcore_defconfig
mips                        vocore2_defconfig
powerpc                     mpc5200_defconfig
mips                     cu1830-neo_defconfig
sh                 kfr2r09-romimage_defconfig
c6x                        evmc6678_defconfig
arm                        mvebu_v7_defconfig
h8300                            alldefconfig
sh                          polaris_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     mpc83xx_defconfig
mips                      loongson3_defconfig
arm                            zeus_defconfig
arm                              zx_defconfig
arc                              alldefconfig
arm                          badge4_defconfig
sh                          sdk7780_defconfig
sh                          r7785rp_defconfig
arm                             rpc_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7724_defconfig
mips                         db1xxx_defconfig
arm                           spitz_defconfig
arm                       multi_v4t_defconfig
powerpc                         ps3_defconfig
riscv                    nommu_k210_defconfig
arc                        nsimosci_defconfig
sh                           se7721_defconfig
sparc                               defconfig
m68k                            q40_defconfig
arm                           stm32_defconfig
x86_64                           alldefconfig
sparc                       sparc64_defconfig
mips                           gcw0_defconfig
mips                 pnx8335_stb225_defconfig
sh                         apsh4a3a_defconfig
arm                       versatile_defconfig
arm                             ezx_defconfig
arm                           efm32_defconfig
arm                            pleb_defconfig
c6x                        evmc6474_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a002-20200824
i386                 randconfig-a004-20200824
i386                 randconfig-a005-20200824
i386                 randconfig-a003-20200824
i386                 randconfig-a006-20200824
i386                 randconfig-a001-20200824
x86_64               randconfig-a015-20200824
x86_64               randconfig-a016-20200824
x86_64               randconfig-a012-20200824
x86_64               randconfig-a014-20200824
x86_64               randconfig-a011-20200824
x86_64               randconfig-a013-20200824
i386                 randconfig-a013-20200824
i386                 randconfig-a012-20200824
i386                 randconfig-a011-20200824
i386                 randconfig-a016-20200824
i386                 randconfig-a015-20200824
i386                 randconfig-a014-20200824
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
