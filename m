Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5275CC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C11F2065F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgIAH6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:58:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:37172 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgIAH6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:58:42 -0400
IronPort-SDR: pkmDNl6OvhJ4pjACvdwq1b7zpf+uPGU+yIqxcPrYSGLn7FHYfSTzlghlzmvBIb2qFu+q5z9SQn
 BXv4T4Rza/VA==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="175169909"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="175169909"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 00:58:40 -0700
IronPort-SDR: KKb2s3mO6ZLmYixoYvBXgW1d7zLNiWZpGXXOZX7tOOI2cQuDY8elJwT2NLLsv2yfyv2YweR2Hp
 aWIgK8F/WBKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="338491802"
Received: from lkp-server01.sh.intel.com (HELO 6fed54b23e67) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Sep 2020 00:58:34 -0700
Received: from kbuild by 6fed54b23e67 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kD1BZ-00000n-CO; Tue, 01 Sep 2020 07:58:33 +0000
Date:   Tue, 01 Sep 2020 15:58:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.08.27a] BUILD SUCCESS
 99d320d8d0516f631acf28014ccddfd5cd43471c
Message-ID: <5f4dff27.DLccerAyXsryE3jT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.08.27a
branch HEAD: 99d320d8d0516f631acf28014ccddfd5cd43471c  locktorture: Track time of last ->writeunlock()

elapsed time: 720m

configs tested: 135
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         hackkit_defconfig
powerpc                     pq2fads_defconfig
arm                           h3600_defconfig
sh                           se7712_defconfig
powerpc64                        alldefconfig
openrisc                         alldefconfig
powerpc                      pmac32_defconfig
sh                          lboxre2_defconfig
nds32                            alldefconfig
arm                       omap2plus_defconfig
m68k                        mvme16x_defconfig
arm                             mxs_defconfig
sh                ecovec24-romimage_defconfig
mips                        nlm_xlp_defconfig
xtensa                         virt_defconfig
sh                          polaris_defconfig
powerpc                 mpc8272_ads_defconfig
arc                      axs103_smp_defconfig
powerpc                     ep8248e_defconfig
arm                            u300_defconfig
sh                           se7751_defconfig
arm                           u8500_defconfig
parisc                generic-32bit_defconfig
m68k                        mvme147_defconfig
arm                         shannon_defconfig
mips                     decstation_defconfig
alpha                            allyesconfig
sh                           se7343_defconfig
sh                     magicpanelr2_defconfig
arc                                 defconfig
m68k                          sun3x_defconfig
parisc                           allyesconfig
mips                       capcella_defconfig
powerpc                      ppc6xx_defconfig
i386                                defconfig
mips                      loongson3_defconfig
arm                            zeus_defconfig
m68k                          atari_defconfig
arm                        cerfcube_defconfig
sh                     sh7710voipgw_defconfig
sparc                               defconfig
sh                      rts7751r2d1_defconfig
m68k                            q40_defconfig
arm                           omap1_defconfig
arm                   milbeaut_m10v_defconfig
sh                        edosk7705_defconfig
mips                      malta_kvm_defconfig
sh                         microdev_defconfig
mips                      bmips_stb_defconfig
arm                            mps2_defconfig
powerpc                     powernv_defconfig
arc                            hsdk_defconfig
nios2                               defconfig
arm                       imx_v6_v7_defconfig
mips                           rs90_defconfig
nios2                         3c120_defconfig
powerpc                    adder875_defconfig
sh                            titan_defconfig
m68k                            mac_defconfig
riscv                             allnoconfig
mips                           gcw0_defconfig
arm                         bcm2835_defconfig
arm                         s5pv210_defconfig
powerpc                         wii_defconfig
sh                        sh7757lcr_defconfig
powerpc                      tqm8xx_defconfig
nios2                            alldefconfig
powerpc                      ppc64e_defconfig
sh                               alldefconfig
arm                           stm32_defconfig
mips                        jmr3927_defconfig
arc                     haps_hs_smp_defconfig
mips                malta_qemu_32r6_defconfig
sh                        dreamcast_defconfig
ia64                             alldefconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200831
i386                 randconfig-a002-20200831
i386                 randconfig-a004-20200831
i386                 randconfig-a006-20200831
i386                 randconfig-a005-20200831
i386                 randconfig-a003-20200831
x86_64               randconfig-a012-20200831
x86_64               randconfig-a015-20200831
x86_64               randconfig-a014-20200831
x86_64               randconfig-a011-20200831
x86_64               randconfig-a016-20200831
x86_64               randconfig-a013-20200831
i386                 randconfig-a013-20200831
i386                 randconfig-a011-20200831
i386                 randconfig-a012-20200831
i386                 randconfig-a015-20200831
i386                 randconfig-a016-20200831
i386                 randconfig-a014-20200831
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
