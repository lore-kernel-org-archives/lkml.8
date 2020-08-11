Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA70C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451AA2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgHKBC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:02:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:55363 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgHKBC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:02:57 -0400
IronPort-SDR: UbQgDIGYqC7b7SA7Ny+Qr4h6Vuyf3qZEB1jVF56I4wTkUspY7NU/nqwq9cEFBIFsJm0WvVi9db
 tufxziaHG+KQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="217978549"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="217978549"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 18:02:57 -0700
IronPort-SDR: xo6x+9+ip+Rr2xV6vZ8cdLkfj8JKgNK3fDfJ61xV00ut/H28wRyv5dYgHrjUv1uHUsOBJnN5hV
 U2ZUrfteflcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="326683918"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2020 18:02:55 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5Igp-0000Hs-9l; Tue, 11 Aug 2020 01:02:55 +0000
Date:   Tue, 11 Aug 2020 09:02:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/test] BUILD SUCCESS
 1ca2cb90f246b67e6afa46abf54a401af1f189bc
Message-ID: <5f31ee1e.IJH5zo8TWPgb78AL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/test
branch HEAD: 1ca2cb90f246b67e6afa46abf54a401af1f189bc  Merge remote-tracking branch 'linus/master' into rcu/test

elapsed time: 724m

configs tested: 70
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          r7780mp_defconfig
arm                           stm32_defconfig
arm                             ezx_defconfig
arm                        multi_v7_defconfig
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
i386                 randconfig-a005-20200810
i386                 randconfig-a001-20200810
i386                 randconfig-a002-20200810
i386                 randconfig-a003-20200810
i386                 randconfig-a006-20200810
i386                 randconfig-a004-20200810
x86_64               randconfig-a013-20200810
x86_64               randconfig-a012-20200810
x86_64               randconfig-a016-20200810
x86_64               randconfig-a011-20200810
x86_64               randconfig-a014-20200810
x86_64               randconfig-a015-20200810
i386                 randconfig-a016-20200810
i386                 randconfig-a011-20200810
i386                 randconfig-a015-20200810
i386                 randconfig-a013-20200810
i386                 randconfig-a012-20200810
i386                 randconfig-a014-20200810
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
