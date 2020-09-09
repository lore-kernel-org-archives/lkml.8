Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE67C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D74521D81
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIIVd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:33:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:27957 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgIIVdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:33:54 -0400
IronPort-SDR: L9NSu7kcG1LXU2D61mf6YeFFqGzU+5BkIhDD42Vr+nikDZLGyU4u6oa4+HEPUp7+wmEe8HVqCz
 ayveLKMI2Zhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="158457658"
X-IronPort-AV: E=Sophos;i="5.76,410,1592895600"; 
   d="scan'208";a="158457658"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 14:33:53 -0700
IronPort-SDR: RdHY684MHQEzDNAW4czVydLm6rRg18+Z2DMfO3ev7esR7vLJc2dDMNd/3Z9YpABoMUgPCKtbl9
 E8SKb1pbkj/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,410,1592895600"; 
   d="scan'208";a="304647811"
Received: from lkp-server01.sh.intel.com (HELO 12ff3cf3f2e9) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Sep 2020 14:33:52 -0700
Received: from kbuild by 12ff3cf3f2e9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kG7ix-0000bV-Ul; Wed, 09 Sep 2020 21:33:51 +0000
Date:   Thu, 10 Sep 2020 05:33:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 76366050eb1b3151c4b4110c76538ff14dffb74c
Message-ID: <5f594a2c.cUU5DZ6hCHCZkgPa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: 76366050eb1b3151c4b4110c76538ff14dffb74c  x86/defconfigs: Explicitly unset CONFIG_64BIT in i386_defconfig

elapsed time: 720m

configs tested: 154
configs skipped: 77

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                             mxs_defconfig
powerpc                     mpc5200_defconfig
sh                   sh7724_generic_defconfig
c6x                              allyesconfig
arm                          simpad_defconfig
mips                malta_kvm_guest_defconfig
mips                         db1xxx_defconfig
mips                          rm200_defconfig
arm                        vexpress_defconfig
mips                         tb0226_defconfig
mips                      maltasmvp_defconfig
h8300                       h8s-sim_defconfig
mips                      fuloong2e_defconfig
sh                         apsh4a3a_defconfig
arm                      footbridge_defconfig
sh                         ecovec24_defconfig
i386                             allyesconfig
c6x                        evmc6678_defconfig
c6x                        evmc6472_defconfig
sh                            shmin_defconfig
powerpc                        cell_defconfig
powerpc                     powernv_defconfig
powerpc                      mgcoge_defconfig
arm                        neponset_defconfig
m68k                        stmark2_defconfig
mips                      loongson3_defconfig
arm                          lpd270_defconfig
mips                         cobalt_defconfig
sh                     magicpanelr2_defconfig
arm                       mainstone_defconfig
mips                           mtx1_defconfig
sh                          r7785rp_defconfig
arc                           tb10x_defconfig
arm                        spear3xx_defconfig
arm                            zeus_defconfig
sh                           se7705_defconfig
riscv                    nommu_k210_defconfig
arm                       spear13xx_defconfig
arc                              allyesconfig
h8300                               defconfig
arm                         lpc18xx_defconfig
mips                           jazz_defconfig
m68k                       m5249evb_defconfig
parisc                generic-32bit_defconfig
arm                         assabet_defconfig
arm                            dove_defconfig
mips                         bigsur_defconfig
mips                     cu1000-neo_defconfig
arm                          pxa910_defconfig
openrisc                         alldefconfig
c6x                         dsk6455_defconfig
mips                 decstation_r4k_defconfig
mips                  maltasmvp_eva_defconfig
sh                            titan_defconfig
mips                        vocore2_defconfig
arm                    vt8500_v6_v7_defconfig
arm                  colibri_pxa300_defconfig
xtensa                generic_kc705_defconfig
arm                         s3c2410_defconfig
um                            kunit_defconfig
sh                          polaris_defconfig
m68k                        mvme16x_defconfig
openrisc                 simple_smp_defconfig
arm                        shmobile_defconfig
arm64                            alldefconfig
mips                           rs90_defconfig
mips                          ath25_defconfig
sh                         ap325rxa_defconfig
arm                        mvebu_v7_defconfig
arm                          collie_defconfig
sh                              ul2_defconfig
m68k                          multi_defconfig
arm                         nhk8815_defconfig
powerpc                  mpc885_ads_defconfig
mips                           ip28_defconfig
sh                          landisk_defconfig
arc                     haps_hs_smp_defconfig
arm                           tegra_defconfig
x86_64                           alldefconfig
arc                        nsim_700_defconfig
arm                        multi_v7_defconfig
arm                      jornada720_defconfig
sh                           se7206_defconfig
xtensa                    xip_kc705_defconfig
mips                          rb532_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200909
x86_64               randconfig-a006-20200909
x86_64               randconfig-a003-20200909
x86_64               randconfig-a001-20200909
x86_64               randconfig-a005-20200909
x86_64               randconfig-a002-20200909
i386                 randconfig-a004-20200909
i386                 randconfig-a005-20200909
i386                 randconfig-a006-20200909
i386                 randconfig-a002-20200909
i386                 randconfig-a001-20200909
i386                 randconfig-a003-20200909
i386                 randconfig-a016-20200909
i386                 randconfig-a015-20200909
i386                 randconfig-a011-20200909
i386                 randconfig-a013-20200909
i386                 randconfig-a014-20200909
i386                 randconfig-a012-20200909
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
x86_64               randconfig-a013-20200909
x86_64               randconfig-a016-20200909
x86_64               randconfig-a011-20200909
x86_64               randconfig-a012-20200909
x86_64               randconfig-a015-20200909
x86_64               randconfig-a014-20200909

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
