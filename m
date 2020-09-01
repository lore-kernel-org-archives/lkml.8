Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E59AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E902078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgIAVcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:32:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:37062 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgIAVcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 17:32:24 -0400
IronPort-SDR: 6keiERsgdEoStis64q4KVG0O2ycJwnf1rUkzjruLTh4raHQ4NWQN9XNngiDfoFRGeg3221iatH
 6MQUNSWP07wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="145011230"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="145011230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 14:32:22 -0700
IronPort-SDR: ymRizTg7QcSI9HacyoaHP9RTCaYhG1hXyjTkftiXaZXzeqMbrexY2RTxECSL4wxhbqk5Ov2Up/
 IdgdlAmLy0MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="477353658"
Received: from lkp-server02.sh.intel.com (HELO f796b30506bf) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 01 Sep 2020 14:32:21 -0700
Received: from kbuild by f796b30506bf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kDDt6-00006k-Vz; Tue, 01 Sep 2020 21:32:21 +0000
Date:   Wed, 02 Sep 2020 05:32:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/build] BUILD SUCCESS
 414d2ff5e5f21049b6b242271a6a8579f9dffc1b
Message-ID: <5f4ebddd.xfw1Uiu4y5mc0VRY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/build
branch HEAD: 414d2ff5e5f21049b6b242271a6a8579f9dffc1b  x86/boot/compressed: Add missing debugging sections to output

elapsed time: 721m

configs tested: 157
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
arm                       omap2plus_defconfig
m68k                        mvme16x_defconfig
arm                             mxs_defconfig
sh                ecovec24-romimage_defconfig
mips                        nlm_xlp_defconfig
arm                     eseries_pxa_defconfig
arm                      footbridge_defconfig
sh                            migor_defconfig
sh                                  defconfig
um                           x86_64_defconfig
sh                          rsk7264_defconfig
powerpc                      mgcoge_defconfig
sh                          r7780mp_defconfig
sh                           se7712_defconfig
sparc                       sparc64_defconfig
sh                           se7750_defconfig
nios2                         3c120_defconfig
ia64                      gensparse_defconfig
mips                 decstation_r4k_defconfig
riscv                    nommu_k210_defconfig
sh                            shmin_defconfig
arm                       multi_v4t_defconfig
arm                        spear3xx_defconfig
powerpc                     pq2fads_defconfig
i386                                defconfig
mips                      loongson3_defconfig
mips                  maltasmvp_eva_defconfig
mips                      bmips_stb_defconfig
mips                        maltaup_defconfig
arm                        vexpress_defconfig
s390                       zfcpdump_defconfig
arm                         shannon_defconfig
arm                         hackkit_defconfig
arm                        mvebu_v5_defconfig
xtensa                       common_defconfig
m68k                        m5407c3_defconfig
mips                         db1xxx_defconfig
arm                          ixp4xx_defconfig
sh                              ul2_defconfig
sh                         ecovec24_defconfig
arm                            lart_defconfig
arm                      pxa255-idp_defconfig
arm                         mv78xx0_defconfig
arm                         s3c2410_defconfig
arm                              alldefconfig
s390                          debug_defconfig
mips                         tb0219_defconfig
sh                     sh7710voipgw_defconfig
mips                         tb0287_defconfig
mips                     cu1000-neo_defconfig
mips                          malta_defconfig
powerpc                    gamecube_defconfig
arm                        shmobile_defconfig
arm                       imx_v6_v7_defconfig
arm                           stm32_defconfig
arm                       spear13xx_defconfig
m68k                             alldefconfig
mips                      malta_kvm_defconfig
m68k                       m5249evb_defconfig
powerpc                      chrp32_defconfig
arm                         socfpga_defconfig
um                             i386_defconfig
arm                         s5pv210_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
arm                         lubbock_defconfig
xtensa                         virt_defconfig
arm                          moxart_defconfig
arc                              allyesconfig
arm                        magician_defconfig
mips                         bigsur_defconfig
mips                    maltaup_xpa_defconfig
sh                         microdev_defconfig
riscv                    nommu_virt_defconfig
arm                          exynos_defconfig
arm                        neponset_defconfig
m68k                        stmark2_defconfig
nios2                         10m50_defconfig
mips                          rm200_defconfig
arm                          prima2_defconfig
m68k                       m5475evb_defconfig
parisc                           alldefconfig
arm                       cns3420vb_defconfig
powerpc                         wii_defconfig
arm                           tegra_defconfig
mips                      maltasmvp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200901
x86_64               randconfig-a006-20200901
x86_64               randconfig-a003-20200901
x86_64               randconfig-a005-20200901
x86_64               randconfig-a001-20200901
x86_64               randconfig-a002-20200901
i386                 randconfig-a004-20200901
i386                 randconfig-a005-20200901
i386                 randconfig-a006-20200901
i386                 randconfig-a002-20200901
i386                 randconfig-a001-20200901
i386                 randconfig-a003-20200901
i386                 randconfig-a016-20200901
i386                 randconfig-a015-20200901
i386                 randconfig-a011-20200901
i386                 randconfig-a013-20200901
i386                 randconfig-a014-20200901
i386                 randconfig-a012-20200901
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
x86_64               randconfig-a013-20200901
x86_64               randconfig-a016-20200901
x86_64               randconfig-a011-20200901
x86_64               randconfig-a012-20200901
x86_64               randconfig-a015-20200901
x86_64               randconfig-a014-20200901

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
