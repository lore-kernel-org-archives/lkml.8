Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCDAC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8684E20709
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIBEX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:23:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:3845 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgIBEX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:23:58 -0400
IronPort-SDR: BbmzRqXGw5fKiVfoquFrkNtdmW8NgJQBF+9yzLW+lfPjMIlh87Syu+JbNv9Qub7jh7jUGlxemI
 Ffdeqsr1mm6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="137366643"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="137366643"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 21:23:56 -0700
IronPort-SDR: DuRtgrF+Q0NpieA5M6ssp7IR0oQeAjFB+l4/Snpa6ots4OmlXZx7BwlWGbFhDVJrzh3zfloled
 V8gD2CUIq23Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="283602640"
Received: from lkp-server02.sh.intel.com (HELO 500e1ab2883a) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2020 21:23:55 -0700
Received: from kbuild by 500e1ab2883a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kDKJP-00002F-9Y; Wed, 02 Sep 2020 04:23:55 +0000
Date:   Wed, 02 Sep 2020 12:23:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 43b00b155cc21855de77ec14c31fdfc2a43c9c0d
Message-ID: <5f4f1e2d.1i0mqlFIPm6fUhdv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 43b00b155cc21855de77ec14c31fdfc2a43c9c0d  Merge branch 'x86/misc'

elapsed time: 726m

configs tested: 141
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
sh                           se7206_defconfig
mips                 pnx8335_stb225_defconfig
arm                            mmp2_defconfig
sh                           sh2007_defconfig
sh                        edosk7705_defconfig
arm                         shannon_defconfig
arm                     eseries_pxa_defconfig
arm                      footbridge_defconfig
riscv                             allnoconfig
sh                            migor_defconfig
sh                          rsk7264_defconfig
powerpc                             defconfig
powerpc                      mgcoge_defconfig
sh                          r7780mp_defconfig
sh                           se7712_defconfig
sparc                       sparc64_defconfig
arm                             pxa_defconfig
arm                          gemini_defconfig
microblaze                    nommu_defconfig
s390                       zfcpdump_defconfig
h8300                       h8s-sim_defconfig
powerpc                  storcenter_defconfig
arm                   milbeaut_m10v_defconfig
mips                            e55_defconfig
arm                        clps711x_defconfig
powerpc                    mvme5100_defconfig
sh                   sh7770_generic_defconfig
sh                           se7343_defconfig
arm                           efm32_defconfig
sh                          rsk7269_defconfig
ia64                                defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         hackkit_defconfig
arm                        mvebu_v5_defconfig
xtensa                       common_defconfig
arm                            lart_defconfig
arm                      pxa255-idp_defconfig
arm                         mv78xx0_defconfig
arm                         s3c2410_defconfig
arm                              alldefconfig
riscv                    nommu_k210_defconfig
nios2                         3c120_defconfig
m68k                             alldefconfig
m68k                       m5475evb_defconfig
sh                ecovec24-romimage_defconfig
mips                         tb0287_defconfig
mips                     cu1000-neo_defconfig
mips                          malta_defconfig
powerpc                    gamecube_defconfig
mips                      malta_kvm_defconfig
m68k                       m5249evb_defconfig
x86_64                              defconfig
sh                          kfr2r09_defconfig
c6x                                 defconfig
arm                       aspeed_g5_defconfig
m68k                        stmark2_defconfig
nds32                            alldefconfig
mips                    maltaup_xpa_defconfig
arm                            dove_defconfig
powerpc                     mpc512x_defconfig
powerpc                       maple_defconfig
arm                          simpad_defconfig
sh                          rsk7201_defconfig
arm                         nhk8815_defconfig
mips                         bigsur_defconfig
arm                        realview_defconfig
arm                        magician_defconfig
ia64                             allmodconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200901
x86_64               randconfig-a003-20200901
x86_64               randconfig-a001-20200901
x86_64               randconfig-a002-20200901
x86_64               randconfig-a006-20200901
x86_64               randconfig-a005-20200901
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
i386                 randconfig-a016-20200902
i386                 randconfig-a015-20200902
i386                 randconfig-a011-20200902
i386                 randconfig-a013-20200902
i386                 randconfig-a014-20200902
i386                 randconfig-a012-20200902
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
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
