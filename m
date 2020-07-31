Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04488C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D550B2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGaWxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:53:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:42307 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgGaWxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:53:34 -0400
IronPort-SDR: lPwRsNXq6VG5JgLY7fJsvF/6yVVPqpBAKYitQgonZCjeN0Zf9Ux6ljaqc3du28i1l5z0wn3agU
 1UCZO+disQhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="153099320"
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="153099320"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 15:53:33 -0700
IronPort-SDR: aNOJ2nwjLNUCUgCQVz0vzH6Yi+Ew+Pzbm4zFqTnarJFAhdhJrCIulVgDiQKgtFdkhSoLevH8gt
 mvIFOSM2IdMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="331222573"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 31 Jul 2020 15:53:32 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1du7-0000Al-MY; Fri, 31 Jul 2020 22:53:31 +0000
Date:   Sat, 01 Aug 2020 06:52:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/rcu] BUILD SUCCESS
 c1cc4784ce6e8cceff1013709abd74bcbf7fbf24
Message-ID: <5f24a0ba.TNbsWkVMEmWlyt4c%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/rcu
branch HEAD: c1cc4784ce6e8cceff1013709abd74bcbf7fbf24  Merge branch 'for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

elapsed time: 721m

configs tested: 66
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
i386                 randconfig-a005-20200731
i386                 randconfig-a004-20200731
i386                 randconfig-a006-20200731
i386                 randconfig-a002-20200731
i386                 randconfig-a001-20200731
i386                 randconfig-a003-20200731
x86_64               randconfig-a015-20200731
x86_64               randconfig-a014-20200731
x86_64               randconfig-a016-20200731
x86_64               randconfig-a012-20200731
x86_64               randconfig-a013-20200731
x86_64               randconfig-a011-20200731
i386                 randconfig-a016-20200731
i386                 randconfig-a012-20200731
i386                 randconfig-a014-20200731
i386                 randconfig-a015-20200731
i386                 randconfig-a011-20200731
i386                 randconfig-a013-20200731
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
