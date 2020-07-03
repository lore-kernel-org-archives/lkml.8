Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C03C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFA7208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgGCCBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:01:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:25286 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgGCCBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:01:37 -0400
IronPort-SDR: xYLAMMsi9rF7t2E9+zT8vQW8olMeObRcsIVU0TKuW5od+yraRyfYI/gYfy5HlY+PwgthsNRt+w
 9ccWqPis4dnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148597154"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="148597154"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 19:01:36 -0700
IronPort-SDR: c1zawYKkgxzqwsQp7eqFKU5IQqjFcOCsKiraY9UkeEmWzN+vLNOf6UTWZj4mtZBdFlpoFf4WP2
 VNEbujzpK6PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="304428805"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jul 2020 19:01:35 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jrB1C-0003vY-EU; Fri, 03 Jul 2020 02:01:34 +0000
Date:   Fri, 03 Jul 2020 10:00:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:WIP.fixes] BUILD SUCCESS
 bdbfb1d52d5e576c1d275fd8ab59b677011229e8
Message-ID: <5efe9126.neOxqWz2ypfUIEvL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  WIP.fixes
branch HEAD: bdbfb1d52d5e576c1d275fd8ab59b677011229e8  Revert "mm/vmalloc: modify struct vmap_area to reduce its size"

elapsed time: 6783m

configs tested: 207
configs skipped: 11

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
mips                         tb0287_defconfig
powerpc                  mpc866_ads_defconfig
mips                      pistachio_defconfig
sparc64                          allyesconfig
arm                       aspeed_g4_defconfig
m68k                       m5249evb_defconfig
arm                            mmp2_defconfig
sh                            shmin_defconfig
powerpc                      pmac32_defconfig
m68k                             alldefconfig
arm                         socfpga_defconfig
mips                              allnoconfig
arm                         s3c2410_defconfig
openrisc                 simple_smp_defconfig
arm                    vt8500_v6_v7_defconfig
arm                           corgi_defconfig
m68k                        m5307c3_defconfig
powerpc                          g5_defconfig
arm                           u8500_defconfig
sparc                       sparc32_defconfig
mips                           mtx1_defconfig
arm                         orion5x_defconfig
mips                        bcm63xx_defconfig
sh                               j2_defconfig
sh                             espt_defconfig
x86_64                           alldefconfig
arm                          exynos_defconfig
arc                     nsimosci_hs_defconfig
arc                          axs103_defconfig
m68k                          hp300_defconfig
sh                          landisk_defconfig
sh                         apsh4a3a_defconfig
arm                          badge4_defconfig
arm                          lpd270_defconfig
powerpc                  mpc885_ads_defconfig
arm                   milbeaut_m10v_defconfig
sh                        dreamcast_defconfig
openrisc                    or1ksim_defconfig
mips                         tb0219_defconfig
powerpc                      mgcoge_defconfig
arm                          pcm027_defconfig
mips                         mpc30x_defconfig
sh                  sh7785lcr_32bit_defconfig
nds32                             allnoconfig
arm                         lubbock_defconfig
m68k                       bvme6000_defconfig
microblaze                          defconfig
mips                         cobalt_defconfig
sh                           se7721_defconfig
arm                             pxa_defconfig
mips                 pnx8335_stb225_defconfig
mips                      pic32mzda_defconfig
mips                           xway_defconfig
um                             i386_defconfig
mips                        maltaup_defconfig
m68k                          multi_defconfig
m68k                                defconfig
sh                      rts7751r2d1_defconfig
arm                           viper_defconfig
powerpc                      ppc44x_defconfig
arm                          moxart_defconfig
sh                        sh7763rdp_defconfig
arm                        mvebu_v7_defconfig
c6x                        evmc6474_defconfig
sh                           se7724_defconfig
arm                            pleb_defconfig
arm                             ezx_defconfig
xtensa                       common_defconfig
parisc                generic-64bit_defconfig
mips                        jmr3927_defconfig
mips                 decstation_r4k_defconfig
arm                         nhk8815_defconfig
powerpc                          allyesconfig
sh                                  defconfig
m68k                          amiga_defconfig
m68k                          sun3x_defconfig
mips                  mips_paravirt_defconfig
sh                     sh7710voipgw_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
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
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200630
i386                 randconfig-a003-20200630
i386                 randconfig-a002-20200630
i386                 randconfig-a004-20200630
i386                 randconfig-a005-20200630
i386                 randconfig-a006-20200630
i386                 randconfig-a002-20200701
i386                 randconfig-a001-20200701
i386                 randconfig-a006-20200701
i386                 randconfig-a005-20200701
i386                 randconfig-a004-20200701
i386                 randconfig-a003-20200701
i386                 randconfig-a006-20200629
i386                 randconfig-a002-20200629
i386                 randconfig-a003-20200629
i386                 randconfig-a001-20200629
i386                 randconfig-a005-20200629
i386                 randconfig-a004-20200629
x86_64               randconfig-a011-20200629
x86_64               randconfig-a012-20200629
x86_64               randconfig-a013-20200629
x86_64               randconfig-a014-20200629
x86_64               randconfig-a015-20200629
x86_64               randconfig-a016-20200629
x86_64               randconfig-a011-20200630
x86_64               randconfig-a014-20200630
x86_64               randconfig-a013-20200630
x86_64               randconfig-a015-20200630
x86_64               randconfig-a016-20200630
x86_64               randconfig-a012-20200630
x86_64               randconfig-a012-20200701
x86_64               randconfig-a016-20200701
x86_64               randconfig-a014-20200701
x86_64               randconfig-a011-20200701
x86_64               randconfig-a015-20200701
x86_64               randconfig-a013-20200701
i386                 randconfig-a013-20200629
i386                 randconfig-a016-20200629
i386                 randconfig-a014-20200629
i386                 randconfig-a012-20200629
i386                 randconfig-a015-20200629
i386                 randconfig-a011-20200629
i386                 randconfig-a011-20200630
i386                 randconfig-a016-20200630
i386                 randconfig-a015-20200630
i386                 randconfig-a014-20200630
i386                 randconfig-a013-20200630
i386                 randconfig-a012-20200630
i386                 randconfig-a011-20200701
i386                 randconfig-a015-20200701
i386                 randconfig-a014-20200701
i386                 randconfig-a016-20200701
i386                 randconfig-a012-20200701
i386                 randconfig-a013-20200701
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
