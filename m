Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD25C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95D0208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHEB4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:56:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:33237 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgHEB4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:56:12 -0400
IronPort-SDR: wPbPJBow9LiKrM1pTlvAWVWsch6TUhDtLGn/QBTT01Z3MIaTCsD6LMz29/PsbmvRXq0Pu7XZYt
 T7O5sIpGwxmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="153597663"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="153597663"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 18:56:11 -0700
IronPort-SDR: Y6ObVd7oMpPs9UD1fbLVclZDB8G5IAjbuejejsB0V92V3EEHARlPs5bgJMFqOVPqmjZy1bOG3C
 AChWat21HDhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="493116231"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 04 Aug 2020 18:56:10 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k38f3-0000X7-Gp; Wed, 05 Aug 2020 01:56:09 +0000
Date:   Wed, 05 Aug 2020 09:56:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4772d0923c0d911ad5c4b03d40352fa9764cfcc6
Message-ID: <5f2a11b3.lraQzq/gEuTC0Mmm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 4772d0923c0d911ad5c4b03d40352fa9764cfcc6  Merge branch 'WIP.x86/kaslr'

elapsed time: 722m

configs tested: 125
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                     davinci_all_defconfig
powerpc                 mpc8272_ads_defconfig
sparc                               defconfig
sparc64                             defconfig
sh                           se7780_defconfig
sh                           se7750_defconfig
mips                            gpr_defconfig
arm                       spear13xx_defconfig
mips                      maltasmvp_defconfig
sh                          rsk7264_defconfig
x86_64                           allyesconfig
parisc                generic-32bit_defconfig
arm                        mvebu_v7_defconfig
powerpc                mpc7448_hpc2_defconfig
parisc                           alldefconfig
arm                           h3600_defconfig
sh                        edosk7760_defconfig
riscv                               defconfig
mips                        vocore2_defconfig
arm                  colibri_pxa300_defconfig
arm                       netwinder_defconfig
arm                       versatile_defconfig
mips                        bcm63xx_defconfig
c6x                              alldefconfig
powerpc                           allnoconfig
sh                          r7785rp_defconfig
sh                            shmin_defconfig
arm                        multi_v7_defconfig
mips                         tb0287_defconfig
sh                          rsk7269_defconfig
mips                        jmr3927_defconfig
xtensa                          iss_defconfig
sh                          kfr2r09_defconfig
m68k                       m5208evb_defconfig
arm                          badge4_defconfig
arm                          pxa168_defconfig
arm                              alldefconfig
powerpc                      chrp32_defconfig
powerpc                     powernv_defconfig
sh                          sdk7786_defconfig
sh                         ap325rxa_defconfig
arm                             mxs_defconfig
sh                            titan_defconfig
arc                              alldefconfig
m68k                        mvme147_defconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a005-20200805
i386                 randconfig-a004-20200805
i386                 randconfig-a001-20200805
i386                 randconfig-a003-20200805
i386                 randconfig-a002-20200805
i386                 randconfig-a006-20200805
i386                 randconfig-a005-20200804
i386                 randconfig-a004-20200804
i386                 randconfig-a001-20200804
i386                 randconfig-a003-20200804
i386                 randconfig-a002-20200804
i386                 randconfig-a006-20200804
x86_64               randconfig-a013-20200805
x86_64               randconfig-a011-20200805
x86_64               randconfig-a012-20200805
x86_64               randconfig-a016-20200805
x86_64               randconfig-a015-20200805
x86_64               randconfig-a014-20200805
i386                 randconfig-a011-20200804
i386                 randconfig-a012-20200804
i386                 randconfig-a013-20200804
i386                 randconfig-a014-20200804
i386                 randconfig-a015-20200804
i386                 randconfig-a016-20200804
i386                 randconfig-a011-20200805
i386                 randconfig-a012-20200805
i386                 randconfig-a013-20200805
i386                 randconfig-a014-20200805
i386                 randconfig-a015-20200805
i386                 randconfig-a016-20200805
x86_64               randconfig-a006-20200804
x86_64               randconfig-a001-20200804
x86_64               randconfig-a004-20200804
x86_64               randconfig-a005-20200804
x86_64               randconfig-a002-20200804
x86_64               randconfig-a003-20200804
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
