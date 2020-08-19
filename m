Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC57C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BFE20657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgHSAtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:49:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:53238 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbgHSAtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 20:49:22 -0400
IronPort-SDR: QodW6lTM88M5lb4s54hMdHAhQNa5TXL5qZsMxMmpA1A8TGkW7JXc5r66EwuCWcLslPzE4DIy/v
 eInnigaY387Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="154995741"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="154995741"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 17:49:14 -0700
IronPort-SDR: Z3hh+sU+VOyEIFBqBMektvPydshYXLHR4bT5YxxiHa0OGI+c+8WQx+7JCCcTE8xJ+SQixnGAZn
 mVNfnQ20rF6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="297034711"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2020 17:49:13 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k8CHw-0001WB-Jc; Wed, 19 Aug 2020 00:49:12 +0000
Date:   Wed, 19 Aug 2020 08:48:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 527afc212231ea9d585b7709c0ab73263ecf0c85
Message-ID: <5f3c76c4.WcMwmlV6Yqazx6yk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/boot
branch HEAD: 527afc212231ea9d585b7709c0ab73263ecf0c85  x86/boot: Check that there are no run-time relocations

elapsed time: 4041m

configs tested: 203
configs skipped: 27

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
powerpc                     pq2fads_defconfig
sh                        edosk7705_defconfig
sh                           se7705_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
arm                          ep93xx_defconfig
arm                         lpc32xx_defconfig
sh                        apsh4ad0a_defconfig
arm                            hisi_defconfig
ia64                             allyesconfig
riscv                    nommu_k210_defconfig
powerpc                       holly_defconfig
arm                          collie_defconfig
m68k                        stmark2_defconfig
powerpc                         ps3_defconfig
h8300                     edosk2674_defconfig
sh                          urquell_defconfig
ia64                        generic_defconfig
ia64                          tiger_defconfig
csky                                defconfig
arc                          axs101_defconfig
powerpc                    amigaone_defconfig
arm                      tct_hammer_defconfig
arm                         lubbock_defconfig
sh                        edosk7760_defconfig
sh                           se7712_defconfig
arm                         s5pv210_defconfig
arm                        mvebu_v7_defconfig
um                           x86_64_defconfig
sh                           se7724_defconfig
sh                               allmodconfig
mips                           rs90_defconfig
powerpc                      ppc64e_defconfig
sh                         ecovec24_defconfig
sh                          r7780mp_defconfig
arm                           omap1_defconfig
powerpc                    gamecube_defconfig
m68k                          amiga_defconfig
ia64                             alldefconfig
arm                         ebsa110_defconfig
sparc                               defconfig
m68k                       m5275evb_defconfig
ia64                      gensparse_defconfig
h8300                       h8s-sim_defconfig
sh                             sh03_defconfig
arc                        nsim_700_defconfig
powerpc                    adder875_defconfig
nds32                             allnoconfig
mips                          rb532_defconfig
powerpc                     mpc83xx_defconfig
mips                      malta_kvm_defconfig
sparc                            alldefconfig
mips                       capcella_defconfig
powerpc                      ppc6xx_defconfig
arm                             mxs_defconfig
mips                        omega2p_defconfig
mips                       rbtx49xx_defconfig
mips                         cobalt_defconfig
mips                malta_kvm_guest_defconfig
arm                          pcm027_defconfig
ia64                            zx1_defconfig
mips                         mpc30x_defconfig
alpha                               defconfig
arm                           tegra_defconfig
arm                         s3c2410_defconfig
m68k                          hp300_defconfig
arm                        clps711x_defconfig
mips                      pic32mzda_defconfig
mips                      maltasmvp_defconfig
arm                           sunxi_defconfig
x86_64                           alldefconfig
riscv                    nommu_virt_defconfig
powerpc                      pmac32_defconfig
arm                      footbridge_defconfig
mips                        nlm_xlr_defconfig
microblaze                      mmu_defconfig
arm                        oxnas_v6_defconfig
arm                       aspeed_g4_defconfig
mips                          ath79_defconfig
nios2                               defconfig
arm                        spear6xx_defconfig
arc                         haps_hs_defconfig
sh                        dreamcast_defconfig
sh                               j2_defconfig
sh                             espt_defconfig
h8300                    h8300h-sim_defconfig
mips                  decstation_64_defconfig
arm                       imx_v4_v5_defconfig
arm                       omap2plus_defconfig
powerpc64                           defconfig
arm                          lpd270_defconfig
sh                          kfr2r09_defconfig
sh                          sdk7786_defconfig
arm                           spitz_defconfig
powerpc                        cell_defconfig
powerpc                      ppc44x_defconfig
m68k                       m5208evb_defconfig
arm                   milbeaut_m10v_defconfig
c6x                        evmc6472_defconfig
sh                           sh2007_defconfig
mips                        nlm_xlp_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
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
x86_64               randconfig-a006-20200817
x86_64               randconfig-a001-20200817
x86_64               randconfig-a005-20200817
x86_64               randconfig-a003-20200817
x86_64               randconfig-a002-20200817
x86_64               randconfig-a004-20200817
i386                 randconfig-a005-20200817
i386                 randconfig-a001-20200817
i386                 randconfig-a002-20200817
i386                 randconfig-a003-20200817
i386                 randconfig-a006-20200817
i386                 randconfig-a004-20200817
i386                 randconfig-a005-20200816
i386                 randconfig-a001-20200816
i386                 randconfig-a002-20200816
i386                 randconfig-a003-20200816
i386                 randconfig-a006-20200816
i386                 randconfig-a004-20200816
i386                 randconfig-a005-20200818
i386                 randconfig-a002-20200818
i386                 randconfig-a001-20200818
i386                 randconfig-a006-20200818
i386                 randconfig-a003-20200818
i386                 randconfig-a004-20200818
x86_64               randconfig-a013-20200818
x86_64               randconfig-a016-20200818
x86_64               randconfig-a012-20200818
x86_64               randconfig-a011-20200818
x86_64               randconfig-a014-20200818
x86_64               randconfig-a015-20200818
x86_64               randconfig-a013-20200816
x86_64               randconfig-a012-20200816
x86_64               randconfig-a016-20200816
x86_64               randconfig-a011-20200816
x86_64               randconfig-a014-20200816
x86_64               randconfig-a015-20200816
i386                 randconfig-a016-20200817
i386                 randconfig-a011-20200817
i386                 randconfig-a013-20200817
i386                 randconfig-a015-20200817
i386                 randconfig-a014-20200817
i386                 randconfig-a012-20200817
i386                 randconfig-a016-20200816
i386                 randconfig-a011-20200816
i386                 randconfig-a013-20200816
i386                 randconfig-a015-20200816
i386                 randconfig-a014-20200816
i386                 randconfig-a012-20200816
i386                 randconfig-a016-20200818
i386                 randconfig-a011-20200818
i386                 randconfig-a015-20200818
i386                 randconfig-a013-20200818
i386                 randconfig-a012-20200818
i386                 randconfig-a014-20200818
x86_64               randconfig-a006-20200819
x86_64               randconfig-a001-20200819
x86_64               randconfig-a003-20200819
x86_64               randconfig-a005-20200819
x86_64               randconfig-a004-20200819
x86_64               randconfig-a002-20200819
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
