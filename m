Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBA9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E692078B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgGHFjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 01:39:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:63054 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729183AbgGHFjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 01:39:07 -0400
IronPort-SDR: VkeP0+A78U96fq3BmmuER95d/nSkH4Y1e/LkdlVE5PDACdqVvPjjTKKK4OD7WtlgKeFUusMBZn
 PG4j3OC0+Nmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="145846395"
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; 
   d="scan'208";a="145846395"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 22:39:07 -0700
IronPort-SDR: 6XVRVWc1hCR2xnVeWpqRJ4yT0ZN9P7tyPj/BSrLadPL60SN3ckPtAJ18R7R+NsqSx6HSd0rWfI
 26X10t7Q+pAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; 
   d="scan'208";a="358001556"
Received: from lkp-server01.sh.intel.com (HELO f2047cb89c8e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2020 22:39:05 -0700
Received: from kbuild by f2047cb89c8e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jt2nQ-0000Ye-Kd; Wed, 08 Jul 2020 05:39:04 +0000
Date:   Wed, 08 Jul 2020 13:38:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:lkmm] BUILD SUCCESS 5ef0a07a7928539d46fdb163acfad28c6d877a89
Message-ID: <5f055be9.PzgewV12VquQQNze%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  lkmm
branch HEAD: 5ef0a07a7928539d46fdb163acfad28c6d877a89  Documentation/litmus-tests: Add note on herd7 7.56 in atomic litmus test

elapsed time: 723m

configs tested: 98
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200707
i386                 randconfig-a002-20200707
i386                 randconfig-a006-20200707
i386                 randconfig-a004-20200707
i386                 randconfig-a005-20200707
i386                 randconfig-a003-20200707
x86_64               randconfig-a012-20200707
x86_64               randconfig-a016-20200707
x86_64               randconfig-a014-20200707
x86_64               randconfig-a011-20200707
x86_64               randconfig-a015-20200707
x86_64               randconfig-a013-20200707
i386                 randconfig-a011-20200707
i386                 randconfig-a014-20200707
i386                 randconfig-a015-20200707
i386                 randconfig-a016-20200707
i386                 randconfig-a012-20200707
i386                 randconfig-a013-20200707
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
