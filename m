Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28684C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072EB2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgH0EOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:14:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:27113 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgH0EOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 00:14:40 -0400
IronPort-SDR: p6oOF9nbcAT1jQGTAJL7/7xtbo3g7GE/UEoAtz5rSirFZ0BeYAmtyf9r9g8LJtdAQr13qcTjnD
 GHVHPZdt6MvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="136485840"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="136485840"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 21:14:40 -0700
IronPort-SDR: pQxuy0jyEuDoQi8SFaRjyt7sExhO5+JQB53FjM2q0TooTaDLHlwcpMH8oMIIuG5kgyO0//rlQ9
 iJmAPC7xVr+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="281992252"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Aug 2020 21:14:38 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kB9J8-0001rk-04; Thu, 27 Aug 2020 04:14:38 +0000
Date:   Thu, 27 Aug 2020 12:14:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 29b6bd41ee24f69a85666b9f68d500b382d408fd
Message-ID: <5f473313.SFG+3cHkfWTrVkIg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cache
branch HEAD: 29b6bd41ee24f69a85666b9f68d500b382d408fd  x86/resctrl: Enable user to view thread or core throttling mode

elapsed time: 724m

configs tested: 145
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
mips                        maltaup_defconfig
sh                   rts7751r2dplus_defconfig
arm                        oxnas_v6_defconfig
sh                        edosk7705_defconfig
powerpc                     pseries_defconfig
arm                        mvebu_v7_defconfig
c6x                        evmc6472_defconfig
arm                       multi_v4t_defconfig
arm                          simpad_defconfig
sh                          lboxre2_defconfig
m68k                            q40_defconfig
arm                              zx_defconfig
mips                        jmr3927_defconfig
sh                        sh7757lcr_defconfig
arc                      axs103_smp_defconfig
sh                        edosk7760_defconfig
m68k                          atari_defconfig
sh                        sh7763rdp_defconfig
c6x                        evmc6474_defconfig
mips                      malta_kvm_defconfig
mips                           jazz_defconfig
arm                        multi_v5_defconfig
riscv                            allmodconfig
m68k                         apollo_defconfig
sh                ecovec24-romimage_defconfig
sh                        apsh4ad0a_defconfig
arm                       spear13xx_defconfig
arm                        trizeps4_defconfig
arc                                 defconfig
m68k                       m5249evb_defconfig
arm                         palmz72_defconfig
m68k                          multi_defconfig
ia64                          tiger_defconfig
mips                         cobalt_defconfig
sh                           se7722_defconfig
sh                   sh7770_generic_defconfig
mips                         tb0226_defconfig
powerpc                     skiroot_defconfig
arm                         lpc18xx_defconfig
sh                          urquell_defconfig
mips                         bigsur_defconfig
ia64                            zx1_defconfig
arm                      integrator_defconfig
arm                            zeus_defconfig
powerpc                 mpc8272_ads_defconfig
m68k                             allmodconfig
arm                          ixp4xx_defconfig
openrisc                    or1ksim_defconfig
arc                          axs103_defconfig
arm                            qcom_defconfig
sh                          kfr2r09_defconfig
mips                          rb532_defconfig
arm                            dove_defconfig
mips                          ath25_defconfig
powerpc                         wii_defconfig
m68k                        stmark2_defconfig
sh                                  defconfig
arc                    vdk_hs38_smp_defconfig
arc                             nps_defconfig
arm                  colibri_pxa270_defconfig
mips                         rt305x_defconfig
xtensa                generic_kc705_defconfig
ia64                        generic_defconfig
x86_64                           alldefconfig
arm                         lubbock_defconfig
powerpc                  storcenter_defconfig
ia64                      gensparse_defconfig
arm                           viper_defconfig
mips                malta_kvm_guest_defconfig
mips                        bcm47xx_defconfig
sh                            shmin_defconfig
sh                     sh7710voipgw_defconfig
mips                  cavium_octeon_defconfig
nios2                         10m50_defconfig
arm                            mmp2_defconfig
m68k                       m5275evb_defconfig
m68k                           sun3_defconfig
sh                          sdk7786_defconfig
mips                       rbtx49xx_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         orion5x_defconfig
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
i386                 randconfig-a002-20200826
i386                 randconfig-a004-20200826
i386                 randconfig-a003-20200826
i386                 randconfig-a005-20200826
i386                 randconfig-a006-20200826
i386                 randconfig-a001-20200826
x86_64               randconfig-a015-20200826
x86_64               randconfig-a016-20200826
x86_64               randconfig-a012-20200826
x86_64               randconfig-a014-20200826
x86_64               randconfig-a011-20200826
x86_64               randconfig-a013-20200826
i386                 randconfig-a013-20200826
i386                 randconfig-a012-20200826
i386                 randconfig-a011-20200826
i386                 randconfig-a016-20200826
i386                 randconfig-a015-20200826
i386                 randconfig-a014-20200826
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
