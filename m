Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521C8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1E52068F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgHDD2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 23:28:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:35904 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbgHDD17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 23:27:59 -0400
IronPort-SDR: VbA6ycGYYfxZ7tssIlVa0ytXV5YOp7D/ax8aWqOekzK+tiCYE0AhDzylg3p6RoX5Vcd7J1ku+x
 sqKkCRVRQcMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="132302148"
X-IronPort-AV: E=Sophos;i="5.75,432,1589266800"; 
   d="scan'208";a="132302148"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 20:27:58 -0700
IronPort-SDR: /pc90akYf/01W1pQrsrSp5N+eii/ToVoq0FRNxl9Emq2JXUDsLwA0oqfhDLL0NkE5BStjwn0x0
 tFxca6FocMjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,432,1589266800"; 
   d="scan'208";a="315164366"
Received: from lkp-server02.sh.intel.com (HELO 84ccfe698a63) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2020 20:27:57 -0700
Received: from kbuild by 84ccfe698a63 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2ncK-0000OL-R4; Tue, 04 Aug 2020 03:27:56 +0000
Date:   Tue, 04 Aug 2020 11:27:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 3d5128c1deb5d27993fb11ba5e517798f8021046
Message-ID: <5f28d58b.99XGm2IZRdO6s6HM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/core
branch HEAD: 3d5128c1deb5d27993fb11ba5e517798f8021046  Merge tag 'irqchip-5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 724m

configs tested: 112
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                        generic_defconfig
m68k                       bvme6000_defconfig
arm                          pxa168_defconfig
powerpc                  mpc885_ads_defconfig
m68k                             alldefconfig
mips                  decstation_64_defconfig
arm                        neponset_defconfig
arm                      jornada720_defconfig
sh                     magicpanelr2_defconfig
h8300                     edosk2674_defconfig
arm                        shmobile_defconfig
c6x                                 defconfig
arm                            mmp2_defconfig
arm                         lubbock_defconfig
arc                     nsimosci_hs_defconfig
mips                 pnx8335_stb225_defconfig
sparc64                          alldefconfig
arm                          badge4_defconfig
arm                          ixp4xx_defconfig
sh                          lboxre2_defconfig
arm                       aspeed_g4_defconfig
arc                          axs101_defconfig
powerpc                    amigaone_defconfig
sh                   sh7770_generic_defconfig
mips                        bcm47xx_defconfig
h8300                    h8300h-sim_defconfig
nds32                             allnoconfig
powerpc                          alldefconfig
mips                      bmips_stb_defconfig
arm                        magician_defconfig
arm                         lpc18xx_defconfig
m68k                        m5307c3_defconfig
arm                       aspeed_g5_defconfig
sh                   rts7751r2dplus_defconfig
m68k                        stmark2_defconfig
arm                             pxa_defconfig
sh                             sh03_defconfig
mips                         db1xxx_defconfig
arm                        trizeps4_defconfig
parisc                           alldefconfig
mips                           ip32_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200803
i386                 randconfig-a005-20200803
i386                 randconfig-a001-20200803
i386                 randconfig-a002-20200803
i386                 randconfig-a003-20200803
i386                 randconfig-a006-20200803
x86_64               randconfig-a006-20200804
x86_64               randconfig-a001-20200804
x86_64               randconfig-a004-20200804
x86_64               randconfig-a005-20200804
x86_64               randconfig-a002-20200804
x86_64               randconfig-a003-20200804
x86_64               randconfig-a013-20200803
x86_64               randconfig-a011-20200803
x86_64               randconfig-a012-20200803
x86_64               randconfig-a016-20200803
x86_64               randconfig-a015-20200803
x86_64               randconfig-a014-20200803
i386                 randconfig-a011-20200803
i386                 randconfig-a012-20200803
i386                 randconfig-a015-20200803
i386                 randconfig-a014-20200803
i386                 randconfig-a013-20200803
i386                 randconfig-a016-20200803
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
