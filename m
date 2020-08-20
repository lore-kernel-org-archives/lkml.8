Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E167AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FFE207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHTBtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:49:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:36688 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgHTBtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 21:49:40 -0400
IronPort-SDR: /En9Hb9kU5PDHVtn0gbKJKwCuTGE60nxefVJdjW2mKngs3Wps7VBIBJhC9rYwc5yYMnp1p8328
 k4+ITuK3lBBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="142858007"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="142858007"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 18:49:39 -0700
IronPort-SDR: 2hJKGiyMn8FXlB+NOYwWdjugfGwo0KNnFNP0P1T8vjVwvqk/XtAUbDtNj6E/rhsVJXZLXZMbrC
 NwN9DEvn/V2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="441805388"
Received: from lkp-server01.sh.intel.com (HELO 4cedd236b688) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Aug 2020 18:49:38 -0700
Received: from kbuild by 4cedd236b688 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k8Zhy-0000iX-4R; Thu, 20 Aug 2020 01:49:38 +0000
Date:   Thu, 20 Aug 2020 09:49:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 709c4362725abb5fa1e36fd94893a9b0d049df82
Message-ID: <5f3dd690.OcX+LPbQAD7Hkd4n%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cache
branch HEAD: 709c4362725abb5fa1e36fd94893a9b0d049df82  cacheinfo: Move resctrl's get_cache_id() to the cacheinfo header file

elapsed time: 725m

configs tested: 80
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     powernv_defconfig
arm                          pcm027_defconfig
arm                        mvebu_v7_defconfig
arm                          pxa168_defconfig
powerpc                     skiroot_defconfig
arm                         vf610m4_defconfig
arm                           h5000_defconfig
mips                        nlm_xlp_defconfig
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
i386                 randconfig-a016-20200819
i386                 randconfig-a011-20200819
i386                 randconfig-a015-20200819
i386                 randconfig-a013-20200819
i386                 randconfig-a012-20200819
i386                 randconfig-a014-20200819
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
