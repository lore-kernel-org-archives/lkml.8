Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F769C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 09:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D40423A76
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 09:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgFTJ1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 05:27:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:42998 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgFTJ1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 05:27:34 -0400
IronPort-SDR: ThZyTZYDgR22MvpccDKtxMJsGhatyHbsSOwS37EwTSRqgfcRNfGw2Ps7Q3LxIZN057KqDRF7Va
 PEfRCOsqKAjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="143218718"
X-IronPort-AV: E=Sophos;i="5.75,258,1589266800"; 
   d="scan'208";a="143218718"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2020 02:27:33 -0700
IronPort-SDR: 676GgN9XkogI1aVRS8+/u33AJBaf66C8wPRX/kzprQ0pMqBV3YAo80VpVgmkfBtqwfpNH7tasH
 tw7Chca0y1xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,258,1589266800"; 
   d="scan'208";a="422114363"
Received: from lkp-server02.sh.intel.com (HELO 3aa54c81372e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2020 02:27:32 -0700
Received: from kbuild by 3aa54c81372e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jmZmd-00018n-DE; Sat, 20 Jun 2020 09:27:31 +0000
Date:   Sat, 20 Jun 2020 17:27:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 03e5e9954269d02edd5f6d3a73d579a60dd38c38
Message-ID: <5eedd664.i8J0+euMDUHaKd/R%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  auto-latest
branch HEAD: 03e5e9954269d02edd5f6d3a73d579a60dd38c38  Merge branch 'locking/core'

elapsed time: 730m

configs tested: 115
configs skipped: 10

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
arc                        vdk_hs38_defconfig
arm                        spear6xx_defconfig
csky                             allyesconfig
mips                         tb0226_defconfig
sh                          r7780mp_defconfig
s390                             allyesconfig
csky                                defconfig
powerpc                     mpc5200_defconfig
mips                         rt305x_defconfig
riscv                    nommu_virt_defconfig
arm                         s5pv210_defconfig
arm                        mini2440_defconfig
sh                                  defconfig
arm                       mainstone_defconfig
m68k                       m5475evb_defconfig
powerpc                          g5_defconfig
arm                        trizeps4_defconfig
arm                     davinci_all_defconfig
nios2                         3c120_defconfig
mips                           ip27_defconfig
powerpc                      ep88xc_defconfig
s390                             allmodconfig
mips                      pistachio_defconfig
microblaze                        allnoconfig
m68k                        mvme16x_defconfig
mips                        qi_lb60_defconfig
x86_64                              defconfig
arc                              alldefconfig
mips                     cu1000-neo_defconfig
sh                   secureedge5410_defconfig
arm                           u8500_defconfig
sh                        edosk7705_defconfig
arm                        spear3xx_defconfig
h8300                            allmodconfig
sh                               j2_defconfig
arm                           h5000_defconfig
powerpc                      chrp32_defconfig
arm                        clps711x_defconfig
powerpc                  storcenter_defconfig
xtensa                           alldefconfig
powerpc                      pmac32_defconfig
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
nds32                             allnoconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                              allnoconfig
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
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
