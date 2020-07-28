Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CD8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96AF52075A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgG1COX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:14:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:16064 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgG1COT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:14:19 -0400
IronPort-SDR: LfvxP4l71Xqb964lqVD9kfw1CubvyD2UH9GY7EQwBeLzLKwDttOuJjl84eeu7x5rnl9+AZG8hv
 NJrtBXGnla7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="149003865"
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="149003865"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 19:14:18 -0700
IronPort-SDR: pL4qItYt2ImZngzyUKWx3pC3o/8+eJfjMjYI0dJj4mxHMmickPUibD+kSrf34uMwiaqpID5Z6x
 iWgG5UTBacYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="329889389"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Jul 2020 19:14:17 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0F8C-00028q-Kc; Tue, 28 Jul 2020 02:14:16 +0000
Date:   Tue, 28 Jul 2020 10:13:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ce2273c556389b9cc1dfda36965bf7f86bedd556
Message-ID: <5f1f89e6.RYF349+1rCQOS68c%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: ce2273c556389b9cc1dfda36965bf7f86bedd556  Merge branch 'x86/cpu'

elapsed time: 721m

configs tested: 53
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
arm                       imx_v4_v5_defconfig
mips                           gcw0_defconfig
mips                      fuloong2e_defconfig
arm                      pxa255-idp_defconfig
s390                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
