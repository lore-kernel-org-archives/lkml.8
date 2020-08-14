Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DE7C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 00:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7CB207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 00:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHNAUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 20:20:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:50634 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgHNAU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 20:20:29 -0400
IronPort-SDR: VPW+bCF1l/feV5yn9skm7SrXd8KTiVh5JTtjt6hrfNFUW+g7uBa5vDaPpTsWPSHKH7ncSq3eeN
 vrupzJwyzfxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="239170830"
X-IronPort-AV: E=Sophos;i="5.76,310,1592895600"; 
   d="scan'208";a="239170830"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 17:20:29 -0700
IronPort-SDR: cMk4owmHfj467wayQdmksG1kA1w0lyVLyfiXLZzcEeSV7K5zmieMhvIMN/JGzE4raA8nNJnpac
 74OjwRuYVKbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,310,1592895600"; 
   d="scan'208";a="495567030"
Received: from lkp-server01.sh.intel.com (HELO 7f1ebb311643) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2020 17:20:28 -0700
Received: from kbuild by 7f1ebb311643 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k6NSN-0000t8-Hw; Fri, 14 Aug 2020 00:20:27 +0000
Date:   Fri, 14 Aug 2020 08:19:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 a6d996cbd38b42341ad3fce74506b9fdc280e395
Message-ID: <5f35d896.L2Nv1aKm4j0lzhlL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: a6d996cbd38b42341ad3fce74506b9fdc280e395  x86/alternatives: Acquire pte lock with interrupts enabled

elapsed time: 723m

configs tested: 118
configs skipped: 55

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            xcep_defconfig
mips                          ath25_defconfig
sh                           se7619_defconfig
powerpc                        cell_defconfig
m68k                          multi_defconfig
m68k                          atari_defconfig
openrisc                            defconfig
sh                        sh7763rdp_defconfig
arm                      pxa255-idp_defconfig
h8300                     edosk2674_defconfig
sh                         ap325rxa_defconfig
arm                            pleb_defconfig
sh                           se7780_defconfig
sh                           se7750_defconfig
xtensa                    xip_kc705_defconfig
csky                             alldefconfig
m68k                       bvme6000_defconfig
arm                            lart_defconfig
sh                            migor_defconfig
sh                        sh7785lcr_defconfig
mips                malta_kvm_guest_defconfig
sh                           se7722_defconfig
powerpc                             defconfig
mips                      malta_kvm_defconfig
mips                         mpc30x_defconfig
arm                          ixp4xx_defconfig
sh                          landisk_defconfig
sh                          urquell_defconfig
mips                      pic32mzda_defconfig
arm                           viper_defconfig
arc                          axs101_defconfig
arm                        shmobile_defconfig
arm                             mxs_defconfig
sparc64                          alldefconfig
arm                          lpd270_defconfig
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
x86_64               randconfig-a006-20200813
x86_64               randconfig-a001-20200813
x86_64               randconfig-a005-20200813
x86_64               randconfig-a003-20200813
x86_64               randconfig-a004-20200813
x86_64               randconfig-a002-20200813
i386                 randconfig-a005-20200813
i386                 randconfig-a001-20200813
i386                 randconfig-a002-20200813
i386                 randconfig-a003-20200813
i386                 randconfig-a006-20200813
i386                 randconfig-a004-20200813
i386                 randconfig-a005-20200812
i386                 randconfig-a001-20200812
i386                 randconfig-a002-20200812
i386                 randconfig-a003-20200812
i386                 randconfig-a006-20200812
i386                 randconfig-a004-20200812
i386                 randconfig-a005-20200811
i386                 randconfig-a001-20200811
i386                 randconfig-a002-20200811
i386                 randconfig-a003-20200811
i386                 randconfig-a006-20200811
i386                 randconfig-a004-20200811
i386                 randconfig-a016-20200813
i386                 randconfig-a011-20200813
i386                 randconfig-a013-20200813
i386                 randconfig-a015-20200813
i386                 randconfig-a012-20200813
i386                 randconfig-a014-20200813
i386                 randconfig-a016-20200811
i386                 randconfig-a011-20200811
i386                 randconfig-a015-20200811
i386                 randconfig-a013-20200811
i386                 randconfig-a012-20200811
i386                 randconfig-a014-20200811
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
