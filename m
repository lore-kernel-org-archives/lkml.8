Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A7CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C104E20678
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHYWzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:55:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:58438 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgHYWzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:55:31 -0400
IronPort-SDR: 4f3K/Jb55xSqv1+ZC6ahOZ3uwJpxkBYcNt3jsEypAyzj+6gGBDLepueahokGhs/zhQ2XC7wLIC
 4hDMpppjr3Tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="174252224"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="174252224"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 15:55:31 -0700
IronPort-SDR: sq88wtnMTh9woKuCX1KqBhEIwGC97hyEeKx7uJY9tb0+6Zj0Of34kQgfz2ahAZoS3grzzCgJnU
 9PAitHpsigPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="312706363"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Aug 2020 15:55:29 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kAhqj-00014t-1C; Tue, 25 Aug 2020 22:55:29 +0000
Date:   Wed, 26 Aug 2020 06:54:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 ec02821c1d35f93b821bc9fdfa83a5f3e9d7275d
Message-ID: <5f4596a5.loKgDwPlxmm9MJFe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: ec02821c1d35f93b821bc9fdfa83a5f3e9d7275d  alarmtimer: Convert comma to semicolon

elapsed time: 725m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                    vt8500_v6_v7_defconfig
arc                        vdk_hs38_defconfig
mips                         bigsur_defconfig
arm                           omap1_defconfig
arm                           h5000_defconfig
arm                           corgi_defconfig
sh                ecovec24-romimage_defconfig
riscv                    nommu_virt_defconfig
mips                         mpc30x_defconfig
arm                             ezx_defconfig
mips                           ip28_defconfig
arm                            mmp2_defconfig
c6x                        evmc6472_defconfig
sh                     magicpanelr2_defconfig
powerpc                      ppc64e_defconfig
arc                           tb10x_defconfig
arm                        vexpress_defconfig
mips                        bcm63xx_defconfig
sh                         ap325rxa_defconfig
arm                            qcom_defconfig
arm                         s3c6400_defconfig
arm                          imote2_defconfig
mips                  cavium_octeon_defconfig
arm                         lpc18xx_defconfig
arm                         s5pv210_defconfig
openrisc                 simple_smp_defconfig
um                            kunit_defconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20200825
x86_64               randconfig-a002-20200825
x86_64               randconfig-a001-20200825
x86_64               randconfig-a005-20200825
x86_64               randconfig-a006-20200825
x86_64               randconfig-a004-20200825
i386                 randconfig-a002-20200825
i386                 randconfig-a004-20200825
i386                 randconfig-a005-20200825
i386                 randconfig-a003-20200825
i386                 randconfig-a006-20200825
i386                 randconfig-a001-20200825
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
i386                 randconfig-a013-20200825
i386                 randconfig-a012-20200825
i386                 randconfig-a011-20200825
i386                 randconfig-a016-20200825
i386                 randconfig-a015-20200825
i386                 randconfig-a014-20200825
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
