Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3FCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207E22075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgHTPcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:32:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:56078 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbgHTPct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:32:49 -0400
IronPort-SDR: Y2dIk650nPm7nqEs4GqjJpo6uuvlwbRDiaia0ssISmKgybfX8gl70GuoAJfAxjDHZecdBlu8om
 5qE+toqJgs1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="152920264"
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="152920264"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 08:32:35 -0700
IronPort-SDR: Poyj9ABu9muAC4lZBUCG7F3PxzcwFt/ty/5wnycAlHcZKAbXNzbhzTYOAhwLV8PqQ1eEn9TAPz
 ZcnYhe6RVsew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="442024049"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Aug 2020 08:32:33 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k8mYK-00008p-NR; Thu, 20 Aug 2020 15:32:32 +0000
Date:   Thu, 20 Aug 2020 23:32:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-linus/kspp] BUILD SUCCESS
 32c9c03c07c39339d2bdd0d0580a70de09e770c6
Message-ID: <5f3e977a.mwYHUIObbR4SHr0B%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  for-linus/kspp
branch HEAD: 32c9c03c07c39339d2bdd0d0580a70de09e770c6  treewide: Use fallthrough pseudo-keyword

elapsed time: 725m

configs tested: 84
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
powerpc                     powernv_defconfig
arm                          pcm027_defconfig
arm                        mvebu_v7_defconfig
arm                          pxa168_defconfig
powerpc                     skiroot_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc8272_ads_defconfig
parisc                              defconfig
m68k                        mvme16x_defconfig
sh                        apsh4ad0a_defconfig
m68k                             allyesconfig
arm                         vf610m4_defconfig
arm                           h5000_defconfig
mips                        nlm_xlp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
i386                 randconfig-a005-20200819
i386                 randconfig-a002-20200819
i386                 randconfig-a001-20200819
i386                 randconfig-a006-20200819
i386                 randconfig-a003-20200819
i386                 randconfig-a004-20200819
i386                 randconfig-a005-20200818
i386                 randconfig-a002-20200818
i386                 randconfig-a001-20200818
i386                 randconfig-a006-20200818
i386                 randconfig-a003-20200818
i386                 randconfig-a004-20200818
x86_64               randconfig-a013-20200818
x86_64               randconfig-a016-20200818
x86_64               randconfig-a012-20200818
x86_64               randconfig-a011-20200818
x86_64               randconfig-a014-20200818
x86_64               randconfig-a015-20200818
i386                 randconfig-a016-20200818
i386                 randconfig-a011-20200818
i386                 randconfig-a015-20200818
i386                 randconfig-a013-20200818
i386                 randconfig-a012-20200818
i386                 randconfig-a014-20200818
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
