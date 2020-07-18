Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED35DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 10:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B50207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 10:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGRK37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 06:29:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:27971 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgGRK3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 06:29:55 -0400
IronPort-SDR: MRkyOZmun7qviCHwI5gbcwZVCFEBPGcFBNCqVfB4upmrS3cJSUwT6e6LJCzjlf/RENiPxpOJVJ
 FaEdoCFXD7hA==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="211275648"
X-IronPort-AV: E=Sophos;i="5.75,366,1589266800"; 
   d="scan'208";a="211275648"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 03:29:55 -0700
IronPort-SDR: KU8nkyyRZC2SHh9n/bqbbxQHWIk2ihXXwlMk71XUvRQzKp3XgC2FBBfO17xWNGkDE24EnKG5Fa
 Ts44MYeaBPkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,366,1589266800"; 
   d="scan'208";a="461126755"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Jul 2020 03:29:53 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwk6L-0000k1-9i; Sat, 18 Jul 2020 10:29:53 +0000
Date:   Sat, 18 Jul 2020 18:28:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/debugobjects] BUILD SUCCESS
 0f85c4805184765ff35e0079b3241ee8f25d1b2b
Message-ID: <5f12ceb2.V3sDrbmYo+bZtAIZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/debugobjects
branch HEAD: 0f85c4805184765ff35e0079b3241ee8f25d1b2b  debugobjects: Convert to DEFINE_SHOW_ATTRIBUTE

elapsed time: 726m

configs tested: 115
configs skipped: 2

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
nds32                             allnoconfig
powerpc                      ppc64e_defconfig
arm                           viper_defconfig
ia64                             alldefconfig
sh                           se7721_defconfig
arm                           corgi_defconfig
sh                        edosk7760_defconfig
mips                        omega2p_defconfig
powerpc                  storcenter_defconfig
arm                           tegra_defconfig
sparc                            allyesconfig
sparc                               defconfig
ia64                          tiger_defconfig
mips                        jmr3927_defconfig
arm                            xcep_defconfig
h8300                            allyesconfig
powerpc                 linkstation_defconfig
sparc                       sparc32_defconfig
arm                          badge4_defconfig
powerpc                      pmac32_defconfig
riscv                          rv32_defconfig
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
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
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
i386                 randconfig-a001-20200717
i386                 randconfig-a005-20200717
i386                 randconfig-a002-20200717
i386                 randconfig-a006-20200717
i386                 randconfig-a003-20200717
i386                 randconfig-a004-20200717
x86_64               randconfig-a012-20200716
x86_64               randconfig-a011-20200716
x86_64               randconfig-a016-20200716
x86_64               randconfig-a014-20200716
x86_64               randconfig-a013-20200716
x86_64               randconfig-a015-20200716
x86_64               randconfig-a005-20200717
x86_64               randconfig-a006-20200717
x86_64               randconfig-a002-20200717
x86_64               randconfig-a001-20200717
x86_64               randconfig-a003-20200717
x86_64               randconfig-a004-20200717
i386                 randconfig-a016-20200717
i386                 randconfig-a011-20200717
i386                 randconfig-a015-20200717
i386                 randconfig-a012-20200717
i386                 randconfig-a013-20200717
i386                 randconfig-a014-20200717
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
