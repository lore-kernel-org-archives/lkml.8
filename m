Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE97BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE0F206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgHaSAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:00:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:19958 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgHaSAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:00:10 -0400
IronPort-SDR: iuu5aDyn/raD+corTQgWPHYB0DCtfFTmY9seRQ5Pie7GSjn+XNGUnXrjJ9uspL8uLp8aUcv6lo
 LyQJC1NT0a0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="136555808"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="136555808"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 11:00:04 -0700
IronPort-SDR: xb0ioehmjdMJjigSkasDrkPikkCEuEOMNgeICpeoHGSZOHD0+sT+neTYjj2/Vh+3ke8hYdmB4C
 fkW998XB+SsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="404514603"
Received: from lkp-server02.sh.intel.com (HELO 713faec3b0e5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 31 Aug 2020 11:00:03 -0700
Received: from kbuild by 713faec3b0e5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kCo66-00008I-V1; Mon, 31 Aug 2020 18:00:02 +0000
Date:   Tue, 01 Sep 2020 01:59:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9e4e12be1c647da2bf200d476d769ff07f1e91fb
Message-ID: <5f4d3a7a.ojA1b9mtWwPy/hzS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 9e4e12be1c647da2bf200d476d769ff07f1e91fb  Merge branch 'locking/core'

elapsed time: 727m

configs tested: 89
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                      axs103_smp_defconfig
arm                         s3c6400_defconfig
m68k                        mvme147_defconfig
sh                           sh2007_defconfig
mips                 decstation_r4k_defconfig
powerpc                      ep88xc_defconfig
arm                       versatile_defconfig
arm                          pxa910_defconfig
arm                             pxa_defconfig
sh                                  defconfig
mips                  maltasmvp_eva_defconfig
mips                        omega2p_defconfig
arc                             nps_defconfig
ia64                         bigsur_defconfig
powerpc                         ps3_defconfig
sh                        sh7785lcr_defconfig
arm                         orion5x_defconfig
arm                    vt8500_v6_v7_defconfig
sh                      rts7751r2d1_defconfig
i386                             alldefconfig
sh                          rsk7201_defconfig
arm                            qcom_defconfig
mips                     decstation_defconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
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
