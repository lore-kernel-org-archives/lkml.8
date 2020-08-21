Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C19BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E121320702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHUAHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:07:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:41575 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgHUAHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:07:25 -0400
IronPort-SDR: 0OPz1bcTknu5lPnVwDWxXT8WbYHT7lC6JzbWYLZg/2t7rH1WqP9HEJyEyAfa/iCDk4GhiliTvI
 VYbImED460DA==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="153034974"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="153034974"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 17:07:25 -0700
IronPort-SDR: UA5JNSK1nxUsA2IY3hCxOPTr6qXa13+8gfELaPaT6AI3RLRSW8Bghp3fqO4Dwehr1hhoUbEUNz
 d4jE7H7QzcKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="401320049"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Aug 2020 17:07:22 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k8uaY-0000Lh-2g; Fri, 21 Aug 2020 00:07:22 +0000
Date:   Fri, 21 Aug 2020 08:06:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 368d1887200d68075c064a62a9aa191168cf1eed
Message-ID: <5f3f1022.KuRpQh/KEppzz+98%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  ras/core
branch HEAD: 368d1887200d68075c064a62a9aa191168cf1eed  x86/MCE/AMD, EDAC/mce_amd: Remove struct smca_hwid.xec_bitmap

elapsed time: 724m

configs tested: 78
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a002-20200820
i386                 randconfig-a004-20200820
i386                 randconfig-a005-20200820
i386                 randconfig-a003-20200820
i386                 randconfig-a006-20200820
i386                 randconfig-a001-20200820
x86_64               randconfig-a015-20200820
x86_64               randconfig-a012-20200820
x86_64               randconfig-a016-20200820
x86_64               randconfig-a014-20200820
x86_64               randconfig-a011-20200820
x86_64               randconfig-a013-20200820
i386                 randconfig-a013-20200820
i386                 randconfig-a012-20200820
i386                 randconfig-a011-20200820
i386                 randconfig-a016-20200820
i386                 randconfig-a014-20200820
i386                 randconfig-a015-20200820
i386                 randconfig-a013-20200821
i386                 randconfig-a012-20200821
i386                 randconfig-a011-20200821
i386                 randconfig-a016-20200821
i386                 randconfig-a014-20200821
i386                 randconfig-a015-20200821
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
