Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B9BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 473FE20656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgHUKMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:12:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:4196 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgHUKMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:12:53 -0400
IronPort-SDR: FKdS8R/fIRnBtLgCReQ/GmhL1PcXwuarb5gsDkD+e3SQWd9abEP4/Oujtxoa8sp1ep5z+zxiiz
 ujR2nbUsRIJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="135563929"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="135563929"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 03:12:53 -0700
IronPort-SDR: uRziCKUfVb8XNs6pqbpCsxQfdrjMFFFFeGEsAFZlXHY1g71cuycBIfQN9grqDJQW1YBtGhkzsC
 EH0K4lL7uPcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="278880750"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Aug 2020 03:12:52 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k942V-0000tM-O5; Fri, 21 Aug 2020 10:12:51 +0000
Date:   Fri, 21 Aug 2020 18:12:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-linus/kspp] BUILD SUCCESS
 0063a804dc07e3738ab92acbf1bb49a98ea45327
Message-ID: <5f3f9e1c.qsyb/aySkiXNpkO4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  for-linus/kspp
branch HEAD: 0063a804dc07e3738ab92acbf1bb49a98ea45327  treewide: Use fallthrough pseudo-keyword

elapsed time: 720m

configs tested: 74
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           ip28_defconfig
x86_64                           allyesconfig
arm                            mmp2_defconfig
h8300                    h8300h-sim_defconfig
riscv                               defconfig
mips                        bcm47xx_defconfig
powerpc                        cell_defconfig
m68k                       m5275evb_defconfig
arm                        keystone_defconfig
s390                             alldefconfig
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
i386                 randconfig-a002-20200820
i386                 randconfig-a004-20200820
i386                 randconfig-a005-20200820
i386                 randconfig-a003-20200820
i386                 randconfig-a006-20200820
i386                 randconfig-a001-20200820
x86_64               randconfig-a015-20200820
x86_64               randconfig-a016-20200820
x86_64               randconfig-a012-20200820
x86_64               randconfig-a014-20200820
x86_64               randconfig-a011-20200820
x86_64               randconfig-a013-20200820
i386                 randconfig-a016-20200820
i386                 randconfig-a013-20200820
i386                 randconfig-a012-20200820
i386                 randconfig-a011-20200820
i386                 randconfig-a014-20200820
i386                 randconfig-a015-20200820
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
