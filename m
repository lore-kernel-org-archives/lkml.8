Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4EEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8A72083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgFLRHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:07:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:46536 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgFLRHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:07:18 -0400
IronPort-SDR: hnuGlRqSdEbbDxDZm19KurbNBFiGZjR8tnlNd5Ryuk31QT39TFNbRZG24FhltrohORMj8hTv/J
 1wx0CqeVVr4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 10:07:18 -0700
IronPort-SDR: t2cNiVRA17bAtnZNlnmJUl2ulp9uCWsn2Sn74WKfwqmxWtACa6hqA1HR+bgTjXjP7V+uEIqYVK
 E3oztmHBnrvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; 
   d="scan'208";a="259929679"
Received: from lkp-server02.sh.intel.com (HELO de5642daf266) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jun 2020 10:07:16 -0700
Received: from kbuild by de5642daf266 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jjn9A-00003b-1C; Fri, 12 Jun 2020 17:07:16 +0000
Date:   Sat, 13 Jun 2020 01:06:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1f01e1eba3ee7654586c4655172def64f50124e4
Message-ID: <5ee3b60e.cYRLGPnz71HqPqKV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 1f01e1eba3ee7654586c4655172def64f50124e4  Merge branch 'WIP.core/headers'

elapsed time: 484m

configs tested: 104
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm                        clps711x_defconfig
sh                 kfr2r09-romimage_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                          iss_defconfig
riscv                          rv32_defconfig
c6x                        evmc6474_defconfig
arm                           corgi_defconfig
mips                             allmodconfig
arm                            mps2_defconfig
sh                          urquell_defconfig
powerpc                    amigaone_defconfig
microblaze                          defconfig
arm                          lpd270_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
openrisc                            defconfig
openrisc                         allyesconfig
nios2                               defconfig
nios2                            allyesconfig
c6x                              allyesconfig
c6x                               allnoconfig
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
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          rhel-kconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a006-20200612
i386                 randconfig-a002-20200612
i386                 randconfig-a001-20200612
i386                 randconfig-a004-20200612
i386                 randconfig-a005-20200612
i386                 randconfig-a003-20200612
i386                 randconfig-a015-20200612
i386                 randconfig-a011-20200612
i386                 randconfig-a014-20200612
i386                 randconfig-a016-20200612
i386                 randconfig-a013-20200612
i386                 randconfig-a012-20200612
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc64                             defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
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
