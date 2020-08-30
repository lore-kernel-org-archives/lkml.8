Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA411C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 05:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEAAD2071B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 05:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgH3Fxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 01:53:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:47940 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgH3Fxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 01:53:50 -0400
IronPort-SDR: vGVyWN8Z6uJ0Onfzb69+Y19KI/IsqRV1saj7NeZnUBsUNrrjXOziZsDY9jww/Eglowq/7OUz3P
 GD4xiOlktQOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9728"; a="136894314"
X-IronPort-AV: E=Sophos;i="5.76,370,1592895600"; 
   d="scan'208";a="136894314"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2020 22:53:49 -0700
IronPort-SDR: lXw3xNn2pbUPTzOz+/uoVo0FZGWOgz70MZKgfrndWUr1Y9XrbwmBRpmfbfy6Uyx+cg8mgDtRQP
 xJvzOu7tzfpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,370,1592895600"; 
   d="scan'208";a="404144821"
Received: from lkp-server02.sh.intel.com (HELO 301dc1beeb51) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2020 22:53:49 -0700
Received: from kbuild by 301dc1beeb51 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kCGHk-0000oR-CA; Sun, 30 Aug 2020 05:53:48 +0000
Date:   Sun, 30 Aug 2020 13:53:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/fallthrough] BUILD SUCCESS
 a66bf6afaf6c7977c8e64e77bafb9761fd42ac4c
Message-ID: <5f4b3ec1.ejgDa9S40XtFXFP9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/fallthrough
branch HEAD: a66bf6afaf6c7977c8e64e77bafb9761fd42ac4c  arm64/cpuinfo: Remove unnecessary fallthrough annotation

elapsed time: 720m

configs tested: 96
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           ip28_defconfig
mips                      pic32mzda_defconfig
m68k                            mac_defconfig
arm                       omap2plus_defconfig
nds32                               defconfig
xtensa                       common_defconfig
arm                       spear13xx_defconfig
ia64                             alldefconfig
powerpc                         ps3_defconfig
mips                malta_kvm_guest_defconfig
arm                             rpc_defconfig
powerpc                         wii_defconfig
arm                            u300_defconfig
mips                        vocore2_defconfig
powerpc                       holly_defconfig
mips                            gpr_defconfig
mips                 decstation_r4k_defconfig
arc                        nsim_700_defconfig
sh                            migor_defconfig
arm                          pxa168_defconfig
x86_64                           alldefconfig
arm                         nhk8815_defconfig
m68k                        m5307c3_defconfig
mips                     cu1000-neo_defconfig
arm                         palmz72_defconfig
h8300                            alldefconfig
arm                           viper_defconfig
mips                         tb0287_defconfig
arm                     davinci_all_defconfig
powerpc                      ep88xc_defconfig
arm                       aspeed_g5_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a001-20200830
i386                 randconfig-a002-20200830
i386                 randconfig-a004-20200830
i386                 randconfig-a006-20200830
i386                 randconfig-a005-20200830
i386                 randconfig-a003-20200830
i386                 randconfig-a013-20200830
i386                 randconfig-a011-20200830
i386                 randconfig-a012-20200830
i386                 randconfig-a015-20200830
i386                 randconfig-a016-20200830
i386                 randconfig-a014-20200830
x86_64               randconfig-a002-20200830
x86_64               randconfig-a005-20200830
x86_64               randconfig-a001-20200830
x86_64               randconfig-a006-20200830
x86_64               randconfig-a004-20200830
x86_64               randconfig-a003-20200830
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
