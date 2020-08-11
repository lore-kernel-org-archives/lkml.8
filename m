Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3391EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F92420734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgHKAdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:33:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:1633 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgHKAdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:33:45 -0400
IronPort-SDR: Zedm+Usn8+hojnSSWutvTtAVch1lxeNj3bemIYRvWB6hajyaScAwsSgdIkkdlgptLGPXpXdh2X
 y1Ft1Vdc2GoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="154762925"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="154762925"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 17:33:45 -0700
IronPort-SDR: 063gzgdKOMgiZpAH8oQeS4Eoun0ey+Y6YAyXqhSoJ2Xy/jpw44JDX5GYo3wlJNkdMd++o2poa+
 JSAV91kDjSjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="290530529"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2020 17:33:44 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5IEZ-0000HC-Nr; Tue, 11 Aug 2020 00:33:43 +0000
Date:   Tue, 11 Aug 2020 08:33:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.08.07a] BUILD SUCCESS
 effe4b83a3d86ad17f82b332e1ad64a4d11df68f
Message-ID: <5f31e760.BPSgVkMD+0BImrJw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.08.07a
branch HEAD: effe4b83a3d86ad17f82b332e1ad64a4d11df68f  rcu: Execute RCU reader shortly after rcu_core for strict GPs

elapsed time: 722m

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
